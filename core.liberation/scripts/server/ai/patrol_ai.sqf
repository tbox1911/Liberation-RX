params ["_grp", "_targetpos", ["_radius", 80]];
if (isNil "_grp") exitWith {};
if (isNull _grp) exitWith {};

sleep 10;
if (isNil "_targetpos") then { _targetpos = getPos (leader _grp) };

private ["_waypoint"];
private _completion_radius = (_radius/4) max 0;
private _vehicle = objectParent (leader _grp);
if (_vehicle isKindOf "Air") then { _completion_radius = 300 };

private _patrol_in_water = surfaceIsWater _targetpos;
if (_vehicle isKindOf "Ship_F") then {
	_targetpos = getPosATL _vehicle;
	_patrol_in_water = true;
};

private _patrolcorners = [
	[ (_targetpos select 0) - _radius, (_targetpos select 1) - _radius, 0 ],
	[ (_targetpos select 0) + _radius, (_targetpos select 1) - _radius, 0 ],
	[ (_targetpos select 0) + _radius, (_targetpos select 1) + _radius, 0 ],
	[ (_targetpos select 0) - _radius, (_targetpos select 1) + _radius, 0 ]
];

[_grp] call F_deleteWaypoints;

private _prev = _patrolcorners select 0;
{
	_pos = _x;
	if (_patrol_in_water) then {
		if (surfaceIsWater _pos) then {
			_waypoint = _grp addWaypoint [_pos, 0];
			_waypoint setWaypointType "MOVE";
			_waypoint setWaypointBehaviour "AWARE";
			_waypoint setWaypointCombatMode "YELLOW";
			_waypoint setWaypointSpeed "LIMITED";
			_waypoint setWaypointCompletionRadius _completion_radius;
		};
	} else {
		if (!surfaceIsWater _pos && !([_pos, _prev] call F_isWaterBetween)) then {
			_waypoint = _grp addWaypoint [_pos, 30];
			_waypoint setWaypointType "MOVE";
			_waypoint setWaypointBehaviour "AWARE";
			_waypoint setWaypointCombatMode "YELLOW";
			_waypoint setWaypointSpeed "LIMITED";
			_waypoint setWaypointCompletionRadius _completion_radius;
			_prev = _pos;
		};
	};
} foreach _patrolcorners;

if (count (waypoints _grp) > 1) then {
	_wp0 = waypointPosition [_grp, 0];
	_waypoint = _grp addWaypoint [_wp0, 0];
	_waypoint setWaypointType "CYCLE";

	if (isNull _vehicle) then {
		(leader _grp) doMove _wp0;
	} else {
		(driver _vehicle) doMove _wp0;
	};
};

{_x doFollow (leader _grp)} foreach units _grp;
