params ["_transport"];

// near storage
private _truck_load = _transport getVariable ["GRLIB_ammo_vehicle_load", []];

private _storage = (_transport nearEntities [storage_medium_typename, GRLIB_fob_range]) select {
    count _truck_load < count (_x getVariable ["GRLIB_ammo_vehicle_load", []])
};

if (count _storage > 0) then {
    private _selected = _storage select 0;
    {
        detach _x;
        [_selected, _x] remoteExec ["load_truck_remote_call", 2];
    } forEach _truck_load;
    _transport setVariable ["GRLIB_ammo_vehicle_load", [], true];
} else {
    [_driver, "unload"] call ai_logistic_failed;
};
