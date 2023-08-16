params ["_grp", "_objective_pos"];
private ["_waypoint", "_objective_sector", "_nearset_fob_name"];

while { ({alive _x} count (units _grp) > 0) && ( GRLIB_endgame == 0 ) } do {
	sleep 5;
	_objective_sector = [GRLIB_sector_size, _objective_pos, blufor_sectors] call F_getNearestSector;
	_nearset_fob_name = [_objective_pos] call F_getFobName;

	if (_nearset_fob_name != "") then {
		_objective_sector = _nearset_fob_name;
	};
	diag_log format["Battlegroup %1 - Objective %2 %3",_grp, _objective_sector, _objective_pos];

	if (_objective_sector != "" && !isNull _grp) then {
		_objective_pos = markerPos _objective_sector;
		[_objective_pos] remoteExec ["remote_call_incoming", 0];

		[_grp] call F_deleteWaypoints;

		_waypoint = _grp addWaypoint [_objective_pos, 100];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointSpeed "NORMAL";
		_waypoint setWaypointBehaviour "AWARE";
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointCompletionRadius 50;

		_waypoint = _grp addWaypoint [_objective_pos, 100];
		_waypoint setWaypointType "SAD";
		_waypoint = _grp addWaypoint [_objective_pos, 100];
		_waypoint setWaypointType "SAD";
		_waypoint = _grp addWaypoint [_objective_pos, 100];
		_waypoint setWaypointType "SAD";		
		_waypoint = _grp addWaypoint [_objective_pos, 100];
		_waypoint setWaypointType "CYCLE";
		{_x doFollow (leader _grp)} foreach units _grp;

		sleep 30;

		_timer = round (time + (15 * 60));
		waitUntil {sleep 5; ({alive _x} count (units _grp) == 0) || time > _timer };
	};

	sleep 5;
	if (getPosATL (leader _grp) distance2D _objective_pos > GRLIB_spawn_max || _objective_sector == "") then {
		{
			if (!isNull objectParent _x) then { deleteVehicle (objectParent _x) };
			deleteVehicle _x;
			sleep 0.1;
		} foreach units _grp;
		deleteGroup _grp;
	};
};