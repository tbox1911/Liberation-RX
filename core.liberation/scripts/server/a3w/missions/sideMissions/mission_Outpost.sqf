if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_grp_defenders", "_grp_sentry", "_prisoners"];

_setupVars = {
	_missionType = "STR_OUTPOST";
	_locationsArray = nil;
	_precise_marker = false;
	_missionTimeout = (45 * 60);
};

_setupObjects = {
	private _all_possible_sectors = ([SpawnMissionMarkers] call checkSpawn) apply { _x select 0 };
	if (count _all_possible_sectors == 0) exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
    	false;
	};
	_missionPos = [_all_possible_sectors, 40] call F_findFlatPlace;
	if (count _missionPos == 0) exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
    	false;
	};

	_base_output = [_missionPos, false, true, true] call createOutpost;
	_vehicles = _base_output select 0;
	//_objectives = _base_output select 1;
	_grp_defenders = _base_output select 2;
	_grp_sentry = _base_output select 3;
	_prisoners = _base_output select 4;

	_aiGroup = _grp_sentry;
	[_missionPos, 30] call createlandmines;
	_missionHintText = ["STR_OUTPOST_MESSAGE1", sideMissionColor];

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
