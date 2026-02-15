params ["_vehicle", "_targetpos"];


diag_log format [ "Spawn Troop in vehicle %1 objective %2 at %3", typeOf _vehicle, _targetpos, time ];
private _driver = (driver _vehicle);
private _transport_group = group _driver;
private _start_pos = getPosATL _vehicle;

private _cargo_seat_free = _vehicle emptyPositions "Cargo";
if (_cargo_seat_free == 0) exitWith {
	diag_log format ["--- LRX Error bad classname (%1) for troup transport.", typeOf _vehicle];
};

private _unitclass = opfor_squad_8_standard select [0, (_cargo_seat_free min 8)];

// Board in
private _troup_group = [_start_pos, _unitclass, GRLIB_side_enemy, "cargo"] call F_libSpawnUnits;
[_vehicle, (units _troup_group)] call F_manualCrew;
(units _troup_group) joinSilent _transport_group;
_transport_group selectLeader _driver;

// Move to obj
[_vehicle, 3600] call F_setUnitTTL;
_driver doMove _targetpos;
sleep 10;

// Manage convoy
[_transport_group, [_vehicle], _targetpos] call convoy_ai;

if (!alive _vehicle) exitWith {};

// Cleanup
sleep 30;
[_vehicle, true, true] call F_vehicleClean;
