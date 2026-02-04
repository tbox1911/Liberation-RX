params ["_troup_transport", "_objective_pos"];


diag_log format [ "Spawn Troop in vehicle %1 objective %2 at %3", typeOf _troup_transport, _objective_pos, time ];
private _transport_group = group (driver _troup_transport);
private _start_pos = getPosATL _troup_transport;

private _cargo_seat_free = _troup_transport emptyPositions "Cargo";
if (_cargo_seat_free == 0) exitWith {
	diag_log format ["--- LRX Error bad classname (%1) for troup transport.", typeOf _troup_transport];
};

private _unitclass = opfor_squad_8_standard select [0, (_cargo_seat_free min 8)];

// Board in
private _lock = locked _troup_transport;
_troup_transport lock 0;
private _troup_group = [_start_pos, _unitclass, GRLIB_side_enemy, "cargo"] call F_libSpawnUnits;
{
	_x assignAsCargoIndex [_troup_transport, (_forEachIndex + 1)];
	_x moveInCargo _troup_transport;
	_x setSkill ["courage", 1];
	_x allowFleeing 0;
} foreach (units _troup_group);
[_troup_group, 3600] call F_setUnitTTL;
(units _troup_group) allowGetIn true;
(units _troup_group) orderGetIn true;
sleep 1;
_troup_transport lock _lock;
(units _troup_group) joinSilent _transport_group;

// Move to obj
[_transport_group] call F_deleteWaypoints;
private _waypoint = _transport_group addWaypoint [ _objective_pos, 50];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "NORMAL";
_waypoint setWaypointBehaviour "CARELESS";
_waypoint setWaypointCombatMode "WHITE";

{_x doFollow (leader _transport_group)} foreach units _transport_group;

// Manage convoy
[_transport_group, [_troup_transport], _objective_pos] call convoy_ai;
sleep 10;

if (!alive _troup_transport) exitWith {};

// Cleanup
[_troup_transport, true, true] call F_vehicleClean;
