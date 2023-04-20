params ["_grp", "_patrol_type"];

if ( isNil "reinforcements_sector_under_attack" ) then { reinforcements_sector_under_attack = "" };

while { count (units _grp) > 0 } do {

	if (_patrol_type == 3) then {
		private _gunner = units _grp select 0;
		private _vehicle = _gunner getVariable ["OPFor_vehicle", objNull];
		if (!isNull _vehicle) then {
			// Keep gunner
			if (_gunner != gunner _vehicle) then {
				_gunner assignAsGunner _vehicle;
				[_gunner] orderGetIn true ;
			};

			// Default for HMG, GMG
			private _radius = 800;
			private _kind = ["Man"];

			private _veh_class = typeOf _vehicle;
			if (_veh_class isKindOf "AT_01_base_F") then {_radius = 1500; _kind = ["Car", "Tank"]};
			if (_veh_class isKindOf "StaticMortar") then {_radius = 2000; _kind = ["Man"]};
			if (_veh_class isKindOf "AA_01_base_F") then {_radius = 2500; _kind = ["Air"]};

			private _scan_target = [ ((getPos _vehicle) nearEntities [ _kind, _radius]), {
				alive _x &&
				side _x == GRLIB_side_friendly &&
				!(_x getVariable ['R3F_LOG_disabled', false]) &&
				_x distance2D lhd > 500 &&
				_x distance2D ([getPos _x] call F_getNearestFob) >= GRLIB_sector_size
			} ] call BIS_fnc_conditionalSelect;

			if (count (_scan_target) > 0 ) then {
				// closest first
				private _target_list = _scan_target apply {[_x distance2D _vehicle, _x]};
				_target_list sort true;
				private _next_target = _target_list select 0 select 1;

				_vehicle setDir (_vehicle getDir _next_target);
				_grp setBehaviour "COMBAT";
				_grp reveal _next_target;
				_gunner doTarget _next_target;
				//_vehicle fireAtTarget [_next_target];
			} else {
				_grp setBehaviour "CARELESS";
				_gunner doTarget objNull;
			};
		};
		sleep 30;
	} else {
		if ( reinforcements_sector_under_attack != "" && (markerpos reinforcements_sector_under_attack) distance2D (getPos (leader _grp)) < 4000 ) then {

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
		} else {
			private _patrol_startpos = getpos (leader _grp);
			private _sector_radius = 4000;
			private _sector_list = (sectors_allSectors - blufor_sectors - sectors_tower);
			private _max_waypoints = 4;  // + back to startpos and cycle

			if (_patrol_type == 1) then {
				_sector_radius = 2000;
				_a3w_missions = [];
				{_a3w_missions pushBack ( _x select 0 )} foreach (SpawnMissionMarkers + ForestMissionMarkers);
				_sector_list = (sectors_allSectors + _a3w_missions - blufor_sectors );
				_max_waypoints = 5;
			};

			// Found new waypoints
			private _sectors_patrol = [];
			_start_pos =  [_sector_list, _patrol_startpos] call F_nearestPosition;
			_sectors_patrol = [_start_pos, _sector_radius, _sector_list, _max_waypoints] call F_getSectorPath;

			// Clean old waypoints
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
		waitUntil { sleep 5;(count (units _grp) == 0) || ( reinforcements_sector_under_attack != "" && ((markerpos reinforcements_sector_under_attack) distance2D (getPos leader _grp) < 4000) ) };
	};
	sleep 5;
};