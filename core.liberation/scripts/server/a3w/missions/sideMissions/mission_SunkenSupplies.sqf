// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_SunkenSupplies.sqf
//	@file Author: JoSchaap, AgentRev

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_box1", "_box2", "_vehicle", "_boxPos", "_aiGroup", "_unit"];

_setupVars =
{
	_missionType = "Sunken Supplies";
	_locationsArray = SunkenMissionMarkers;
};

_setupObjects =
{
	_createVehicle = {
		params ["_type", "_position", "_direction", "_aiGroup"];
		_veh_array = [_position, _direction, _type, _aiGroup] call bis_fnc_spawnvehicle;
		_vehicle = _veh_array select 0;
		_vehicle setVariable ["R3F_LOG_disabled", true, true];
		_vehicle addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		_vehicle
	};
	_missionPos = markerPos _missionLocation;

	_box1 = [ammobox_o_typename, _missionPos, true] call boxSetup;
	_box2 = [ammobox_o_typename, _missionPos, true] call boxSetup;

	{
		_boxPos = getPosASL _x;
		_boxPos set [2, getTerrainHeightASL _boxPos + 1];
		_x setPos _boxPos;
		_x setDir random 360;
	} forEach [_box1, _box2];

	_nbUnits = 6;
	_aiGroup = createGroup [GRLIB_side_enemy, true];
	[_aiGroup, _missionPos, _nbUnits, "divers"] call createCustomGroup;
	_vehicle = ["O_Boat_Armed_01_hmg_F", _missionPos, 0, _aiGroup] call _createVehicle;

	_missionPicture = getText (configFile >> "CfgVehicles" >> "O_Boat_Armed_01_hmg_F" >> "picture");
	_missionHintText = "Sunken supplies have been spotted in the ocean near the marker, and are heavily guarded. Diving gear and an underwater weapon are recommended.";
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
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
	_successHintMessage = "The sunken supplies have been collected, well done.";
};

_this call sideMissionProcessor;
