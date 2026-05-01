params ["_transport"];

// near storage
private _truck_load = _transport getVariable ["GRLIB_ammo_vehicle_load", []];
private _storage_list = (nearestObjects [_transport, [storage_medium_typename], GRLIB_fob_range]) select {
	count _truck_load < (([typeOf _x] call F_getVehicleMaxLoad) - (count (_x getVariable ["GRLIB_ammo_vehicle_load", []])))
};

if (count _storage_list > 0) then {
    private _storage = _storage_list select 0;
    {
        if (typeOf _x in GRLIB_AI_logistic_ressources) then {
            detach _x;
            [_storage, _x] remoteExec ["load_truck_remote_call", 2];
            _truck_load = _truck_load - [_x];
            sleep 1;
        };
    } forEach _truck_load;
    _transport setVariable ["GRLIB_ammo_vehicle_load", _truck_load, true];
} else {
    [_driver, "unload"] call ai_logistic_failed;
};
