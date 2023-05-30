private [ "_all_static", "_static", "_all_light" ];

while { true } do {
    _all_static = [vehicles, { alive _x && (typeOf _x) in (list_static_weapons - static_vehicles_AI)}] call BIS_fnc_conditionalSelect;

    {
        _static = _x;
  
        // No damage
        private _owner = owner _static;
        if (_owner == 0) then {
            _static allowDamage false;
        } else {
            [_static, false] remoteExec ["allowDamage", _owner];
        };

        // OPFor infinite Ammo
        if (side _static == GRLIB_side_enemy) then {
            //_ammo = [_veh] call F_getVehicleAmmoDef;
            _static setVehicleAmmo 1;
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
        if (side group _static == GRLIB_side_enemy) then {
            private _gunner = gunner _static;
            private _gunner_list = _static getVariable ["GRLIB_vehicle_gunner", []];
            if (isNull _gunner) then {
                {
                    if (alive _x) exitWith {
                        [_x] orderGetIn true ;
                        _x assignAsGunner _static;
                        _x moveInGunner _static;
                    };
                } forEach _gunner_list;
            } else {
                // Nearest enemy
                [_gunner] call F_getNearestEnemy;
            };
        };

        if (side group _static == GRLIB_side_resistance) then {
            private _gunner = gunner _static;
            private _gunner_list = _static getVariable ["GRLIB_vehicle_gunner", []];
            if (isNull _gunner) then {
                {
                    if (alive _x) exitWith {
                        [_x] orderGetIn true;
                        _x assignAsGunner _static;
                        _x moveInGunner _static;
                    };
                } forEach _gunner_list;
            };
        };

        sleep 1;
    } forEach _all_static;

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
        sleep 1;
    } forEach _all_light;

	sleep 20;
};
