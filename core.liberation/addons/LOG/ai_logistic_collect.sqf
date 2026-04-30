params ["_transport"];

// when near dest collect all ressource in radius (upto transport capa)
private _ressources = (_transport nearEntities [GRLIB_AI_logistic_ressources, 100]) select {
    alive _x &&
    (_x distance2D lhd > GRLIB_fob_range) &&
    (_x distance2D ([_x] call F_getNearestFob) > GRLIB_fob_range) &&
    !(_x getVariable ['R3F_LOG_disabled', false]) &&
    isNull (attachedTo _x) && locked _x != 2
};

private _maxload = [typeOf _transport] call F_getVehicleMaxLoad;
private _truck_load = _transport getVariable ["GRLIB_ammo_vehicle_load", []];
{
    if (count _truck_load < _maxload) then {
        [_transport, _x] remoteExec ["load_truck_remote_call", 2];
    };
} forEach _ressources;

_truck_load = _transport getVariable ["GRLIB_ammo_vehicle_load", []];

(count _truck_load <= _maxload);
