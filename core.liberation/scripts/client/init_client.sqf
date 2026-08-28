diag_log "--- Client wait for Server init ---";

waitUntil {
	titleText [localize "STR_TITLE_LOADING", "BLACK FADED", 100];
	sleep 1;
	titleText [localize "STR_TITLE_PLEASE_WAIT", "BLACK FADED", 100];
	sleep 1;
	(!isNil "GRLIB_init_server")
};
titleText ["", "BLACK FADED", 100];

diag_log "--- Client Init start ---";

// Game life / details
setTerrainGrid 25;
initAmbientLife;
enableEnvironment [true, true];

// Local Constants
R3F_LOG_joueur_deplace_objet = objNull;
GRLIB_player_spawned = false;
GRLIB_player_is_menuok = false;
GRLIB_vehicle_lock = true;
GRLIB_arsenal_open = false;

GRLIB_ActionDist_3 = 3;
GRLIB_ActionDist_5 = 5;
GRLIB_ActionDist_10 = 10;
GRLIB_ActionDist_15 = 15;
GRLIB_current_trenches = 0;

GRLIB_InfantryBuildType = 1;
GRLIB_TransportVehicleBuildType = 2;
GRLIB_CombatVehicleBuildType = 3;
GRLIB_AerialBuildType = 4;
GRLIB_DefenceBuildType = 5;
GRLIB_BuildingBuildType = 6;
GRLIB_SupportBuildType = 7;
GRLIB_SquadBuildType = 8;
GRLIB_TrenchBuildType = 9;
GRLIB_BuildTypeDirect = 90;

// Server Init Error
if (abort_loading) exitWith {
	private _msg = format [localize "STR_MSG_SERVER_STARTUP_ERROR", abort_loading_msg];
	titleText [_msg, "BLACK FADED", 100];
	diag_log abort_loading_msg;
	sleep 10;
	endMission "LOSER";
	disableUserInput false;
};

// Player Validations
PAR_Grp_ID = getPlayerUID player;
if (PAR_Grp_ID == "" || !(isPlayer player)) exitWith {
	private _msg = localize "STR_MSG_SERVER_INIT_ERROR";
	titleText [_msg, "BLACK FADED", 100];
	sleep 10;
	endMission "LOSER";
	disableUserInput false;
};

// Enforce White list
GRLIB_is_Commander = (player getvariable ["GRLIB_is_Commander", false]);
[] call compileFinal preprocessFileLineNumbers "scripts\client\commander\enforce_whitelist.sqf";

private _name = name player;
if (toLower _name in GRLIB_blacklisted_names || (_name == str parseNumber _name) || (count trim _name <= 2)) exitWith {
	private _msg = format [localize "STR_NAME_PROHIBITED", _name];
	titleText [_msg, "BLACK FADED", 100];
	sleep 10;
	endMission "LOSER";
	disableUserInput false;
};

// LRX_Template mod version check
waitUntil {sleep 0.5; !isNil "GRLIB_LRX_Template_version"};
private _version_checked = true;
if (!isNil "LRX_Template_version") then {
	if (typeName LRX_Template_version == "SCALAR") then {
		if (GRLIB_LRX_Template_version != 0 && GRLIB_LRX_Template_version != LRX_Template_version) then {
			_version_checked = false;
		};
	};
};
if (!_version_checked) exitWith {
	private _msg = localize "STR_MSG_INVALID_LRXMOD_VERSION";
	titleText [_msg, "BLACK FADED", 100];
	sleep 10;
	endMission "LOSER";
	disableUserInput false;
};

waitUntil {sleep 0.5; !isNil "GRLIB_global_stop"};
if (GRLIB_global_stop == 1) exitWith {
	private _msg = localize "STR_MSG_FINAL_MISSION_RUNNING";
	titleText [_msg, "BLACK FADED", 100];
	sleep 10;
	endMission "LOSER";
	disableUserInput false;
};

waitUntil {sleep 0.5; !isNil "GRLIB_endgame"};
if (GRLIB_endgame == 1) exitWith {
	private _msg = localize "STR_MSG_END_GAME";
	titleText [_msg, "BLACK FADED", 100];
	sleep 10;
	endMission "LOSER";
	disableUserInput false;
};

if (GRLIB_kick_idle > 0) then {
	[] execVM "scripts\client\misc\kick_idle.sqf";
};

if (GRLIB_respawn_cooldown > 0) then {
	if (isServer) exitWith {};
	waitUntil {sleep 1; !isNil "BTC_logic"};
	private _cooldown = BTC_logic getVariable [format ["%1_last_respawn", PAR_Grp_ID], 0];
	if (_cooldown > time) then {
		while { time < _cooldown } do {
			private _msg = format [localize "STR_MSG_RESPAWN_COOLDOWN", round (_cooldown - time)];
			titleText [_msg, "BLACK FADED", 100];
			sleep 2;
		};
		titleText ["", "BLACK FADED", 100];
	};
};

if (typeOf player == "VirtualSpectator_F") exitWith {
	[] execVM "scripts\client\markers\vehicles_marker.sqf";
	[] execVM "scripts\client\markers\hostile_groups.sqf";
	[] execVM "scripts\client\ui\ui_manager.sqf";
};

// Player Setup
if (!([] call F_getValid)) exitWith {endMission "LOSER"};
[player] call player_EHP;
[player, objNull] spawn player_respawn;

// Player Scripts
LRX_init_done = false;
LRX_arsenal_init_done = false;
GRLIB_player_configured = false;
GRLIB_action_player_ready = false;
build_confirmed = -1;
startgame = 0;
[] spawn {
	waituntil {
		titleText ["... Loading Player Data ...", "BLACK FADED", 100];
		sleep 1;
		titleText [localize "STR_TITLE_PLEASE_WAIT", "BLACK FADED", 100];
		sleep 1;
		(LRX_init_done);
	};
};

// Create Player Group
GRLIB_player_group = createGroup [GRLIB_side_friendly, true];
[GRLIB_player_group, "add"] remoteExec ["addel_group_remote_call", 2];
waitUntil { sleep 1; player getVariable ["GRLIB_score_set", 0] == 1 && player in (units GRLIB_player_group) };

[] call compileFinal preprocessFileLineNumbers "addons\VAM\RPT_init_client.sqf";

// LRX Arsenal
diag_log "--- LRX: Build Arsenal Classnames ---";
[] call compileFinal preprocessFileLineNumbers "addons\LARs\default_classnames.sqf";
[] spawn compileFinal preprocessFileLineNumbers "addons\LARs\liberationArsenal.sqf";
waitUntil { sleep 1; LRX_arsenal_init_done };

// LRX Addons
[] execVM "addons\PAR\PAR_AI_Revive.sqf";
[] execVM "addons\RPL\advancedRappellingInit.sqf";
[] execVM "addons\KEY\shortcut_init.sqf";
[] execVM "addons\VAM\VAM_GUI_init.sqf";
[] execVM "addons\TARU\taru_init.sqf";
[] execVM "addons\VIRT\virtual_garage_init.sqf";
[] execVM "addons\SELL\sell_shop_init.sqf";
[] execVM "addons\LOG\ai_logistic_init.sqf";
[] execVM "addons\SHOP\traders_shop_init.sqf";
[] execVM "addons\TAXI\taxi_init.sqf";
[] execVM "addons\JKB\JKB_init.sqf";
[] execVM "addons\WHS\warehouse_init.sqf";
[] execVM "addons\FOB\officer_init.sqf";
[] execVM "addons\TXU\txu_init.sqf";

[] call compile preprocessFileLineNumbers "GREUH\scripts\GREUH_version.sqf";
[] call compile preprocessFileLineNumbers "scripts\client\markers\init_markers.sqf";
LRX_init_done = true;
sleep 2;

// Start intro
diag_log "--- Client Intro start ---";
[] execVM "scripts\client\ui\intro.sqf";

// Init actions
[] execVM "scripts\client\actions\action_manager_player.sqf";
[] execVM "scripts\client\build\build_manager.sqf";
waitUntil {sleep 1; (GRLIB_player_configured && GRLIB_action_player_ready && build_confirmed == 0)};

// Player actions manager
[] execVM "scripts\client\actions\action_manager_veh.sqf";
[] execVM "scripts\client\actions\recycle_manager.sqf";
[] execVM "scripts\client\actions\intel_manager.sqf";
[] execVM "scripts\client\actions\dog_manager.sqf";
[] execVM "scripts\client\actions\man_manager.sqf";
[] execVM "scripts\client\actions\squad_manager.sqf";
//[] execVM "scripts\client\misc\shoot_walls.sqf";

// LRX client scripts
[] execVM "GREUH\scripts\GREUH_activate.sqf";
[] execVM "scripts\client\ui\ui_manager.sqf";
[] execVM "scripts\client\build\build_overlay.sqf";

// Markers
[] execVM "scripts\client\markers\players_marker.sqf";
[] execVM "scripts\client\markers\vehicles_marker.sqf";
[] execVM "scripts\client\markers\hostile_groups.sqf";
[] execVM "scripts\client\commander\commander_marker.sqf";
//[] execVM "scripts\client\markers\logs_markers.sqf";

// Local Manager
[] execVM "scripts\client\manager\box_manager.sqf";
[] execVM "scripts\client\manager\manage_manpower.sqf";
[] execVM "scripts\client\manager\support_manager.sqf";
[] execVM "scripts\client\manager\vehicle_fuel_manager.sqf";
[] execVM "scripts\client\manager\sides_stats_manager.sqf";
[] execVM "scripts\client\manager\speak_manager_data.sqf";
[] execVM "scripts\client\commander\commander_manager.sqf";

// Misc
[] execVM "scripts\client\misc\secondary_jip.sqf";
[] execVM "scripts\client\misc\player_behavior.sqf";
[] execVM "scripts\client\misc\no_thermic.sqf";

// ACE inCompatible addons
if (!GRLIB_ACE_enabled) then {
	[] execVM "addons\NRE\NRE_init.sqf";
	[] execVM "addons\MGR\MagRepack_init.sqf";
};

// Init Tips Tables from XML
GRLIB_TipsText = [];
{
	if (_x select [0, 1] != "t" && _x != "br") then {
    	GRLIB_TipsText pushback (_x select [7]);
	};
} forEach ((localize "STR_TUTO_TEXT12") splitString "></");
GRLIB_LastNews = 0;

// Draw Zeus
{ [_x] call BIS_fnc_drawCuratorLocations } foreach allCurators;

// Draw3D Mission EventHandler
[] execVM "scripts\client\ui\mission_EH.sqf";

// kart support
{
	if (typeOf _x isKindOf "Kart_01_Base_F") then {
		_x addAction ["<t color='#00F880'>Enter Kart</t> <img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\car_ca.paa'/>",{ (_this select 1) moveInDriver (_this select 0) },"",999,true,true,"","GRLIB_player_is_menuok",5];
	};
} foreach vehicles;

// Local Save Game support
if (isServer && hasInterface) then {
	(findDisplay 46) displayAddEventHandler ["Unload",{
		diag_log "--- LRX Local Save Game ---";
		if (!(player diarySubjectExists str(parseText GRLIB_r3))) exitWith {};
		[player, PAR_Grp_ID, true] call save_context;
		[player, PAR_Grp_ID] call cleanup_player;
		[] call save_game_mp;
	 }];
};

diag_log "--- Client Init stop ---";
