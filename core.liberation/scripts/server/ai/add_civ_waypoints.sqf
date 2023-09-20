params ["_grp"];
private ["_waypoint", "_basepos", "_nearestroad", "_radius", "_nextpos"];
if (isNull _grp) exitWith {};

[_grp] call F_deleteWaypoints;

private _civveh = objectParent (leader _grp);
private _max_try = 100;

if (isNull _civveh) then {
	_basepos = getPosATL (leader _grp);
	while { (count (waypoints _grp) <= 4) && _max_try > 0} do {
		_radius = GRLIB_capture_size + ([[-50,0,50], 3] call F_getRND);
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
	if (count (waypoints _grp) > 0) then {
		_waypoint = _grp addWaypoint [_basepos, 0];
		_waypoint setWaypointType "CYCLE";
	};
} else {
	_basepos = getPosATL _civveh;
	private _sectors_patrol = [];
	{
		if ((_basepos distance (markerpos _x) < 5000) && (count ([markerPos _x, 4000] call F_getNearbyPlayers) > 0)) then {
			_sectors_patrol pushback _x;
		};
	} foreach (sectors_bigtown + sectors_capture + sectors_factory + SpawnMissionMarkers + SunkenMissionMarkers);

	if (count _sectors_patrol > 0) then {
		_sectors_patrol = _sectors_patrol call BIS_fnc_arrayShuffle;

		if (_civveh isKindOf "Ship") then {
			{
				if (count (waypoints _grp) <= 5) then {
					diag_log ["scan sector", _x];
					_markerpos = markerPos _x;
					_nextpos = _markerpos;
					_max_try = 100;
					while { !(surfaceIsWater _nextpos) && _max_try > 0 && _nextpos distance2D _markerpos > 4000 } do {
						_nextpos = _markerpos getPos [GRLIB_sector_size, random 360];
						_max_try = _max_try - 1;
					};

					if (surfaceIsWater _nextpos) then {
						_waypoint = _grp addWaypoint [_nextpos, 0];
						_waypoint setWaypointType "MOVE";
						_waypoint setWaypointSpeed "NORMAL";
						_waypoint setWaypointBehaviour "SAFE";
						_waypoint setWaypointCombatMode "BLUE";
						_waypoint setWaypointCompletionRadius 20;
					};
				};
			} foreach _sectors_patrol;

			if (count (waypoints _grp) > 0) then {
				_waypoint = _grp addWaypoint [_basepos, 0];
				_waypoint setWaypointType "CYCLE";
			};
		} else {
			{
				if (count (waypoints _grp) <= 5) then {
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

			if (count (waypoints _grp) > 0) then {
				_waypoint = _grp addWaypoint [_basepos, 100];
				_waypoint setWaypointType "CYCLE";
			};
		};
	};
};
{_x doFollow leader _grp} foreach units _grp;
