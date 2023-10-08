params [ "_sector", "_patrol_type" ];

if (_sector in blufor_sectors) exitWith {};
private _grp = grpNull;
private _vehicle = objNull;

// Create Infantry
if (_patrol_type == 1) then {
    _grp = [markerpos _sector, ([] call F_getAdaptiveSquadComp), GRLIB_side_enemy, "infantry"] call F_libSpawnUnits;
    [_grp, markerpos _sector, 150] spawn add_defense_waypoints;
    diag_log format [ "Spawn Infantry Patrol on sector %1 at %2", _sector, time ];
};

// Create Armored
if (_patrol_type == 2) then {
    _vehicle = [markerpos _sector, ([] call F_getAdaptiveVehicle)] call F_libSpawnVehicle;
    if (!isNull _vehicle) then {
        _grp = group ((crew _vehicle) select 0);
        [_grp, markerpos _sector, 250] spawn add_defense_waypoints;
        diag_log format [ "Spawn Armored Patrol on sector %1 at %2", _sector, time ];
    };
};

if ( local _grp ) then {
    _headless_client = [] call F_lessLoadedHC;
    if ( !isNull _headless_client ) then {
        _grp setGroupOwner ( owner _headless_client );
    };
};

// Wait
private _unit_ttl = round (time + 1800);
private _pos = getPosATL (leader _grp);
waitUntil {
    sleep 60;
    _pos = getPosATL (leader _grp);
    (
        GRLIB_global_stop == 1 ||
        (diag_fps < 25) ||
        ({alive _x} count (units _grp) == 0) ||
        ([_pos, GRLIB_spawn_max, GRLIB_side_friendly] call F_getUnitsCount == 0) ||
        (time > _unit_ttl)
    )
};

// Cleanup
waitUntil { sleep 30; (GRLIB_global_stop == 1 || [_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
if (!isNull _vehicle) then { [_vehicle] spawn clean_vehicle };
{ deleteVehicle _x } forEach (units _grp);
deleteGroup _grp;
