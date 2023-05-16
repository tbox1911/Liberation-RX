params ["_grp", "_objective_pos"];
private ["_waypoint", "_objective_sector"];

while { ({alive _x} count (units _grp) > 0) && ( GRLIB_endgame == 0 ) } do {

	sleep 5;

	if (getPosATL (leader _grp) distance2D _objective_pos > GRLIB_spawn_max * 2) exitWith {
		{ deleteVehicle _x } foreach units _grp;
		deleteGroup _grp;
	};

	_objective_sector = [100, _objective_pos, blufor_sectors] call F_getNearestSector;

	[ _objective_pos ] remoteExec ["remote_call_incoming", 0];

	while {(count (waypoints _grp)) != 0} do {deleteWaypoint ((waypoints _grp) select 0);};
	{_x doFollow leader _grp} foreach units _grp;

	_waypoint = _grp addWaypoint [_objective_pos, 100];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "NORMAL";
	_waypoint setWaypointBehaviour "AWARE";
	_waypoint setWaypointCombatMode "YELLOW";
	_waypoint setWaypointCompletionRadius 50;

	_waypoint = _grp addWaypoint [_objective_pos, 100];
	_waypoint setWaypointType "SAD";
	_waypoint = _grp addWaypoint [_objective_pos, 100];
	_waypoint setWaypointType "SAD";
	_waypoint = _grp addWaypoint [_objective_pos, 100];
	_waypoint setWaypointType "SAD";
	_waypoint = _grp addWaypoint [_objective_pos, 100];
	_waypoint setWaypointType "CYCLE";

	sleep 30;

	waitUntil {sleep 5; ({alive _x} count (units _grp) == 0) || !(_objective_sector in blufor_sectors)};

};