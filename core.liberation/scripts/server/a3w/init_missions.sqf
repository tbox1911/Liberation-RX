//--- A3W_Missions
// Stolen from A3 Wasteland by AgenRev
// tweaked to fit in Liberation

if (!isServer) exitWith {};

cityList = compileFinal preprocessFileLineNumbers "scripts\server\a3w\missions\towns.sqf";
fn_selectRandomWeighted = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\fn_selectRandomWeighted.sqf";
fn_refillbox  = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\fn_refillbox.sqf";
checkSpawn = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_checkSpawn.sqf";
checkMissionItems = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_checkMissionItems.sqf";
sideMissionProcessor = compileFinal preprocessFileLineNumbers "scripts\server\a3w\missions\sideMissionProcessor.sqf";
generateMissionWeights = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_generateMissionWeights.sqf";
setMissionState = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_setMissionState.sqf";
getMissionState = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_getMissionState.sqf";
setLocationState = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_setLocationState.sqf";
attemptCompileMissions = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_attemptCompileMissions.sqf";
cleanMissionVehicles = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_cleanMissionVehicles.sqf";
createMissionMarker = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_createMissionMarker.sqf";
createMissionMarkerCiv = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_createMissionMarkerCiv.sqf";
getBallMagazine = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_getBallMagazine.sqf";
processItems = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_processItems.sqf";
updateMissionsList = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_updateMissionsList.sqf";
getNbUnits = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_getNbUnits.sqf";
createOutpost = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_createOutpost.sqf";
debugSpawnMarkers = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_debugSpawnMarkers.sqf";

/*	***  Debug A3W missions ***
	A3W_debug = true;            // Enable debug mode
	A3W_mission = "mission_SearchIntel";   // load mission
	A3W_debug_marker = true;     // debug spawn markers
	A3W_Mission_delay = 1*60;    // Time in seconds between Side Missions
	A3W_Mission_timeout = 5*60;  // Time in seconds that a Side Mission will run for, unless completed
*/

A3W_delivery_failed = 0;
A3W_mission_success = 0;
A3W_mission_failed = 0;
A3W_Mission_timeout = 60*60;
A3W_sectors_in_use = [];
publicVariable "A3W_sectors_in_use";

if (A3W_Mission_count == 0) exitWith {};
waitUntil {sleep 1; !isNil "GRLIB_init_server"};

// moved to init
//[] call compileFinal preprocessFileLineNumbers "scripts\server\a3w\missions\setupMissionArrays.sqf";

for "_i" from 1 to A3W_Mission_count do {
	// Start Permanent controller
	private _init_sleep = ((2 + floor random 10) * 60);
	while {_init_sleep > 0 && isNil "A3W_debug"} do { sleep 1; _init_sleep = _init_sleep - 1 };
	diag_log format ["--- LRX A3W Starting Mission Controller #%1 at %2", _i, time];
	[_i, false] spawn compileFinal preprocessFileLineNumbers "scripts\server\a3w\missions\sideMissionController.sqf";
	sleep 60;
};

diag_log "--- LRX A3W Missions Initialized";