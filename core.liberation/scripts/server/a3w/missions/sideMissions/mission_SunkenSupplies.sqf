// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_SunkenSupplies.sqf

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_box1", "_box2", "_vehicle", "_boxPos"];

_setupVars =
{
	_missionType = "Sunken Supplies";
	_locationsArray = [SunkenMissionMarkers] call checkSpawn;
	_nbUnits = [] call getNbUnits;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_box1 = [ammobox_o_typename, _missionPos, true] call boxSetup;
	_box2 = [ammobox_o_typename, _missionPos, true] call boxSetup;
	_vehicle = [_missionPos, selectRandom opfor_boats, true] call F_libSpawnVehicle;
	_aiGroup = createGroup [GRLIB_side_enemy, true];
	[_aiGroup, _missionPos, _nbUnits, "divers", true] call createCustomGroup;
	(crew _vehicle) joinSilent _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> "O_Boat_Armed_01_hmg_F" >> "picture");
	_missionHintText = "Sunken supplies have been spotted in the ocean near the marker, and are heavily guarded. Diving gear and an underwater weapon are recommended.";
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec = {
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _vehicle];
};

_successExec = {
	// Mission completed
	{
		_x setVariable ["R3F_LOG_disabled", false, true];
		_x setVariable ["GRLIB_vehicle_owner", nil, true];
	} forEach [_box1, _box2];
	_successHintMessage = "The sunken supplies have been collected, well done.";
};

_this call sideMissionProcessor;
