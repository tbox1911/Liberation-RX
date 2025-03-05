params ["_grp", "_targetpos", ["_radius", round (100 + floor random 200)]];
if (isNil "_grp") exitWith {};
if (isNull _grp) exitWith {};
if (isNil "_targetpos") then { _targetpos = getPos (leader _grp) };

private _patrolcorners = [
	[ (_targetpos select 0) - _radius, (_targetpos select 1) - _radius, 0 ],
	[ (_targetpos select 0) + _radius, (_targetpos select 1) - _radius, 0 ],
	[ (_targetpos select 0) + _radius, (_targetpos select 1) + _radius, 0 ],
	[ (_targetpos select 0) - _radius, (_targetpos select 1) + _radius, 0 ]
];

[_grp] call F_deleteWaypoints;

{
	_waypoint = _grp addWaypoint [_x, 30];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointBehaviour "AWARE";
	_waypoint setWaypointCombatMode "YELLOW";
	_waypoint setWaypointSpeed "NORMAL";
	_waypoint setWaypointCompletionRadius 30;
} foreach _patrolcorners;

if (count (waypoints _grp) > 1) then {
	_wp0 = waypointPosition [_grp, 0];
	_waypoint = _grp addWaypoint [_wp0, 0];
	_waypoint setWaypointType "CYCLE";
};
