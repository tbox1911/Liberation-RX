params ["_grp"];
private ["_waypoint", "_basepos", "_nearestroad"];
if (isNull _grp) exitWith {};

[_grp] call F_deleteWaypoints;

_civveh = objectParent (leader _grp);
if (isNull _civveh) then {
	_basepos = getPosATL (leader _grp);
	_waypoint = _grp addWaypoint [_basepos, GRLIB_sector_size];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointCombatMode "BLUE";
	_waypoint setWaypointCompletionRadius 10;
	_waypoint = _grp addWaypoint [_basepos, GRLIB_sector_size];
	_waypoint setWaypointType "MOVE";
	_waypoint = _grp addWaypoint [_basepos, GRLIB_sector_size];
	_waypoint setWaypointType "MOVE";
	_waypoint = _grp addWaypoint [_basepos, GRLIB_sector_size];
	_waypoint setWaypointType "MOVE";
	_waypoint = _grp addWaypoint [_basepos, GRLIB_sector_size];
	_waypoint setWaypointType "CYCLE";
} else {
	_basepos = getPosATL _civveh;
	private _sectors_patrol = [];
	{
		if ( (_basepos distance (markerpos _x) < 5000) && (count ([markerPos _x, 4000] call F_getNearbyPlayers) > 0) ) then {
			_sectors_patrol pushback _x;
		};
	} foreach (sectors_bigtown + sectors_capture + sectors_factory);

	private _sectors_patrol_random = [];
	private _sectorcount = count _sectors_patrol;
	if (_sectorcount > 5) then { _sectorcount = 5 };

	while { count _sectors_patrol_random < _sectorcount } do {
		private _nextsector = selectRandom _sectors_patrol;
		_sectors_patrol_random pushback _nextsector;
		_sectors_patrol = _sectors_patrol - [_nextsector];
	};

	// todo: water waypoints
	{
		_nearestroad = [ [markerPos _x, floor(random 100), random 360] call BIS_fnc_relPos, 200, [] ] call BIS_fnc_nearestRoad;
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
	} foreach _sectors_patrol_random;

	_waypoint = _grp addWaypoint [ _basepos, 100 ];
	_waypoint setWaypointType "CYCLE";
};
{_x doFollow leader _grp} foreach units _grp;
