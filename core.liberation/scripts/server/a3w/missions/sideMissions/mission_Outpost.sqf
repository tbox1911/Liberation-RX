// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_Outpost.sqf

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_objects"];

_setupVars = {
	_missionType = "Enemy Outpost";
	_locationsArray = [SpawnMissionMarkers] call checkSpawn;
};

_setupObjects = {
	_missionPos = markerPos _missionLocation;
	private _base_output = [_missionPos, false, true] call createOutpost;
	_objects = _base_output select 0;
	//_objectives = _base_output select 1;
	_aiGroup = _base_output select 2;

	_missionHintText = format ["An armed <t color='%1'>Outpost</t> containing weapon crates has been spotted near the marker, Go capture it!", sideMissionColor];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec = {
	// Mission failed
	{ deleteVehicle _x } forEach _objects;
	{ moveOut _x; deleteVehicle _x } forEach units _aiGroup;
};

_successExec = {
	// Mission complete
	_successHintMessage = "The outpost has been Captured!, Good Work.";
	for "_i" from 1 to 3 do {
		_box = selectRandom [ammobox_b_typename, ammobox_o_typename, ammobox_i_typename, fuelbarrel_typename];
		[_box, _missionPos, false] call boxSetup;
	};

	{
		if (typeOf _x isKindof "AllVehicles") then {
			_x setVariable ["GRLIB_vehicle_owner", "", true];
			_x lock 0;
		};
	} foreach _objects;

	[_objects, _missionPos] spawn {
		sleep 300;
		{
			if (count (crew _x) == 0 && (_x getVariable ["GRLIB_vehicle_owner", ""] == "")) then {
				deleteVehicle _x;
			};
		} forEach (_this select 0);

		{ deleteVehicle _x } forEach ([nearestObjects [(_this select 1), ["Ruins_F"], 100], { getObjectType _x == 8 }] call BIS_fnc_conditionalSelect);
		{ _x setPos (getPos _x) } forEach ([allDeadMen, { _x distance2D (_this select 1) < GRLIB_sector_size }] call BIS_fnc_conditionalSelect);
	};
};

_this call sideMissionProcessor;
