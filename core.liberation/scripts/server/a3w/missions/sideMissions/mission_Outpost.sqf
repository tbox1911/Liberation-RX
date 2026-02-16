if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_grp_defenders", "_grp_sentry", "_prisoners"];

_setupVars = {
	_missionType = "STR_OUTPOST";
	_locationsArray = [SpawnMissionMarkers] call checkSpawn;
	_precise_marker = false;
	_missionTimeout = (45 * 60);
};

_setupObjects = {
	_missionPos = markerpos _missionLocation;  // getPos [100, random 360]
	if (count _missionPos == 0) exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
    	false;
	};
	_base_output = [_missionPos, false, true] call createOutpost;
	_vehicles = _base_output select 0;
	//_objectives = _base_output select 1;
	_grp_defenders = _base_output select 2;
	_grp_sentry = _base_output select 3;
	_aiGroup = _grp_defenders;
	[_missionPos, 30] call createlandmines;
	_missionHintText = ["STR_OUTPOST_MESSAGE1", sideMissionColor];

	private _grp_prisoners = createGroup [GRLIB_side_civilian, true];
	for "_i" from 0 to 3 do {
		private _unit = _grp_prisoners createUnit [pilot_classname, _missionPos, [], 20, "NONE"];
		_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		[_unit, true, false] spawn prisoner_ai;
		sleep 0.3;
	};
	_prisoners = (units _grp_prisoners);
	_prisoners joinSilent _grp_prisoners;
	private _static_units = [_missionPos, 3, GRLIB_side_enemy, true, "infantry"] call spawn_static;
	_static_units joinSilent _aiGroup;
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = {
	private _ret = false;
	if ({alive _x} count _prisoners == 0) then {
		_failedHintMessage = ["STR_OUTPOST_MESSAGE_FAIL", sideMissionColor];
		_ret = true;
	};
	_ret;
};
_waitUntilSuccessCondition = { ({side group _x == GRLIB_side_friendly} count _prisoners) == ({alive _x} count _prisoners) };

_failedExec = {
	{ deleteVehicle _x } forEach _prisoners + (units _grp_defenders) + (units _grp_sentry);
	[_missionPos] call clearlandmines;
};

_successExec = {
	// Mission complete
	_successHintMessage = "STR_OUTPOST_MESSAGE2";
	for "_i" from 0 to 1 do {
		_box = selectRandom [fuelbarrel_typename, ammobox_b_typename, ammobox_o_typename, ammobox_i_typename, fuelbarrel_typename];
		[_box, _missionPos, false] call boxSetup;
	};

	{
		if (typeOf _x isKindof "AllVehicles") then {
			[_x, "abandon"] call F_vehicleLock;
		};
	} foreach _vehicles;

	[_missionPos] spawn {
		params ["_pos"];
		sleep 300;
		private _radius = 150;
		{ deleteVehicle _x } forEach (nearestObjects [_pos, ["Ruins_F"], _radius] select { getObjectType _x == 8 });
		sleep 3;
		{ _x setPos (getPos _x) } forEach (allDeadMen select { _x distance2D _pos <= _radius });
		{ _x setPos (getPos _x) } forEach (nearestObjects [_pos, ["GroundWeaponHolder", "WeaponHolderSimulated"], _radius] select { getObjectType _x == 8 });
		[_pos] call showlandmines;
		sleep 300;
		[_pos] call clearlandmines;
	};
};

_this call sideMissionProcessor;
