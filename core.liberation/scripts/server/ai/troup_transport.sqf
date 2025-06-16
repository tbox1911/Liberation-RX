params ["_troup_transport", "_objective_pos"];
private [ "_unit" ];

diag_log format [ "Spawn Troop in vehicle %1 objective %2 at %3", typeOf _troup_transport, _objective_pos, time ];
private _transport_group = group (driver _troup_transport);
private _start_pos = getPosATL _troup_transport;

private _cargo_seat_free = _troup_transport emptyPositions "Cargo";
if (_cargo_seat_free == 0) exitWith { diag_log format ["--- LRX Error bad classname (%1) for troup transport.", typeOf _troup_transport] };
if (_cargo_seat_free > 8) then {_cargo_seat_free = 8};

private _unitclass = [];
while { (count _unitclass) < _cargo_seat_free } do { _unitclass pushback (selectRandom opfor_squad_8_standard) };

// Board in
private _lock = locked _troup_transport;
_troup_transport lock 0;
private _troup_group = [_start_pos, _unitclass, GRLIB_side_enemy, "infantry"] call F_libSpawnUnits;
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

// Move to obj
[_transport_group] call F_deleteWaypoints;
private _waypoint = _transport_group addWaypoint [ _objective_pos, 50];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "CARELESS";
_waypoint setWaypointCombatMode "WHITE";
_waypoint setWaypointCompletionRadius 100;
{_x doFollow (leader _transport_group)} foreach units _transport_group;

waitUntil { sleep 1;
	!(alive _troup_transport) || (damage _troup_transport > 0.2) || (_troup_transport distance2D _objective_pos < 250)
};

// Board out
doStop (driver _troup_transport);
sleep 1;
if ({alive _x} count (units _troup_transport) == 0) exitWith {};
{
	if ("cargo" in (assignedVehicleRole _x)) then {
		[_x, false] spawn F_ejectUnit;
		sleep 0.5;
	};
} forEach (crew _troup_transport);
[_troup_group, _objective_pos] spawn battlegroup_ai;

if ({alive _x} count (units _transport_group) == 0) exitWith {};
[_transport_group, getPosATL _troup_transport, 30] spawn defence_ai;

// Cleanup
waitUntil { sleep 30; (GRLIB_global_stop == 1 || [_troup_transport, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
[_troup_transport] call clean_vehicle;
{ deleteVehicle _x; sleep 0.1 } forEach (units _transport_group);
deleteGroup _transport_group;
