params [ "_sector", "_number" ];

if (_number == 0) exitWith {};
if (_number >= 1) then {
	sleep 2;    
	[ _sector, _number - 1 ] spawn static_manager;
};

// Create
private _spawn_pos = [markerPos _sector, floor(random 50), random 360] call BIS_fnc_relPos;
if (surfaceIsWater _spawn_pos) exitWith {};
private _grp = createGroup [GRLIB_side_enemy, true];
private _vehicle = [_spawn_pos, selectRandom opfor_statics, true] call F_libSpawnVehicle;
_vehicle setVariable ["GRLIB_counter_TTL", round(time + 900)];
opfor_spotter createUnit [ getposATL _vehicle, _grp, 'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]', 0.5, "PRIVATE"];
opfor_spotter createUnit [ getposATL _vehicle, _grp, 'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]', 0.5, "PRIVATE"];
(crew _vehicle) joinSilent _grp;
[_grp] call F_deleteWaypoints;
_vehicle setVariable ["GRLIB_vehicle_gunner", units _grp];

diag_log format [ "Spawn Static Patrol on sector %1 at %2", _sector, time ];
if ( local _grp ) then {
    _headless_client = [] call F_lessLoadedHC;
    if ( !isNull _headless_client ) then {
        _grp setGroupOwner ( owner _headless_client );
    };
};

// AI (managed by manage_static.sqf)

// Wait
private _unit_ttl = round (time + 1800);
waitUntil {
    sleep 30;
    (
        GRLIB_global_stop == 1 ||
        (diag_fps < 25) ||
        ({alive _x} count (units _grp) == 0) ||
        ([getPos (leader _grp), 3500, GRLIB_side_friendly] call F_getUnitsCount == 0) ||
        (time > _unit_ttl)
    )
};

// Cleanup
waitUntil { sleep 10; (GRLIB_global_stop == 1 || [markerPos _sector, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
[_vehicle] call clean_vehicle;
{ deleteVehicle _x } forEach (units _grp);
deleteGroup _grp;