params ["_grp", "_objective_pos"];
private ["_waypoint", "_nearset_fob_name"];

while { ({alive _x} count (units _grp) > 0) && ( GRLIB_endgame == 0 ) } do {
	_objective_pos = zeropos;
	if (GRLIB_global_stop == 0) then {
		private _info = [_objective_pos, true] call F_getNearestBluforObjective;
		if ((_info select 1) <= GRLIB_spawn_max) then { _objective_pos = (_info select 0) };
	};

	if (GRLIB_global_stop == 1) then {
		private _target = selectRandom ((units GRLIB_side_friendly) select { _x distance2D lhd > GRLIB_fob_range && !(typeOf (vehicle _x) in uavs) });
		if !(isNil "_target") then { _objective_pos = getPosATL _target };
	};

	if (_objective_pos isEqualTo zeropos) then {	
		{ 
			if (!isNull objectParent _x) then { [vehicle _x] spawn clean_vehicle };
			deleteVehicle _x 
		} forEach (units _grp);
		deleteGroup _grp;
		sleep 1;
	};

	if (!isNull _grp) then {
		//diag_log format["Battlegroup %1 - Objective %2",_grp, _objective_pos];
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
		_waypoint = _grp addWaypoint [_objective_pos, 100];
		_waypoint setWaypointType "CYCLE";
		{_x doFollow (leader _grp)} foreach units _grp;

		sleep 30;

		_timer = round (time + (5 * 60));
		waitUntil {sleep 5; ({alive _x} count (units _grp) == 0) || time > _timer };
	};
	sleep 1;
};