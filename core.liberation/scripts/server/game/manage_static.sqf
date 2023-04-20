private [ "_all_static", "_static" ];

while { true } do {
    _all_static = [vehicles, { alive _x && typeOf _x in (list_static_weapons - static_vehicles_AI)}] call BIS_fnc_conditionalSelect;

    {
        _static = _x;
  
        // No damage
        if (isDamageAllowed _static) then {
            private _owner = owner _static;
            if (_owner == 0) then {
                _static allowDamage false;
            } else {
                [_static, false] remoteExec ["allowDamage", _owner];
            };
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

        if (side group _static == GRLIB_side_enemy) then {
            // Keep gunner
            private _gunner = gunner _static;
            private _gunner_list = _static getVariable ["GRLIB_vehicle_gunner", []];
            if (isNull _gunner) then {
                {
                    if (alive _x) exitWith {
                        _x assignAsGunner _static;
                        [_x] orderGetIn true ;
                    };
                } forEach _gunner_list;
            } else {
                // Nearest enemy
                [_gunner] call F_getNearestEnemy;
            };
        };
        sleep 1;
    } forEach _all_static;

	sleep 20;
};
