//--- A3W_Missions
// Stolen from A3 Wasteland by AgenRev
// tweaked to fit in Liberation

if (!isServer) exitWith {};

cityList = compileFinal preprocessFileLineNumbers "scripts\server\a3w\missions\towns.sqf";
fn_selectRandomWeighted = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\fn_selectRandomWeighted.sqf";
fn_refillbox  = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\fn_refillbox.sqf";
fn_findString = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\fn_findString.sqf";
checkSpawn = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_checkSpawn.sqf";
sideMissionProcessor = compileFinal preprocessFileLineNumbers "scripts\server\a3w\missions\sideMissionProcessor.sqf";
generateMissionWeights = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_generateMissionWeights.sqf";
setMissionState = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_setMissionState.sqf";
getMissionState = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_getMissionState.sqf";
setLocationState = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_setLocationState.sqf";
attemptCompileMissions = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_attemptCompileMissions.sqf";
cleanlocationobjects = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_cleanLocationObjects.sqf";
createMissionMarker = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_createMissionMarker.sqf";
createCustomGroup = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_createCustomGroup.sqf";
getBallMagazine = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_getBallMagazine.sqf";
missionHint = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_missionHint.sqf";
processItems = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_processItems.sqf";
updateMissionsList = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_updateMissionsList.sqf";
getNbUnits = compileFinal preprocessFileLineNumbers "scripts\server\a3w\scripts\F_getNbUnits.sqf";

waitUntil {sleep 1; !isNil "blufor_sectors" };
waitUntil {sleep 1; !isNil "sectors_allSectors" };
waitUntil {sleep 1; !isNil "save_is_loaded" };
[] call compileFinal preprocessFileLineNumbers "scripts\server\a3w\missions\setupMissionArrays.sqf";
diag_log "-- LRX A3W Missions Initialized";

for "_i" from 1 to 4 do {
	// Start Permanent controller
	sleep ((2 + floor random 14) * 60);
	diag_log format ["-- LRX A3W Starting Mission Controller #%1 at %2", _i, time];
	[_i, false] execVM "scripts\server\a3w\missions\sideMissionController.sqf";
};
