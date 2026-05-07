params ["_transport", '_driver'];

if (!alive _transport) exitWith {};

if (_transport isKindOf "Helicopter_Base_F") then {
	private _stop = time + (3 * 60);
	waitUntil {
        _transport land "LAND";
		sleep 10;
		private _alt = getPos _transport select 2;
		(_alt <= 3 || time > _stop);
	};
	doStop _driver;
};

// near storage
private _truck_load = _transport getVariable ["GRLIB_ammo_vehicle_load", []];
if (count _truck_load == 0) exitWith {};

private _storage_list = (nearestObjects [_transport, [storage_medium_typename, storage_large_typename], GRLIB_fob_range]) select {
	count _truck_load < (([typeOf _x] call F_getVehicleMaxLoad) - (count (_x getVariable ["GRLIB_ammo_vehicle_load", []])))
};

if (count _storage_list > 0) then {
    private _storage = _storage_list select 0;
    _transport allowDamage false;
    {
        _box = _x;
        if (typeOf _box in GRLIB_AI_logistic_ressources) then {
            _box allowDamage false;
            detach _box;
            _box setPos zeropos;
			_box setVelocity [0,0,0];
            [_storage, _box] remoteExec ["load_truck_remote_call", 2];
            _truck_load = _truck_load - [_box];
            sleep 1;
			_box allowDamage true;
        };
    } forEach _truck_load;
    _transport allowDamage true;
    _transport setVariable ["GRLIB_ammo_vehicle_load", _truck_load, true];
    gamelogic globalChat format ["AI Transport unload cargo to %1!", [_storage] call F_getLRXName ];
} else {
    [_driver, "unload"] call ai_logistic_failed;
};
