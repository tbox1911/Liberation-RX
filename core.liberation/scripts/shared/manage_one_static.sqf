params ["_static"];

private _static_class = typeOf _static;
_static setVariable ["LRX_managed_static", true, true];
_static addEventHandler ["HandleDamage", { _this call damage_manager_static }];

private ["_near_arsenal", "_vehicle_need_ammo", "_near_repair", "_vehicle_need_repair", "_gunner"];
private _timer = 0;

while {alive _static} do {
    waitUntil { sleep 1; (isNull (_static getVariable ["R3F_LOG_est_transporte_par", objNull])) };

    if !(local _static) exitWith { _static setVariable ["LRX_managed_static", false, true] };

    [_static] call F_vehicleUnflip;

    if (_static_class in static_vehicles_AI) then {
        _near_arsenal = ([_static, "REAMMO", 80] call F_check_near);
        _vehicle_need_ammo = (([_static] call F_getVehicleAmmoDef) <= 0.85);
	    if (_near_arsenal && _vehicle_need_ammo) then {
            _timer = _static getVariable ["GREUH_rearm_timer", 0];
            if (_timer <= time) then {
                _static setVehicleAmmo 1;
                _static setVariable ["GREUH_rearm_timer", round (time + (3*60))];  // min cooldown
            };
        };

        _near_repair = ([_static, "REPAIR_AI", 80] call F_check_near);
        _vehicle_need_repair = [_static] call F_VehicleNeedRepair;
        if (_near_repair && _vehicle_need_repair) then {
            _timer = _static getVariable ["GREUH_repair_timer", 0];
            if (_timer <= time) then {
                _static setDamage 0;
                _static setVariable ["GREUH_repair_timer", round (time + (5*60))];  // min cooldown
            };
        };
    } else {
        if (count crew _static > 0) then {
            _gunner = gunner _static;
            if (isPlayer _gunner) exitWith {};
            if (side group _gunner == GRLIB_side_enemy) then {
                _static setVehicleAmmo 1;       // OPFor infinite Ammo
                [_gunner] spawn F_getNearestEnemy;
            };
        } else {
            if (_static_class in opfor_statics) then {
                [_static] call F_searchGunner;
            };
        };
    };
    sleep 30;
};