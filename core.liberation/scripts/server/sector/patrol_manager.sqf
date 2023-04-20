params [ "_sector", "_patrol_type" ];
if (_sector in active_sectors) exitWith {};
private _grp = grpNull;

// Create Infantry
if (_patrol_type == 1) then {
    _grp = [markerpos _sector, ([] call F_getAdaptiveSquadComp), GRLIB_side_enemy, "infantry"] call F_libSpawnUnits;
    [_grp, markerpos _sector, 150] spawn add_defense_waypoints;
    diag_log format [ "Spawn Infantry Patrol on sector %1 at %2", _sector, time ];
};

// Create Armored
if (_patrol_type == 2) then {
    _vehicle_object = [ markerpos _sector, [] call F_getAdaptiveVehicle ] call F_libSpawnVehicle;
    _grp = group ((crew _vehicle_object) select 0);
    [_grp, markerpos _sector, 250] spawn add_defense_waypoints;
    diag_log format [ "Spawn Armored Patrol on sector %1 at %2", _sector, time ];
};

if ( local _grp ) then {
    _headless_client = [] call F_lessLoadedHC;
    if ( !isNull _headless_client ) then {
        _grp setGroupOwner ( owner _headless_client );
    };
};

// Cleanup
private _timeout = time + (5 * 60);
while { count (units _grp) > 0 } do {
    if ( [getpos (leader _grp), 3000, GRLIB_side_friendly] call F_getUnitsCount == 0 && time > _timeout ) then {
        {
            if ( vehicle _x != _x ) then {
                deleteVehicle (vehicle _x);
            };
            deleteVehicle _x;
        } foreach (units _grp);
        deleteGroup _grp;
    };
    sleep 10;
};
