params ["_troup_transport", "_objective_pos"];
private [ "_unit" ];

diag_log format [ "Spawn Troop in vehicle %1 objective %2 at %3", typeOf _troup_transport, _objective_pos, time ];
private _transport_group = group (driver _troup_transport);
private _start_pos = getpos _troup_transport;

private _unitclass = [];
private _cargo_seat_free = _troup_transport emptyPositions "Cargo";
if (_cargo_seat_free > 8) then {_cargo_seat_free = 8};
while { (count _unitclass) < _cargo_seat_free } do { _unitclass pushback (selectRandom opfor_squad_8_standard) };

private _troupgrp = [_start_pos, _unitclass, GRLIB_side_enemy, "infantry"] call F_libSpawnUnits;
{
	_x assignAsCargoIndex [_troup_transport, _forEachIndex];
	_x moveInCargo _troup_transport;
	[_x] orderGetIn true;
	_x setSkill ["courage", 1];
	_x allowFleeing 0;
	_x setVariable ["GRLIB_counter_TTL", round(time + 1800)];
} foreach (units _troupgrp);

[_transport_group] call F_deleteWaypoints;
private _waypoint = _transport_group addWaypoint [ _objective_pos, 300];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "CARELESS";
_waypoint setWaypointCombatMode "BLUE";
_waypoint setWaypointCompletionRadius 20;
_waypoint = _transport_group addWaypoint [ _objective_pos, 150];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointCompletionRadius 20;
_waypoint = _transport_group addWaypoint [ _objective_pos, 1];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointCompletionRadius 20;
{_x doFollow (leader _transport_group)} foreach units _transport_group;

waitUntil { sleep 1;
	!(alive _troup_transport) || (damage _troup_transport > 0.2 ) || (_troup_transport distance2D _objective_pos < 300)
};

if (typeOf _troup_transport isKindOf "Truck_F") then {
	doStop (driver _troup_transport);
	sleep 2;
};

{ [_troup_transport, _x] spawn F_ejectUnit } forEach (units _troupgrp);
[_troupgrp, _objective_pos] spawn battlegroup_ai;

sleep 10;
[_transport_group] call F_deleteWaypoints;
private _waypoint = _transport_group addWaypoint [ _objective_pos, 300];
_waypoint setWaypointType "SAD";
_waypoint setWaypointSpeed "NORMAL";
_waypoint setWaypointBehaviour "COMBAT";
_waypoint setWaypointCombatMode "RED";
_waypoint setWaypointType "SAD";
_waypoint = _transport_group addWaypoint [_objective_pos, 300];
_waypoint setWaypointType "SAD";
_waypoint = _transport_group addWaypoint [_objective_pos, 300];
_waypoint setWaypointType "SAD";
_waypoint = _transport_group addWaypoint [_objective_pos, 300];
_waypoint setWaypointType "CYCLE";
{_x doFollow (leader _transport_group)} foreach units _transport_group;
