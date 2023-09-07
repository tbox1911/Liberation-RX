params ["_grp", "_flagpos", ["_radius", 100]];
private ["_basepos", "_waypoint"];
if (isNil "_grp") exitWith {};

[_grp] call F_deleteWaypoints;

private _grp_veh = objectParent (leader _grp);
private _unarmed = (currentWeapon _grp_veh == "");
if (!isNull _grp_veh && _unarmed) exitWith {
	private _nearest_sector = [opfor_sectors, _grp_veh] call F_nearestPosition;
	private _waypoint = _grp addWaypoint [markerPos _nearest_sector, 0];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "FULL";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointCombatMode "WHITE";
	_waypoint setWaypointCompletionRadius 200;
	_waypoint setWaypointStatements ["true", "[vehicle this] spawn clean_vehicle"];
	{_x doFollow leader _grp} foreach units _grp;
};

private _patrol_in_water = false;
if (surfaceIsWater _flagpos) then { _patrol_in_water = true; _radius = 60 };

private _patrolcorners = [
	[ (_flagpos select 0) - _radius, (_flagpos select 1) - _radius, 0 ],
	[ (_flagpos select 0) + _radius, (_flagpos select 1) - _radius, 0 ],
	[ (_flagpos select 0) + _radius, (_flagpos select 1) + _radius, 0 ],
	[ (_flagpos select 0) - _radius, (_flagpos select 1) + _radius, 0 ]
];

private _completion_radius = 50;
if (_grp_veh isKindOf "Air") then { _completion_radius = 150 };

{
	if (_patrol_in_water) then {
		_waypoint = _grp addWaypoint [_x, 0];
	} else {
		if (surfaceIsWater _x) then {
			_waypoint = _grp addWaypoint [_flagpos, _radius];
		} else {
			_waypoint = _grp addWaypoint [_x, 0];
		};
	};
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointBehaviour "AWARE";
	_waypoint setWaypointCombatMode "WHITE";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointCompletionRadius _completion_radius;
} foreach _patrolcorners;

_waypoint = _grp addWaypoint [(_patrolcorners select 0), 0];
_waypoint setWaypointType "CYCLE";
{_x doFollow (leader _grp)} foreach units _grp;

waitUntil {
	sleep 60;
	_basepos = (leader _grp) findNearestEnemy (leader _grp);
	if (!isNull _basepos) then {
		[_grp] call F_deleteWaypoints;
		_waypoint = _grp addWaypoint [_basepos, _radius];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointBehaviour "AWARE";
		_waypoint setWaypointCombatMode "WHITE";
		_waypoint setWaypointSpeed "LIMITED";
		_waypoint = _grp addWaypoint [_basepos, _radius];
		_waypoint setWaypointType "SAD";
		_waypoint = _grp addWaypoint [_basepos, _radius];
		_waypoint setWaypointType "SAD";
		_waypoint = _grp addWaypoint [_basepos, _radius];
		_waypoint setWaypointType "CYCLE";
		{_x doFollow leader _grp} foreach units _grp;
		sleep 300;
	};	

	( { alive _x } count (units _grp) == 0 )
};
