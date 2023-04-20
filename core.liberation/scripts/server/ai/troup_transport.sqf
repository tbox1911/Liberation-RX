params ["_troup_transport"];
private [ "_unit" ];

diag_log format [ "Spawn Troop in vehicle %1 at %2", typeOf _troup_transport, time ];
private _transport_group = (group (driver _troup_transport));
private _start_pos = getpos _troup_transport;
private _dat_objective =  ([getpos _troup_transport] call F_getNearestBluforObjective) select 0;
private _unload_distance = 700;
sleep 1;
private _initial_crewcount = count crew _troup_transport;

waitUntil { sleep 0.2; !(alive _troup_transport) || !(alive (driver _troup_transport)) || (((_troup_transport distance2D _dat_objective) < _unload_distance) && (!(surfaceIsWater (getpos _troup_transport)))) };

if ((alive _troup_transport) && (alive (driver _troup_transport))) then {
	private _troupgrp = createGroup [GRLIB_side_enemy, true];
	{
		_unit = _troupgrp createUnit [_x, _start_pos, [], 5, "NONE"];
		_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
        [_unit] joinSilent _troupgrp;
		_unit assignAsCargo _troup_transport;
		_unit moveInCargo _troup_transport;
		_unit allowFleeing 0;
		_unit setVariable ["GRLIB_counter_TTL", round(time + 1800)];
		[ _unit ] call reammo_ai;
		sleep 0.1;
	} foreach ([] call F_getAdaptiveSquadComp);

	while {(count (waypoints _troupgrp)) != 0} do {deleteWaypoint ((waypoints _troupgrp) select 0);};
	sleep 2;

	private _transport_waypoint = _transport_group addWaypoint [getpos _troup_transport, 0,0];
	_transport_waypoint setWaypointType "TR UNLOAD";
	_transport_waypoint setWaypointCompletionRadius 200;

	private _troops_waypoint = _troupgrp addWaypoint [getpos _troup_transport, 0];
	_troops_waypoint setWaypointType "GETOUT";
	_troops_waypoint setWaypointCompletionRadius 200;

	_troops_waypoint synchronizeWaypoint [_transport_waypoint];

	{ unassignVehicle _troup_transport } forEach (units _troupgrp);
	_troupgrp leaveVehicle _troup_transport;
	(units _troupgrp) allowGetIn false;

	private _troops_waypoint_2 = _troupgrp addWaypoint [getpos _troup_transport, 250];
	_troops_waypoint_2 setWaypointType "MOVE";
	_troops_waypoint_2 setWaypointCompletionRadius 5;

	waitUntil { sleep 0.3; _initial_crewcount >= count crew _troup_transport };

	sleep 5;

	while {(count (waypoints _transport_group)) != 0} do {deleteWaypoint ((waypoints _transport_group) select 0);};

	private _waypoint2 = _transport_group addWaypoint [_dat_objective, 100];
	_waypoint2 setWaypointType "SAD";
	_waypoint2 setWaypointSpeed "NORMAL";
	_waypoint2 setWaypointBehaviour "COMBAT";
	_waypoint2 setWaypointCombatMode "RED";
	_waypoint2 setWaypointCompletionRadius 30;

	_waypoint2 = _transport_group addWaypoint [_dat_objective, 100];
	_waypoint2 setWaypointType "SAD";

	_waypoint2 = _transport_group addWaypoint [_dat_objective, 100];
	_waypoint2 setWaypointType "CYCLE";

	sleep 10;

	[_troupgrp, true] spawn battlegroup_ai;
};