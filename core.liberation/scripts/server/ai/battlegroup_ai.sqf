params ["_grp", "_objective_pos"];
private ["_waypoint", "_objective_sector"];

while { ({alive _x} count (units _grp) > 0) && ( GRLIB_endgame == 0 ) } do {

	sleep 5;
	_objective_sector = [GRLIB_sector_size, _objective_pos, blufor_sectors] call F_getNearestSector;
	if (_objective_sector != "") then {
		_objective_pos = markerPos _objective_sector;
		[_objective_pos] remoteExec ["remote_call_incoming", 0];

		[_grp] call F_deleteWaypoints;
		{_x doFollow leader _grp} foreach units _grp;

		_waypoint = _grp addWaypoint [_objective_pos, 100];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointSpeed "NORMAL";
		_waypoint setWaypointBehaviour "AWARE";
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointCompletionRadius 50;

		_waypoint = _grp addWaypoint [_objective_pos, 100];
		_waypoint setWaypointType "SAD";
		_waypoint = _grp addWaypoint [_objective_pos, 50];
		_waypoint setWaypointType "SAD";
		_waypoint = _grp addWaypoint [_objective_pos, 20];
		_waypoint setWaypointType "HOLD";
		//_waypoint = _grp addWaypoint [_objective_pos, 100];
		//_waypoint setWaypointType "CYCLE";
		sleep 30;

		_timer = round (time + (15 * 60));
		waitUntil {sleep 5; ({alive _x} count (units _grp) == 0) || !(_objective_sector in blufor_sectors) || time > _timer };

	};

	sleep 5;
	if (getPosATL (leader _grp) distance2D _objective_pos > GRLIB_spawn_max || !(_objective_sector in blufor_sectors) || _objective_sector == "") then {
		{
			if (!isNull objectParent _x) then { deleteVehicle (objectParent _x) };
			deleteVehicle _x;
			sleep 0.1;
		} foreach units _grp;
		deleteGroup _grp;
	};
};