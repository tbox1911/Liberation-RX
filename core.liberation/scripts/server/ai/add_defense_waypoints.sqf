params ["_grp", "_flagpos", ["_radius", 200]];
private ["_basepos", "_waypoint"];
if (isNil "_grp") exitWith {};

private _patrolcorners = [
	[ (_missionPos select 0) - _radius, (_missionPos select 1) - _radius, 0 ],
	[ (_missionPos select 0) + _radius, (_missionPos select 1) - _radius, 0 ],
	[ (_missionPos select 0) + _radius, (_missionPos select 1) + _radius, 0 ],
	[ (_missionPos select 0) - _radius, (_missionPos select 1) + _radius, 0 ]
];

while {(count (waypoints _grp)) != 0} do {deleteWaypoint ((waypoints _grp) select 0)};
sleep 1;
{
	_waypoint = _grp addWaypoint [_x, 20];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointBehaviour "AWARE";
	_waypoint setWaypointCombatMode "GREEN";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointCompletionRadius 5;
} foreach _patrolcorners;

_waypoint = _grp addWaypoint [(_patrolcorners select 0), 0];
_waypoint setWaypointType "CYCLE";
{_x doFollow (leader _grp)} foreach units _grp;

waitUntil {
	sleep 10;
	( { alive _x } count (units _grp) == 0 ) || !(isNull ((leader _grp) findNearestEnemy (leader _grp)))
};

if ( { alive _x } count (units _grp) > 0 ) then {
	while {(count (waypoints _grp)) != 0} do { deleteWaypoint ((waypoints _grp) select 0) };
	sleep 1;
	{_x doFollow leader _grp} foreach units _grp;
	sleep 1;

	_basepos = getpos (leader _grp);
	_waypoint = _grp addWaypoint [_basepos, _radius];
	_waypoint setWaypointType "SAD";
	_waypoint setWaypointBehaviour "COMBAT";
	_waypoint setWaypointCombatMode "GREEN";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint = _grp addWaypoint [_basepos, _radius];
	_waypoint setWaypointType "SAD";
	_waypoint = _grp addWaypoint [_basepos, _radius];
	_waypoint setWaypointType "SAD";
	_waypoint = _grp addWaypoint [_basepos, _radius];
	_waypoint setWaypointType "SAD";
	_waypoint = _grp addWaypoint [_basepos, _radius];
	_waypoint setWaypointType "CYCLE";
};