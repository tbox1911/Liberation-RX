if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_box1", "_box2"];

_setupVars = {
	_missionType = "STR_SUNKEN";
	_locationsArray = [SunkenMissionMarkers] call checkSpawn;
	_nbUnits = [] call getNbUnits;
	_precise_marker = false;
};

_setupObjects = {
	_missionPos = markerpos _missionLocation;
	_vehicle = [_missionPos, selectRandom opfor_boats, 0, GRLIB_side_enemy, "", true, true] call F_libSpawnVehicle;
	_aiGroup = [_missionPos, _nbUnits, "divers", true] call createCustomGroup;
	(crew _vehicle) joinSilent _aiGroup;
	_box1 = [ammobox_o_typename, _missionPos, true] call boxSetup;
	_box2 = [ammobox_o_typename, _missionPos, true] call boxSetup;
	_missionPicture = getText (configFile >> "CfgVehicles" >> "O_Boat_Armed_01_hmg_F" >> "picture");
	_missionHintText = "STR_SUNKEN_MESSAGE1";
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec = {
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2];
};

_successExec = {
	// Mission completed
	{ [_x, "abandon"] call F_vehicleLock } forEach [_box1, _box2];
	_successHintMessage = "STR_SUNKEN_MESSAGE2";
};

_this call sideMissionProcessor;
