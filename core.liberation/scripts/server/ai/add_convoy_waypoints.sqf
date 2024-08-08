params ["_grp", "_convoy_destinations"];
if (isNil "_grp" || count _convoy_destinations == 0) exitWith {};
if (isNull _grp) exitWith {};

private ["_waypoint", "_wp0"];

// Waypoints
_grp setFormation "COLUMN";
_grp setBehaviourStrong "AWARE";
_grp setCombatMode "GREEN";
_grp setSpeedMode "LIMITED";

// behaviour on waypoints
[_grp] call F_deleteWaypoints;
{
    _waypoint = _grp addWaypoint [_x, 0];
    _waypoint setWaypointType "MOVE";
    _waypoint setWaypointFormation "COLUMN";
    _waypoint setWaypointBehaviour "AWARE";
    _waypoint setWaypointCombatMode "GREEN";
    _waypoint setWaypointSpeed "LIMITED";
    _waypoint setWaypointCompletionRadius 200;
} forEach _convoy_destinations;

if (count (waypoints _grp) > 1) then {
	_wp0 = waypointPosition [_grp, 0];
	_waypoint = _grp addWaypoint [_wp0, 0];
	_waypoint setWaypointType "CYCLE";
};
