diag_log "--- Client Init start ---";

titleText ["-- Liberation RX --","BLACK FADED", 100];
waitUntil {
	sleep 2;
	titleText ["... Loading ...","BLACK FADED", 100];
	sleep 2;
	titleText ["... Please Wait ...", "BLACK FADED", 100];
	(!isNil "GRLIB_init_server")
};
titleText ["", "BLACK FADED", 100];

R3F_LOG_joueur_deplace_objet = objNull;
GRLIB_player_spawned = false;
GRLIB_player_is_menuok = false;
GRLIB_vehicle_lock = true;
GRLIB_arsenal_open = false;

if (abort_loading) exitWith {
	private _msg = format ["Sorry, An error occured on Server startup.\nPlease check the error logs.\n\n%1", abort_loading_msg];
	titleText [_msg, "BLACK FADED", 100];
	diag_log abort_loading_msg;
	uisleep 10;
	endMission "LOSER";
};

PAR_Grp_ID = getPlayerUID player;
if (PAR_Grp_ID == "" || !(isPlayer player)) exitWith {
	private _msg = format ["ARMA3 Multiplayer Initialization Error!\nPlease reconnect to the server..."];
	titleText [_msg, "BLACK FADED", 100];
	uisleep 10;
	endMission "LOSER";
};

if (!isMultiplayer) exitWith {
	private _msg = format ["Sorry, Liberation RX is a Multiplayer Mission Only..."];
	titleText [_msg, "BLACK FADED", 100];
	uisleep 10;
	endMission "LOSER";
};

GRLIB_Player_VIP = (PAR_Grp_ID in GRLIB_whitelisted_steamids);
if (GRLIB_use_exclusive && !([] call is_admin || GRLIB_Player_VIP)) exitWith {
	private _msg = format ["Sorry, Invalid SteamID!\nDue to server configuration, you MUST be authorized to connect.\nPlease contact the server administrator."];
	titleText [_msg, "BLACK FADED", 100];
	uisleep 10;
	endMission "LOSER";
};

private _commander_check = [] call compileFinal preprocessFileLineNumbers "scripts\client\commander\enforce_whitelist.sqf";
if (!_commander_check) exitWith { endMission "END1" };

private _name = name player;
if (toLower _name in GRLIB_blacklisted_names || (_name == str parseNumber _name) || (count trim _name <= 2)) exitWith {
	private _msg = format [localize "STR_NAME_PROHIBITED", _name];
	titleText [_msg, "BLACK FADED", 100];
	uisleep 10;
	endMission "LOSER";
};

playMusic GRLIB_music_startup;

waitUntil {sleep 1; !isNil "GRLIB_global_stop"};
if (GRLIB_global_stop == 1) exitWith {
	private _msg = "The Final Mission is running...\nNew connections are prohibited until the end!";
	titleText [_msg, "BLACK FADED", 100];
	uisleep 10;
	endMission "LOSER";
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
			private _msg = format ["You Reconnect or Respawn too fast!\nPlease Wait %1 sec.", round (_cooldown - time)];
			titleText [_msg, "BLACK FADED", 100];
			sleep 2;
		};
		titleText ["", "BLACK FADED", 100];
	};
};

GRLIB_ActionDist_3 = 3;
GRLIB_ActionDist_5 = 5;
GRLIB_ActionDist_10 = 10;
GRLIB_ActionDist_15 = 15;

add_player_actions = compile preprocessFileLineNumbers "scripts\client\actions\add_player_actions.sqf";
dog_bark = compileFinal preprocessFileLineNumbers "scripts\client\actions\dog_bark.sqf";
do_onboard = compileFinal preprocessFileLineNumbers "scripts\client\actions\do_onboard.sqf";
do_redeploy = compileFinal preprocessFileLineNumbers "scripts\client\actions\do_redeploy.sqf";
do_dog = compileFinal preprocessFileLineNumbers "scripts\client\actions\do_dog.sqf";
do_build_unit = compileFinal preprocessFileLineNumbers "scripts\client\actions\do_build_unit.sqf";
do_build_squad = compileFinal preprocessFileLineNumbers "scripts\client\actions\do_build_squad.sqf";
spawn_camera = compileFinal preprocessFileLineNumbers "scripts\client\spawn\spawn_camera.sqf";
paraDrop = compileFinal preprocessFileLineNumbers "scripts\client\spawn\paraDrop.sqf";
cinematic_camera = compileFinal preprocessFileLineNumbers "scripts\client\ui\cinematic_camera.sqf";
write_credit_line = compileFinal preprocessFileLineNumbers "scripts\client\ui\write_credit_line.sqf";
set_rank = compileFinal preprocessFileLineNumbers "scripts\client\misc\set_rank.sqf";
set_sticky_bomb = compileFinal preprocessFileLineNumbers "scripts\client\misc\set_sticky_bomb.sqf";
artillery_cooldown = compileFinal preprocessFileLineNumbers "scripts\client\misc\artillery_cooldown.sqf";
vehicle_permissions = compileFinal preprocessFileLineNumbers "scripts\client\misc\vehicle_permissions.sqf";
vehicle_fuel = compileFinal preprocessFileLineNumbers "scripts\client\misc\vehicle_fuel.sqf";
vehicle_defense = compileFinal preprocessFileLineNumbers "scripts\client\misc\vehicle_defense.sqf";
fetch_permission = compileFinal preprocessFileLineNumbers "scripts\client\misc\fetch_permission.sqf";
is_menuok = compileFinal preprocessFileLineNumbers "scripts\client\misc\is_menuok.sqf";
is_menuok_veh = compileFinal preprocessFileLineNumbers "scripts\client\misc\is_menuok_veh.sqf";
is_neartransport = compileFinal preprocessFileLineNumbers "scripts\client\misc\is_neartransport.sqf";
is_allowed_item = compileFinal preprocessFileLineNumbers "scripts\client\misc\is_allowed_item.sqf";
get_player_name = compileFinal preprocessFileLineNumbers "scripts\client\misc\get_player_name.sqf";
save_loadout_cargo = compileFinal preprocessFileLineNumbers "scripts\client\misc\save_loadout_cargo.sqf";
speak_manager = compileFinal preprocessFileLineNumbers "scripts\client\misc\speak_manager.sqf";
save_personal_arsenal = compileFinal preprocessFileLineNumbers "scripts\client\actions\save_personal_arsenal.sqf";


if (!([] call F_getValid)) exitWith {endMission "LOSER"};
if ( typeOf player == "VirtualSpectator_F" ) exitWith {
	[] execVM "scripts\client\markers\empty_vehicles_marker.sqf";
	[] execVM "scripts\client\markers\fob_markers.sqf";
	[] execVM "scripts\client\markers\hostile_groups.sqf";
	[] execVM "scripts\client\markers\huron_marker.sqf";
	[] execVM "scripts\client\markers\sector_manager.sqf";
	[] execVM "scripts\client\markers\spot_timer.sqf";
	[] execVM "scripts\client\ui\ui_manager.sqf";
};

// Start intro
[] spawn compileFinal preprocessFileLineNumbers "scripts\client\ui\intro.sqf";

private _grp = createGroup [GRLIB_side_friendly, true];
waitUntil {
	[player] joinSilent _grp;
	sleep 0.5;
	(side group player == GRLIB_side_friendly);
};
[_grp, "add"] remoteExec ["addel_group_remote_call", 2];

// Markers
GRLIB_MapOpen = false;
addMissionEventHandler ["Map", {
	params ["_mapIsOpened", "_mapIsForced"];
	GRLIB_MapOpen = _mapIsOpened;
}];

// LRX client scripts
[] execVM "GREUH\scripts\GREUH_activate.sqf";
[] execVM "scripts\client\ui\ui_manager.sqf";
[] execVM "scripts\client\build\do_build.sqf";
[] execVM "scripts\client\build\build_overlay.sqf";
[] execVM "scripts\client\actions\action_manager.sqf";
[] execVM "scripts\client\actions\action_manager_veh.sqf";
[] execVM "scripts\client\actions\recycle_manager.sqf";
[] execVM "scripts\client\actions\intel_manager.sqf";
[] execVM "scripts\client\actions\dog_manager.sqf";
[] execVM "scripts\client\actions\man_manager.sqf";
[] execVM "scripts\client\actions\squad_manager.sqf";
[] execVM "scripts\client\misc\support_manager.sqf";
[] execVM "scripts\client\misc\sides_stats_manager.sqf";
[] execVM "scripts\client\misc\secondary_jip.sqf";
[] execVM "scripts\client\misc\stop_renegade.sqf";
[] execVM "scripts\client\misc\manage_manpower.sqf";
[] execVM "scripts\client\misc\no_thermic.sqf";
[] execVM "scripts\client\misc\init_markers.sqf";
[] execVM "scripts\client\misc\speak_manager_data.sqf";
[] execVM "scripts\client\markers\empty_vehicles_marker.sqf";
[] execVM "scripts\client\markers\fob_markers.sqf";
[] execVM "scripts\client\markers\hostile_groups.sqf";
[] execVM "scripts\client\markers\huron_marker.sqf";
[] execVM "scripts\client\markers\spot_timer.sqf";
[] execVM "scripts\client\markers\sector_manager.sqf";
//[] execVM "scripts\client\misc\logs_markers.sqf";

// LRX Addons
[] execVM "addons\PAR\PAR_AI_Revive.sqf";
[] execVM "addons\KEY\shortcut_init.sqf";
[] execVM "addons\VAM\VAM_GUI_init.sqf";
[] execVM "addons\TARU\taru_init.sqf";
[] execVM "addons\VIRT\virtual_garage_init.sqf";
[] execVM "addons\SELL\sell_shop_init.sqf";
[] execVM "addons\SHOP\traders_shop_init.sqf";
[] execVM "addons\TAXI\taxi_init.sqf";
[] execVM "addons\JKB\JKB_init.sqf";
[] execVM "addons\WHS\warehouse_init.sqf";
[] execVM "addons\FOB\officer_init.sqf";

// LRX Arsenal
[] call compileFinal preprocessFileLineNumbers "addons\LARs\liberationArsenal.sqf";

// ACE inCompatible addons
if (!GRLIB_ACE_enabled) then {
	[] execVM "addons\NRE\NRE_init.sqf";
	[] execVM "addons\MGR\MagRepack_init.sqf";
};

// Init Tips Tables from XML
GREUH_TipsText = [];
{
	if (_x select [0, 1] != "t" && _x != "br") then {
    	GREUH_TipsText pushback (_x select [7]);
	};
} forEach ((localize "STR_TUTO_TEXT12") splitString "></");

// Draw Zeus
{
	[_x] call BIS_fnc_drawCuratorLocations;
} foreach allCurators;

// Sign Add
addMissionEventHandler ["Draw3D",{
	private _pos = ASLToAGL getPosASL chimera_sign;
	if (player distance2D _pos <= 30) then {
		drawIcon3D ["", [1,1,1,1], _pos vectorAdd [0, 0, 3], 0, 0, 0, "- READ ME -", 2, 0.05, "TahomaB"];
	};

	private _near_sign = nearestObjects [player, [FOB_sign], 5];
	if (count (_near_sign) > 0 && (player distance2D lhd > GRLIB_fob_range)) then {
		private _sign = _near_sign select 0;
		private _gid = _sign getVariable ["GRLIB_vehicle_owner", "public"];
		private _type = "FOB";
		private _near_outpost = ([_sign, "OUTPOST", 30] call F_check_near);
		if (_near_outpost) then { _type = "Outpost" };
		private _name = "- LRX";
		if (_gid != "public") then {
			_name = GRLIB_player_scores select { _x select 0 == _gid } select 0 select 5;
		};
		drawIcon3D ["", [1,1,1,1], (ASLToAGL getPosASL _sign) vectorAdd [0, 0, 2.5], 0, 0, 0, format ["- %1 %2 -", _type, _name], 2, 0.07, "RobotoCondensed", "center"];
	};
	private _near_box = nearestObjects [player, [playerbox_typename], 2];
	if (count (_near_box) > 0) then {
		private _box = _near_box select 0;
		private _box_pos = ASLToAGL getPosASL _box;
		private _gid = _box getVariable ["GRLIB_vehicle_owner", ""];
		private _name = GRLIB_player_scores select { _x select 0 == _gid } select 0 select 5;
		drawIcon3D ["", [1,1,1,1], _box_pos vectorAdd [0, 0, 1], 2, 2, 0, format ["- %1 Personal Box -", _name], 2, 0.05, "RobotoCondensed", "center"];
	};
}];

// kart support
{
	if (typeOf _x isKindOf "Kart_01_Base_F") then {
		_x addAction ["<t color='#00F880'>Enter Kart</t> <img size='1' image='\a3\ui_f\data\igui\cfg\simpletasks\types\car_ca.paa'/>",{ (_this select 1) moveInDriver (_this select 0) },"",999,true,true,"","GRLIB_player_is_menuok",5];
	};
} foreach vehicles;

if (isServer && hasInterface) then {
	(findDisplay 46) displayAddEventHandler ["Unload",{
		diag_log "--- LRX Local MP support";
		[player, PAR_Grp_ID, true] call save_context;
		[player, PAR_Grp_ID] call cleanup_player;
		[true] call save_game_mp;
	 }];
};

initAmbientLife;
enableEnvironment [true, true];

diag_log "--- Client Init stop ---";
