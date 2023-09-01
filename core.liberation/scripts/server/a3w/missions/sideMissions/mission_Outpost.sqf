// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_Outpost.sqf

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_grpdefenders", "_grpsentry", "_grpprisonners"];

_setupVars = {
	_missionType = "STR_OUTPOST";
	_locationsArray = [SpawnMissionMarkers] call checkSpawn;
	_precise_marker = false;
};

_setupObjects = {
	_missionPos = markerpos _missionLocation;  // getPos [100, random 360]
	_base_output = [_missionPos, false, true] call createOutpost;
	_vehicles = _base_output select 0;
	//_objectives = _base_output select 1;
	_grpdefenders = _base_output select 2;
	_grpsentry = _base_output select 3;
	_aiGroup = _grpdefenders;
	[_missionPos, 30] call createlandmines;
	_missionHintText = ["STR_OUTPOST_MESSAGE1", sideMissionColor];

	_grpprisonners = createGroup [GRLIB_side_enemy, true];
	for "_i" from 0 to 3 do {
		_pilotsPos = _missionPos getPos [10, random 360];
		pilot_classname createUnit [_pilotsPos, _grpprisonners, 'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]', 0.5, "private"];
		sleep 0.3;
	};
	{ [_x, true, false] spawn prisonner_ai } foreach (units _grpprisonners);
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = { 
	private _ret = false;
	if ({alive _x} count (units _grpprisonners) == 0) then {
		_failedHintMessage = ["STR_OUTPOST_MESSAGE_FAIL", sideMissionColor];
		_ret = true;
	};
	_ret;	
};
_waitUntilSuccessCondition = { ({side group _x == GRLIB_side_friendly} count (units _grpprisonners) > 0) };

_failedExec = {
	{ deleteVehicle _x } forEach units _grpdefenders;
	{ deleteVehicle _x } forEach units _grpsentry;
	{ deleteVehicle _x } forEach units _grpprisonners;
	[_missionPos] call clearlandmines;
};

_successExec = {
	// Mission complete
	_successHintMessage = "STR_OUTPOST_MESSAGE2";
	for "_i" from 1 to 2 do {
		_box = selectRandom [fuelbarrel_typename, ammobox_b_typename, ammobox_o_typename, ammobox_i_typename, fuelbarrel_typename];
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
		private _radius = 150;
		{ deleteVehicle _x } forEach ([nearestObjects [_pos, ["Ruins_F"], _radius], { getObjectType _x == 8 }] call BIS_fnc_conditionalSelect);
		sleep 3;
		{ _x setPos (getPos _x) } forEach ([allDeadMen, { _x distance2D _pos <= _radius }] call BIS_fnc_conditionalSelect);
		{ _x setPos (getPos _x) } forEach ([nearestObjects [_pos, ["GroundWeaponHolder", "WeaponHolderSimulated"], _radius], { getObjectType _x == 8 }] call BIS_fnc_conditionalSelect);
	};
	[_missionPos] call showlandmines;
};

_this call sideMissionProcessor;
