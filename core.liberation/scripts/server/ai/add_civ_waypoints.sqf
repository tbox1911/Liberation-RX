_grp = _this select 0;
private ["_waypoint"];
while {(count (waypoints _grp)) != 0} do {deleteWaypoint ((waypoints _grp) select 0);};
{_x doFollow leader _grp} foreach units _grp;

_civveh = objectParent (leader _grp);
if (isNull _civveh) then {
	private _basepos = getpos (leader _grp);

	_waypoint = _grp addWaypoint [_basepos, 300];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointCombatMode "BLUE";
	_waypoint setWaypointCompletionRadius 5;

	_waypoint = _grp addWaypoint [_basepos, 300];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointCombatMode "BLUE";
	_waypoint setWaypointCompletionRadius 5;

	_waypoint = _grp addWaypoint [_basepos, 300];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointCombatMode "BLUE";
	_waypoint setWaypointCompletionRadius 5;

	_waypoint = _grp addWaypoint [_basepos, 300];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointCombatMode "BLUE";
	_waypoint setWaypointCompletionRadius 5;

	_waypoint = _grp addWaypoint [_basepos, 300];
	_waypoint setWaypointType "CYCLE";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointCombatMode "BLUE";
	_waypoint setWaypointCompletionRadius 5;
} else {
	private _basepos = getpos _civveh;
	private _sectors_patrol = [];
	{
		if ( (_basepos distance (markerpos _x) < 5000 ) && ( count ( [ getmarkerpos _x , 4000 ] call F_getNearbyPlayers ) > 0 ) ) then {
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

	{
		private _nearestroad = [ [ markerpos (_x), floor(random 100), random 360 ] call BIS_fnc_relPos, 200, [] ] call BIS_fnc_nearestRoad;
		if ( isNull _nearestroad ) then {
			_waypoint = _grp addWaypoint [ markerpos _x, 100 ];
		} else {
			_waypoint = _grp addWaypoint [ getpos _nearestroad, 0 ];
		};
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointSpeed "LIMITED";
		_waypoint setWaypointBehaviour "SAFE";
		_waypoint setWaypointCombatMode "BLUE";
		_waypoint setWaypointCompletionRadius 100;
	} foreach _sectors_patrol_random;

	_waypoint = _grp addWaypoint [ _basepos, 0 ];
	_waypoint setWaypointType "CYCLE";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointCombatMode "BLUE";
	_waypoint setWaypointCompletionRadius 100;
};