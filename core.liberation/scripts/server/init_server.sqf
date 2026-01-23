diag_log "--- Server Init start ---";

GRLIB_players_known_uid = [];

// Server EventHandler
addMissionEventHandler ["PlayerConnected", {
	params ["_id", "_uid", "_name", "_jip", "_owner", "_idStr"];
	if (_id != 2 && !(_uid in GRLIB_players_known_uid)) then {
		GRLIB_players_known_uid pushBackUnique _uid;
	};
}];

addMissionEventHandler ["PlayerDisconnected", {
	params ["_id", "_uid", "_name", "_jip", "_owner", "_idstr"];
	if (_name select [0,3] in ["HC1","HC2","HC3"]) exitWith {
		deleteMarker "fpsmarkerHC1";
		deleteMarker "fpsmarkerHC2";
		deleteMarker "fpsmarkerHC3";
	};
	[_uid, _name] spawn {
		params ["_uid", "_name"];
		sleep 0.1; // Wait for HandleDisconnect to finish
		// diag_log format ["--- LRX EH-PD: player %1 (%2) disconnected...", _name, _uid];
		if (_uid in GRLIB_players_known_uid) then {
			[_uid] call cleanup_uid;
			GRLIB_players_known_uid = GRLIB_players_known_uid - [_uid];
		};
	};
	false;
}];

addMissionEventHandler ['HandleDisconnect', {
	params ["_unit", "_id", "_uid", "_name"];
	diag_log format ["--- LRX Info: player %1 (%2) disconnected...", _name, _uid];
	if (_uid in GRLIB_players_known_uid) then {
		[_unit, _uid, true] call save_context;
		[_unit, _uid] call cleanup_player;
	};
	false;
}];

addMissionEventHandler ["MPEnded", {
	if (!isDedicated) exitWith {};
	diag_log "--- LRX Mission End ---";
	if (time < 300) then {
		diag_log format ["--- LRX Saving cooldown (no save done), %1sec remaining...", round (300 - time)];
	} else {
		[] call save_game_mp;
	};
}];

GRLIB_active_commander = objNull;
publicVariable "GRLIB_active_commander";

addMissionEventHandler ["OnUserAdminStateChanged", {
	params ["_networkId", "_loggedIn", "_votedIn"];
	if (_loggedIn) then {
		GRLIB_active_commander = (_networkId getUserInfo 10);
		publicVariable "GRLIB_active_commander";
		[true] remoteExec ["player_admin_actions", owner GRLIB_active_commander];
	} else {
		[false] remoteExec ["player_admin_actions", owner GRLIB_active_commander];
		private _commander = (allPlayers select {(typeOf _x == commander_classname)});
		if (count _commander > 0) then {
			GRLIB_active_commander = _commander select 0;
		} else {
			GRLIB_active_commander = objNull;
			{unassignCurator _x} forEach allCurators;
		};
		publicVariable "GRLIB_active_commander";
	};
}];

// AI Skill
// skillMin, skillAimMin, skillMax, skillAimMax
[
 true,
 [
  [GRLIB_side_friendly, 0.52, 0.36, 0.81, 0.64 ],
  [GRLIB_side_enemy,    0.52, 0.36, 0.81, 0.64 ]
 ]
] call BIS_fnc_EXP_camp_dynamicAISkill;

// Terrain Quality / View Distance
// Low = 50 (NoGrass), Low = 40 (Grass), Normal = 25, High = 12.5, Very High = 6.25, Ultra = 3.125
if (isDedicated) then {
	setTerrainGrid 25;
	setViewDistance 1600;
	setObjectViewDistance [1000, 500];
};

// Relationship
civilian setFriend [GRLIB_side_friendly, 1];
civilian setFriend [GRLIB_side_enemy, 1];

GRLIB_side_friendly setFriend [civilian, 1];
GRLIB_side_enemy setFriend [civilian, 1];

GRLIB_side_enemy setFriend [GRLIB_side_friendly, 0];
GRLIB_side_friendly setFriend [GRLIB_side_enemy, 0];

// Init owner on map vehicles
{
	if (_x iskindof "LandVehicle" || _x iskindof "Air" || _x iskindof "Ship_F") then {
		_x removeAllMPEventHandlers "MPKilled";
		_x addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		if (isNil {_x getVariable "GRLIB_vehicle_owner"} ) then {
			_x setVehicleLock "UNLOCKED";
			_x setVariable ["GRLIB_vehicle_owner", "public", true];
		};
	};
} foreach vehicles;

// Init owner on user placed objects
{
	if (getObjectType _x >= 8 && !(_x iskindof "CAManBase")) then {
		if (isNil {_x getVariable "GRLIB_vehicle_owner"} ) then {
			_x setVariable ["GRLIB_vehicle_owner", "server", true];
		};
	};
} forEach (allMissionObjects "");

if (!([] call F_getValid)) exitWith {};

[] call load_game_mp;
if (abort_loading) exitWith {
	GRLIB_init_server = false;
	publicVariable "GRLIB_init_server";
	publicVariable "abort_loading";
	publicVariable "abort_loading_msg";
};

// Execute server Managers
[] execVM "scripts\server\game\synchronise_vars.sqf";
[] execVM "scripts\server\game\apply_saved_scores.sqf";
[] execVM "scripts\server\base\fobbox_manager.sqf";
[] execVM "scripts\server\base\huron_manager.sqf";
[] execVM "scripts\server\game\spawn_radio_towers.sqf";
[] execVM "scripts\server\game\hall_of_fame.sqf";
[] execVM "scripts\server\battlegroup\counter_battlegroup.sqf";
[] execVM "scripts\server\battlegroup\random_battlegroups.sqf";
[] execVM "scripts\server\battlegroup\readiness_decrease.sqf";
[] execVM "scripts\server\resources\manage_resources.sqf";
[] execVM "scripts\server\patrols\civilian_patrols.sqf";
[] execVM "scripts\server\patrols\enemy_patrols.sqf";
[] execVM "scripts\server\sector\lose_sectors.sqf";
[] execVM "scripts\server\game\manage_score.sqf";
[] execVM "scripts\server\game\manage_time.sqf";
[] execVM "scripts\server\game\manage_weather.sqf";
[] execVM "scripts\server\game\init_marker.sqf";
[] execVM "scripts\server\game\manage_undercover.sqf";
[] execVM "scripts\server\base\fob_markers.sqf";
[] execVM "scripts\server\secondary\autostart.sqf";
[] execVM "scripts\server\game\zeus_synchro.sqf";
[] execVM "scripts\server\game\clean.sqf";
[] execVM "scripts\server\game\periodic_save.sqf";
[] execVM "scripts\server\a3w\init_missions.sqf";
[] execVM "scripts\server\offloading\show_fps.sqf";
[] execVM "scripts\server\wildlife\manage_wildlife.sqf";
[] execVM "scripts\server\sector\static_manager.sqf";
[] execVM "scripts\server\sector\sector_markers_manager.sqf";

// Offloading
[] execVM "scripts\server\offloading\offload_calculation.sqf";
[] execVM "scripts\server\offloading\offload_manager.sqf";

// Manage sectors
GRLIB_sector_spawning = false;
publicVariable "GRLIB_sector_spawning";
if (GRLIB_Commander_mode) then {
	// Commander functions
	manage_sectors_commander = compileFinal preprocessFileLineNumbers "scripts\server\sector\manage_sectors_commander.sqf";
	commander_voteHandler = compileFinal preprocessFileLineNumbers "scripts\server\sector\commander_sector_vote.sqf";
	// Commander mode
	GRLIB_connectMarkers = createHashMap;
	GRLIB_Sector_Votes = createHashMap;
	[] spawn manage_sectors_commander;
	[] spawn commander_voteHandler;
} else {
	// Classic mode
	[] execVM "scripts\server\sector\manage_sectors.sqf";
};

global_locked_group = [];
publicVariable "global_locked_group";

sleep 2;
GRLIB_init_server = true;
publicVariable "GRLIB_init_server";
diag_log "--- Server Init stop ---";
