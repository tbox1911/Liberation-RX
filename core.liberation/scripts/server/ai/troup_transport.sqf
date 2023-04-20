params ["_troup_transport"];
private [ "_unit" ];

diag_log format [ "Spawn Troop in vehicle %1 at %2", typeOf _troup_transport, time ];
private _transport_group = (group (driver _troup_transport));
private _start_pos = getpos _troup_transport;
private _dat_objective =  ([getpos _troup_transport] call F_getNearestBluforObjective) select 0;
private _unload_distance = 300;

private _troupgrp = [_start_pos, ([] call F_getAdaptiveSquadComp), GRLIB_side_enemy, "infantry"] call F_libSpawnUnits;
{
	_x assignAsCargoIndex [_troup_transport, _forEachIndex];
	_x moveInCargo _troup_transport;
	_x setSkill ["courage", 1];
	_x allowFleeing 0;
	_x setVariable ["GRLIB_counter_TTL", round(time + 1800)];
} foreach (units _troupgrp);

waitUntil { sleep 1; ((damage _troup_transport > 0.5) || !(alive (driver _troup_transport)) || ((_troup_transport distance2D _dat_objective) < _unload_distance)) };
doStop (driver _troup_transport);
sleep 2;

// transport troops
{ 
	_veh = objectParent _x;
	if (!(isNull _veh) && speed vehicle _veh < 5) then {
		unAssignVehicle _x;
		_x action ["eject", vehicle _x];
		_x action ["getout", vehicle _x];
		[_x] orderGetIn false;
		[_x] allowGetIn false;
		sleep 0.2;
	};
} forEach (units _troupgrp);
sleep 2;
[_troupgrp] spawn battlegroup_ai;

// transport vehicle
if ((alive _troup_transport) && (alive (driver _troup_transport))) then {
	while {(count (waypoints _transport_group)) != 0} do {deleteWaypoint ((waypoints _transport_group) select 0);};
	private _waypoint = _transport_group addWaypoint [_dat_objective, 100];
	_waypoint setWaypointType "SAD";
	_waypoint setWaypointSpeed "NORMAL";
	_waypoint setWaypointBehaviour "COMBAT";
	_waypoint setWaypointCombatMode "RED";
	_waypoint setWaypointCompletionRadius 30;
	_waypoint = _transport_group addWaypoint [_dat_objective, 100];
	_waypoint setWaypointType "SAD";
	_waypoint = _transport_group addWaypoint [_dat_objective, 100];
	_waypoint setWaypointType "CYCLE";
	(driver _troup_transport) doFollow (leader _troup_transport);
};
