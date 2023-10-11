params ["_grp", "_objective_pos"];
if (isNil "_grp" || isNil "_objective_pos") exitWith {};
if (isNull _grp) exitWith {};

private ["_waypoint", "_wp0", "_nearset_fob_name"];
diag_log format ["Battlegroup %1 - Objective %2", _grp, _objective_pos];

private _civveh = objectParent (leader _grp);
if (_civveh isKindOf "Ship") exitWith {
	[_grp, getPosATL _civveh] spawn add_defense_waypoints;
};

while { ({alive _x} count (units _grp) > 0) && ( GRLIB_endgame == 0 ) } do {

	if (GRLIB_global_stop == 0) then {
		private _blufor = [_objective_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount;

		if (_blufor == 0) then {
			private _info = [_objective_pos, true] call F_getNearestBluforObjective;
			if ((_info select 1) <= GRLIB_spawn_max) then { _objective_pos = (_info select 0) } else { _objective_pos = zeropos };
		};
	};

	if (GRLIB_global_stop == 1) then {
		private _target = selectRandom ((units GRLIB_side_friendly) select { _x distance2D lhd > GRLIB_fob_range && !(typeOf (vehicle _x) in uavs) });
		if !(isNil "_target") then { _objective_pos = getPosATL _target } else { _objective_pos = zeropos };
	};

	if (_objective_pos isEqualTo zeropos) exitWith {
		// Cleanup
		waitUntil { sleep 30; (GRLIB_global_stop == 1 || [(getPosATL (leader _grp)), GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
		{
			if (!isNull objectParent _x) then { [vehicle _x] call clean_vehicle };
			deleteVehicle _x;
		} forEach (units _grp);
		deleteGroup _grp;
	};

	[_objective_pos] remoteExec ["remote_call_incoming", 0];

	[_grp] call F_deleteWaypoints;

	_waypoint = _grp addWaypoint [_objective_pos, 100];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "NORMAL";
	_waypoint setWaypointBehaviour "AWARE";
	_waypoint setWaypointCombatMode "RED";
	_waypoint setWaypointCompletionRadius 50;
	_waypoint = _grp addWaypoint [_objective_pos, 100];
	_waypoint setWaypointType "SAD";
	_waypoint = _grp addWaypoint [_objective_pos, 100];
	_waypoint setWaypointType "SAD";
	_waypoint = _grp addWaypoint [_objective_pos, 100];
	_waypoint setWaypointType "SAD";

	_wp0 = waypointPosition [_grp, 0];
	_waypoint = _grp addWaypoint [_wp0, 0];
	_waypoint setWaypointType "CYCLE";
	{_x doFollow (leader _grp)} foreach units _grp;
	sleep 30;

	_timer = round (time + (5 * 60));
	waitUntil {sleep 5; ({alive _x} count (units _grp) == 0) || time > _timer };
};