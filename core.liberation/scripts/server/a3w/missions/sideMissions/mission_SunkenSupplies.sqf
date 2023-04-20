// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_SunkenSupplies.sqf

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_box1", "_box2", "_boxPos"];

_setupVars =
{
	_missionType = localize "STR_SUNKEN";
	_locationsArray = [SunkenMissionMarkers] call checkSpawn;
	_nbUnits = [] call getNbUnits;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_box1 = [ammobox_o_typename, _missionPos, true] call boxSetup;
	_box2 = [ammobox_o_typename, _missionPos, true] call boxSetup;
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
	{
		_boxPos = getPosASL _x;
		_boxPos set [2, getTerrainHeightASL _boxPos + 1];
		_x setPos _boxPos;
		_x setDir random 360;
	} forEach [_box1, _box2];


>>>>>>> 5fea71b4 (a3w and waypoints)
	_vehicle = [_missionPos, "O_Boat_Armed_01_hmg_F", true] call F_libSpawnVehicle;
=======
	_vehicle = [_missionPos, selectRandom boats_east, true] call F_libSpawnVehicle;
>>>>>>> 2e014cca (add opfor building)
=======
	_vehicle = [_missionPos, selectRandom opfor_boats, true] call F_libSpawnVehicle;
>>>>>>> 21c28667 (boat name)
	_aiGroup = createGroup [GRLIB_side_enemy, true];
	[_aiGroup, _missionPos, _nbUnits, "divers", true] call createCustomGroup;
	(crew _vehicle) joinSilent _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> "O_Boat_Armed_01_hmg_F" >> "picture");
	_missionHintText = localize "STR_SUNKEN_MESSAGE1";
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
	{
		_x setVariable ["R3F_LOG_disabled", false, true];
		_x setVariable ["GRLIB_vehicle_owner", nil, true];
	} forEach [_box1, _box2];
	_successHintMessage = localize "STR_SUNKEN_MESSAGE2";
};

_this call sideMissionProcessor;
