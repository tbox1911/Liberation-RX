params ["_grp", "_is_infantry"];

if ( isNil "reinforcements_sector_under_attack" ) then { reinforcements_sector_under_attack = "" };

while { count (units _grp) > 0 } do {

	if ( reinforcements_sector_under_attack != "" ) then {

		while {(count (waypoints _grp)) != 0} do {deleteWaypoint ((waypoints _grp) select 0);};
		{_x doFollow leader _grp} foreach units _grp;

		_waypoint = _grp addWaypoint [markerpos reinforcements_sector_under_attack, 50];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointSpeed "FULL";
		_waypoint setWaypointBehaviour "AWARE";
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointCompletionRadius 30;
		_waypoint = _grp addWaypoint [markerpos reinforcements_sector_under_attack, 50];
		_waypoint setWaypointSpeed "LIMITED";
		_waypoint setWaypointType "SAD";
		_waypoint = _grp addWaypoint [markerpos reinforcements_sector_under_attack, 50];
		_waypoint setWaypointSpeed "LIMITED";
		_waypoint setWaypointType "SAD";
		_waypoint = _grp addWaypoint [markerpos reinforcements_sector_under_attack, 50];
		_waypoint setWaypointSpeed "LIMITED";
		_waypoint setWaypointType "CYCLE";

		sleep 300;
	};

	if ( reinforcements_sector_under_attack == "" ) then {
		_sectors_patrol = [];
		_patrol_startpos = getpos (leader _grp);
		_sector_radius = 2000;
		_sector_list = (sectors_allSectors - blufor_sectors - sectors_tower);
		_max_waypoints = 4;  // + back to startpos and cycle

		if (_is_infantry) then {
			_sector_radius = 600;
			_a3w_missions = [];
			{_a3w_missions pushBack ( _x select 0 )} foreach (SpawnMissionMarkers + ForestMissionMarkers);
			_sector_list = (sectors_allSectors + _a3w_missions - blufor_sectors );
			_max_waypoints = 5;
		};

		private _max_try = 5;
		while { count _sectors_patrol != _max_waypoints && _max_try > 0} do {
			_start_pos =  [_sector_list, _patrol_startpos] call BIS_fnc_nearestPosition;
			_sectors_patrol = [_start_pos, _sector_radius, _sector_list, _max_waypoints] call F_getSectorPath;
			_sector_radius = _sector_radius + 150;
			_max_try = _max_try - 1;
		};

		while {(count (waypoints _grp)) != 0} do {deleteWaypoint ((waypoints _grp) select 0);};
		{_x doFollow leader _grp} foreach units _grp;

		{
			_waypoint = _grp addWaypoint [markerpos _x, 300];
			_waypoint setWaypointType "MOVE";
			_waypoint setWaypointSpeed "NORMAL";
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

	waitUntil { sleep 5;(count (units _grp) == 0) || (reinforcements_sector_under_attack != "") };
};