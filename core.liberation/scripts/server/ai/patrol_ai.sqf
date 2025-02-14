params ["_grp", "_flagpos", "_radius"];
if (isNil "_grp" || isNil "_flagpos") exitWith {};
if (isNull _grp) exitWith {};

private ["_waypoint"];
private _completion_radius = (_radius/4);
private _grp_veh = objectParent (leader _grp);
if (_grp_veh isKindOf "Air") then { _completion_radius = 250 };

private _patrol_in_water = surfaceIsWater _flagpos;
if (_grp_veh isKindOf "Ship") then {
	_flagpos = getPosATL _grp_veh;
	_patrol_in_water = true;
};

private _patrolcorners = [
	[ (_flagpos select 0) - _radius, (_flagpos select 1) - _radius, 0 ],
	[ (_flagpos select 0) + _radius, (_flagpos select 1) - _radius, 0 ],
	[ (_flagpos select 0) + _radius, (_flagpos select 1) + _radius, 0 ],
	[ (_flagpos select 0) - _radius, (_flagpos select 1) + _radius, 0 ]
];

[_grp] call F_deleteWaypoints;
{
	if (_patrol_in_water) then {
		if (surfaceIsWater _x) then {
			_waypoint = _grp addWaypoint [_x, 0];
			_waypoint setWaypointType "MOVE";
			_waypoint setWaypointBehaviour "AWARE";
			_waypoint setWaypointCombatMode "WHITE";
			_waypoint setWaypointSpeed "LIMITED";
			_waypoint setWaypointCompletionRadius _completion_radius;
		};
	} else {
		if (!surfaceIsWater _x) then {
			_waypoint = _grp addWaypoint [_x, 30];
			_waypoint setWaypointType "MOVE";
			_waypoint setWaypointBehaviour "AWARE";
			_waypoint setWaypointCombatMode "WHITE";
			_waypoint setWaypointSpeed "LIMITED";
			_waypoint setWaypointCompletionRadius _completion_radius;
		};
	};
} foreach _patrolcorners;

if (count (waypoints _grp) > 1) then {
	_wp0 = waypointPosition [_grp, 0];
	_waypoint = _grp addWaypoint [_wp0, 0];
	_waypoint setWaypointType "CYCLE";
};
