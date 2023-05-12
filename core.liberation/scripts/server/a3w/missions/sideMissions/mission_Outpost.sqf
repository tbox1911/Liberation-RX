// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_Outpost.sqf

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_grpdefenders", "_grpsentry"];

_setupVars = {
	_missionType = localize "STR_OUTPOST";
	_locationsArray = [SpawnMissionMarkers] call checkSpawn;
};

_setupObjects = {
	_missionPos = ([markerPos _missionLocation, 100, random 360] call BIS_fnc_relPos);
	private _base_output = [_missionPos, false, true] call createOutpost;
	_vehicles = _base_output select 0;
	//_objectives = _base_output select 1;
	_grpdefenders = _base_output select 2;
	_grpsentry = _base_output select 3;
	_aiGroup = _grpdefenders;
	[_missionPos, 150, floor (random 11)] spawn ied_trap_manager;
	_missionHintText = format [localize "STR_OUTPOST_MESSAGE1", sideMissionColor];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec = {
	{ deleteVehicle _x } forEach units _grpdefenders;
	{ deleteVehicle _x } forEach units _grpsentry;
};

_successExec = {
	// Mission complete
	_successHintMessage = localize "STR_OUTPOST_MESSAGE2";
	for "_i" from 1 to 3 do {
		_box = selectRandom [ammobox_b_typename, ammobox_o_typename, ammobox_i_typename, fuelbarrel_typename];
		[_box, _missionPos, false] call boxSetup;
	};

	{
		if (typeOf _x isKindof "AllVehicles") then {
			_x setVariable ["GRLIB_vehicle_owner", nil, true];
			_x lock 0;
		};
	} foreach _vehicles;

	[_missionPos] spawn {
		params ["_pos"];
		sleep 300;
		{ deleteVehicle _x } forEach ([nearestObjects [_pos, ["Ruins_F"], 100], { getObjectType _x == 8 }] call BIS_fnc_conditionalSelect);
		sleep 3;
		{ _x setPos (getPos _x) } forEach ([allDeadMen, { _x distance2D _pos <= 100 }] call BIS_fnc_conditionalSelect);
		{ _x setPos (getPos _x) } forEach ([nearestObjects [_pos, ["WeaponHolder"], 100], { getObjectType _x == 8 }] call BIS_fnc_conditionalSelect);
	};
};

_this call sideMissionProcessor;
