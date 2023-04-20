params ["_grp", "_infantry"];
private ["_waypoint", "_objectivepos", "_startpos"];

if (isNil "reset_battlegroups_ai" ) then { reset_battlegroups_ai = false };

while { ( count units _grp != 0 ) && ( GRLIB_endgame == 0 ) } do {

	sleep (3 + floor(random 5));

	_objectivepos = ([getPosATL (leader _grp)] call F_getNearestBluforObjective) select 0;

	[ _objectivepos ] remoteExec ["remote_call_incoming", 0];

	_startpos = getPosATL (leader _grp);

	while { ((getPosATL (leader _grp)) distance2D _startpos) < 100 } do {

		while {(count (waypoints _grp)) != 0} do {deleteWaypoint ((waypoints _grp) select 0);};
		{_x doFollow leader _grp} foreach units _grp;

		_startpos = getPosATL (leader _grp);

		_waypoint = _grp addWaypoint [_objectivepos, 100];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointSpeed "NORMAL";
		_waypoint setWaypointBehaviour "AWARE";
		_waypoint setWaypointCombatMode "YELLOW";
		_waypoint setWaypointCompletionRadius 30;

		_waypoint = _grp addWaypoint [_objectivepos, 100];
		_waypoint setWaypointType "SAD";
		_waypoint = _grp addWaypoint [_objectivepos, 100];
		_waypoint setWaypointType "SAD";
		_waypoint = _grp addWaypoint [_objectivepos, 100];
		_waypoint setWaypointType "SAD";
		_waypoint = _grp addWaypoint [_objectivepos, 100];
		_waypoint setWaypointType "CYCLE";

		sleep 180;
	};

	waitUntil {
		sleep 5;
		( { alive _x } count (units _grp) == 0) || reset_battlegroups_ai;
	};
	sleep (3 + floor(random 5));
	reset_battlegroups_ai = false;
};