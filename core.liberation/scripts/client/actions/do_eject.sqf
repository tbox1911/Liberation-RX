params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

_crew = crew _vehicle;
_grp = group (_crew select 0);
_crew allowGetIn false;
{
	if (alive _x && lifeState _x != "INCAPACITATED") then {
		unassignVehicle _x;
		commandGetOut _x;
		doGetOut _x;
	} else {
		moveOut _x;
	};
} forEach _crew;

if (side _grp == GRLIB_side_civilian) then {
	hintSilent "Warning !!\n -5 pts Malus for Ejecting Civilian.";
	playSound "vtolAlarm";
	[player, -5] call F_addScore;

	_sectors_patrol = [];
	_patrol_startpos = getpos (leader _grp);
	{
		if ( _patrol_startpos distance (markerpos _x) < 2500) then {
			_sectors_patrol pushBack _x;
		};
	} foreach (sectors_allSectors);

	while {(count (waypoints _grp)) != 0} do {deleteWaypoint ((waypoints _grp) select 0);};
	{_x doFollow leader _grp} foreach units _grp;

	{
		_waypoint = _grp addWaypoint [markerpos _x, 300];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointSpeed "LIMITED";
		_waypoint setWaypointBehaviour "AWARE";
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointCompletionRadius 30;
	} foreach _sectors_patrol;

	_waypoint = _grp addWaypoint [_patrol_startpos, 300];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointCompletionRadius 100;
	_waypoint = _grp addWaypoint [_patrol_startpos , 300];
	_waypoint setWaypointType "CYCLE";
};