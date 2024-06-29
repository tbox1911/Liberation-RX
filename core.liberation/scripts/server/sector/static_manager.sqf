params [ "_sector", "_count" ];

if (_count == 0) exitWith {};
if (_count >= 1) then {
	sleep 5;
	[_sector, _count - 1] spawn static_manager;
};

// Create
private _radius = GRLIB_capture_size - 20;
if (_sector in sectors_bigtown) then { _radius = _radius * 1.4 };

private _spawn_pos = (markerPos _sector) getPos [_radius, random 360];
if (surfaceIsWater _spawn_pos) exitWith {};
_spawn_pos set [2, 0.5];

private _vehicle = createVehicle [selectRandom opfor_statics, _spawn_pos, [], 0, "None"];
_vehicle addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
_vehicle addEventHandler ["HandleDamage", { _this call damage_manager_static }];

private _grp = createGroup [GRLIB_side_enemy, true];
private _unit = _grp createUnit [opfor_squad_leader, _vehicle, [], 3, "None"];
[_unit] joinSilent _grp;
_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
_unit assignAsGunner _vehicle;
[_unit] orderGetIn true;
_unit moveInGunner _vehicle;
sleep 0.1;
_unit = _grp createUnit [opfor_spotter, _vehicle, [], 3, "None"];
[_unit] joinSilent _grp;
_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
sleep 0.1;
_unit = _grp createUnit [opfor_spotter, _vehicle, [], 3, "None"];
[_unit] joinSilent _grp;
_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];

_vehicle setVariable ["GRLIB_vehicle_owner", "server", true];
_vehicle setVariable ["GRLIB_vehicle_gunner", units _grp];

[_vehicle] call F_aceLockVehicle;

diag_log format [ "Spawn Static Weapon on sector %1 at %2", _sector, time ];

// AI (managed by manage_static.sqf)
[_grp, getPosATL _vehicle, 20] spawn patrol_ai;

// Wait
private _unit_ttl = round (time + 1800);
waitUntil {
	sleep 60;
	(
		GRLIB_global_stop == 1 ||
		({alive _x} count (units _grp) == 0) ||
		([_spawn_pos, (GRLIB_sector_size * 2), GRLIB_side_friendly] call F_getUnitsCount == 0) ||
		(time > _unit_ttl)
	)
};

// Cleanup
waitUntil { sleep 30; (GRLIB_global_stop == 1 || [_spawn_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
if (!isNull _vehicle) then { deleteVehicle _vehicle };
{ deleteVehicle _x } forEach (units _grp);
deleteGroup _grp;