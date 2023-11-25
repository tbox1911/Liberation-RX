params ["_grp", "_flagpos", ["_radius", 100]];
if (isNil "_grp" || isNil "_flagpos") exitWith {};
if (isNull _grp) exitWith {};

diag_log format ["Group %1 - Defend: %2", _grp, _flagpos];

private ["_basepos", "_waypoint", "_wp0"];
private _grp_veh = objectParent (leader _grp);

private _completion_radius = 50;
if (_grp_veh isKindOf "Air") then { _completion_radius = 150 };

private _patrol_in_water = surfaceIsWater _flagpos;
if (_grp_veh isKindOf "Ship") then {
	_flagpos = getPosATL _grp_veh;
	_patrol_in_water = true;
};
if (_patrol_in_water) then { _radius = 60 };

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
		if !(surfaceIsWater _x) then {
			_waypoint = _grp addWaypoint [_x, 20];
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
{_x doFollow (leader _grp)} foreach units _grp;

if (_grp_veh isKindOf "Ship") exitWith {};

while { ({alive _x} count (units _grp) > 0) && ( GRLIB_endgame == 0 ) } do {
	waitUntil {
		_basepos = (leader _grp) findNearestEnemy (leader _grp);
		if (!isNull _basepos && !_patrol_in_water) then {
			if (_grp_veh isKindOf "Truck_F" && count (crew _grp_veh) > 0 ) then { [_grp] spawn F_ejectGroup };
		};
		sleep 5;
		(!isNull _basepos);
	};

	[_grp] call F_deleteWaypoints;
	_waypoint = _grp addWaypoint [_basepos, _radius];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointBehaviour "AWARE";
	_waypoint setWaypointCombatMode "RED";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint = _grp addWaypoint [_basepos, _radius];
	_waypoint setWaypointType "SAD";
	_waypoint = _grp addWaypoint [_basepos, _radius];
	_waypoint setWaypointType "SAD";
	_waypoint = _grp addWaypoint [_basepos, _radius];
	_waypoint setWaypointType "SAD";
	_waypoint = _grp addWaypoint [_basepos, _radius];
	_waypoint setWaypointType "CYCLE";
	{
		_x doFollow leader _grp;
		[_x] call F_fixPosUnit;
	} foreach units _grp;

	_timer = round (time + (5 * 60));
	waitUntil {sleep 5; ({alive _x} count (units _grp) == 0) || time > _timer };
};
