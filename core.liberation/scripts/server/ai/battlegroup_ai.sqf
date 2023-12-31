params ["_grp", "_objective_pos"];
if (isNil "_grp" || isNil "_objective_pos") exitWith {};
if (isNull _grp) exitWith {};

private ["_in_water", "_waypoint", "_wp0", "_next_objective", "_timer"];
diag_log format ["Group %1 - Attack: %2", _grp, _objective_pos];

private _vehicle = objectParent (leader _grp);
if (_vehicle isKindOf "Ship") exitWith {
	[_grp, getPosATL _vehicle] spawn add_defense_waypoints;
};

while { ({alive _x} count (units _grp) > 0) } do {
	_in_water = ({(alive _x && surfaceIsWater (getPos _x) && _x distance2D _objective_pos > 250)} count (units _grp) > 2);
	_next_objective = [_objective_pos, true, GRLIB_sector_size] call F_getNearestBluforObjective;
	if ((_next_objective select 1) <= GRLIB_spawn_max) then { _objective_pos = (_next_objective select 0) } else { _objective_pos = zeropos };

	if (GRLIB_global_stop == 1) then {
		private _target = selectRandom ((units GRLIB_side_friendly) select { _x distance2D lhd > GRLIB_fob_range && !(typeOf (vehicle _x) in uavs) });
		if !(isNil "_target") then { _objective_pos = getPosATL _target } else { _objective_pos = zeropos };
	};

	if (_objective_pos isEqualTo zeropos || _in_water) exitWith {
		// Cleanup
		waitUntil { 
			sleep 30; 
			(GRLIB_global_stop == 1 || ([_objective_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0))
		};
		{
			_veh = objectParent _x;
			if (!isNull _veh) then { [_veh] call clean_vehicle };
			deleteVehicle _x;
		} forEach (units _grp);
		deleteGroup _grp;
	};

	[_objective_pos] remoteExec ["remote_call_incoming", 0];

	[_grp] call F_deleteWaypoints;

	_waypoint = _grp addWaypoint [_objective_pos, 100];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "FULL";
	_waypoint setWaypointBehaviour "COMBAT";
	_waypoint setWaypointCombatMode "RED";
	_waypoint setWaypointCompletionRadius 50;
	_waypoint = _grp addWaypoint [_objective_pos, 100];
	_waypoint setWaypointType "MOVE";
	_waypoint = _grp addWaypoint [_objective_pos, 100];
	_waypoint setWaypointType "MOVE";
	_waypoint = _grp addWaypoint [_objective_pos, 100];
	_waypoint setWaypointType "MOVE";

	_wp0 = waypointPosition [_grp, 0];
	_waypoint = _grp addWaypoint [_wp0, 0];
	_waypoint setWaypointType "CYCLE";
	sleep 1;
	{ _x doFollow (leader _grp) } foreach units _grp;

	if (_vehicle isKindOf "AllVehicles") then {
		(driver _vehicle) doMove _objective_pos;
	};
	sleep 30;

	_timer = round (time + (5 * 60));
	waitUntil {sleep 30; ({alive _x} count (units _grp) == 0) || time > _timer };
};