params ["_grp", "_basepos"];
private ["_waypoint", "_wp0", "_nearestroad", "_radius", "_nextpos"];
if (isNull _grp) exitWith {};

private _civveh = objectParent (leader _grp);
if (_civveh isKindOf "Ship") exitWith { [_grp, getPosATL _civveh, 80] spawn add_defense_waypoints };

[_grp] call F_deleteWaypoints;
private _max_try = 100;

if (isNull _civveh) then {
	while { (count (waypoints _grp) <= 4) && _max_try > 0} do {
		_radius = GRLIB_capture_size + ([[-150,0,80], 0] call F_getRND);
		_nextpos = _basepos getPos [_radius, random 360];
		if !(surfaceIsWater _nextpos) then {
			_waypoint = _grp addWaypoint [_nextpos, 0];
			_waypoint setWaypointType "MOVE";
			_waypoint setWaypointSpeed "LIMITED";
			_waypoint setWaypointBehaviour "SAFE";
			_waypoint setWaypointCombatMode "BLUE";
			_waypoint setWaypointCompletionRadius 20;
		};
		_max_try = _max_try - 1;
	};
} else {
	_basepos = getPosATL _civveh;
	private _sectors_patrol = [];
	{
		if ((_basepos distance (markerpos _x) < GRLIB_spawn_max) && (count ([markerPos _x, GRLIB_spawn_min] call F_getNearbyPlayers) > 0)) then {
			_sectors_patrol pushback _x;
		};
	} foreach (sectors_bigtown + sectors_capture + sectors_factory + sectors_military);

	if (count _sectors_patrol > 0) then {
		_sectors_patrol = _sectors_patrol call BIS_fnc_arrayShuffle;
		{
			if (count (waypoints _grp) <= 4) then {
				_nearestroad = [[markerPos _x, floor(random 100), random 360] call BIS_fnc_relPos, 200, []] call BIS_fnc_nearestRoad;
				if !(surfaceIsWater (getPosATL _nearestroad)) then {
					if ( isNull _nearestroad ) then {
						_waypoint = _grp addWaypoint [ markerpos _x, 100 ];
					} else {
						_waypoint = _grp addWaypoint [ getPosATL _nearestroad, 0 ];
					};
					_waypoint setWaypointType "MOVE";
					_waypoint setWaypointSpeed "LIMITED";
					_waypoint setWaypointBehaviour "SAFE";
					_waypoint setWaypointCombatMode "BLUE";
					_waypoint setWaypointCompletionRadius 100;
				};
			};
		} foreach _sectors_patrol;	
	};
};


if (count (waypoints _grp) > 0) then {
	_wp0 = waypointPosition [_grp, 0];
	_waypoint = _grp addWaypoint [_wp0, 0];
	_waypoint setWaypointType "CYCLE";
};

{_x doFollow leader _grp} foreach units _grp;
