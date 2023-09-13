private [ "_all_static", "_static", "_all_light" ];

private _day = call is_night;
private _old_day = !_day;
private _static_classname = list_static_weapons - static_vehicles_AI;

while { true } do {
    _all_static = [vehicles, { alive _x && (typeOf _x) in _static_classname }] call BIS_fnc_conditionalSelect;

    {
        _static = _x;
  
        // No damage
        if (local _static && isDamageAllowed _static) then {
            _static allowDamage false;
        };

        // Correct static position
        if ((vectorUp _static) select 2 < 0.60) then {
            _static setpos [(getposATL _static) select 0,(getposATL _static) select 1, 0.5];
            _static setVectorUp surfaceNormal position _static;
            sleep 1;
        };

        if (getPosATL _static select 2 < -0.02) then {
            _static setpos (getpos _static);
            sleep 1;
        };

        // Keep gunner
        private _gunner = gunner _static;
        private _gunner_list = _static getVariable ["GRLIB_vehicle_gunner", []];
        if (isNull _gunner) then {
            {
                if (alive _x) exitWith {
                    [_x] orderGetIn true;
                    _x assignAsGunner _static;
                    //_x moveInGunner _static;
                    sleep 1;
                };
            } forEach _gunner_list;
        };

        // OPFor infinite Ammo
        if (typeOf _static in opfor_statics && side group _gunner == GRLIB_side_enemy) then {
            _static setVehicleAmmo 1;
            if !(isNull _gunner) then {
                [_gunner] spawn F_getNearestEnemy;
            };
        };

        sleep 0.5;
    } forEach _all_static;

    _day = call is_night;
    if (_day != _old_day) then {
        _all_light =  [vehicles, { alive _x && (typeOf _x) isKindOf "Land_PortableHelipadLight_01_F"}] call BIS_fnc_conditionalSelect;
        {
            _static = _x;

            // No damage
            private _owner = owner _static;
            if (_owner == 0) then {
                _static allowDamage false;
            } else {
                [_static, false] remoteExec ["allowDamage", _owner];
            };

            if (call is_night) then {
                _static enableSimulationGlobal true;
            } else {
                _static enableSimulationGlobal false;
            };
            sleep 0.5;
        } forEach _all_light;
        _old_day = _day;
    };

	sleep 23;
};
