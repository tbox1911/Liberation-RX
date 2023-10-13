params ["_troup_transport", "_objective_pos"];
private [ "_unit" ];

diag_log format [ "Spawn Troop in vehicle %1 objective %2 at %3", typeOf _troup_transport, _objective_pos, time ];
private _transport_group = group (driver _troup_transport);
private _start_pos = getpos _troup_transport;

private _unitclass = [];
private _cargo_seat_free = _troup_transport emptyPositions "Cargo";
if (_cargo_seat_free > 8) then {_cargo_seat_free = 8};
while { (count _unitclass) < _cargo_seat_free } do { _unitclass pushback (selectRandom opfor_squad_8_standard) };

private _troup_group = [_start_pos, _unitclass, GRLIB_side_enemy, "infantry"] call F_libSpawnUnits;
{
	_x assignAsCargoIndex [_troup_transport, (_forEachIndex + 1)];
	_x moveInCargo _troup_transport;
	_x setSkill ["courage", 1];
	_x allowFleeing 0;
	_x setVariable ["GRLIB_counter_TTL", round(time + 1800)];
} foreach (units _troup_group);

[_transport_group] call F_deleteWaypoints;
private _waypoint = _transport_group addWaypoint [ _objective_pos, 50];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "CARELESS";
_waypoint setWaypointCombatMode "WHITE";
_waypoint setWaypointCompletionRadius 200;
{_x doFollow (leader _transport_group)} foreach units _transport_group;

waitUntil { sleep 1;
	!(alive _troup_transport) || (damage _troup_transport > 0.2 ) || (_troup_transport distance2D _objective_pos < 300)
};

if (typeOf _troup_transport isKindOf "Truck_F") then {
	doStop (driver _troup_transport);
	sleep 2;
};

if ( { alive _x } count (units _troup_group) > 0 ) then {
	[_troup_group, _troup_transport] spawn F_ejectGroup;
	sleep 10;
	[_troup_group, _objective_pos] spawn battlegroup_ai;
};

if ( { alive _x } count (units _transport_group) > 0 ) then {
	[_transport_group, _objective_pos, 300] spawn add_defense_waypoints;
};
