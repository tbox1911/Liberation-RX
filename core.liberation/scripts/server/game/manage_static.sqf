private [ "_all_static", "_static", "_static_class", "_all_light" , "_side", "_gunner", "_gunner_list" ];
private _static_classname = list_static_weapons - static_vehicles_AI;

while { true } do {
    _all_static = vehicles select { local _x && alive _x && (typeOf _x) in _static_classname  };
    {
        _static = _x;
        _static_class = typeOf _static;

        // No damage
        if (isDamageAllowed _static) then {
            _static allowDamage false;
        };

        // Correct static position
        [_static] call F_vehicleUnflip;

        // Keep gunner
        _gunner = gunner _static;
        if (isNull _gunner) then {         
            _side = GRLIB_side_enemy;
            _enemy = [_static, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount;
            if (_static_class in (blufor_statics - static_vehicles_AI)) then {
                _enemy = [_static, GRLIB_sector_size, GRLIB_side_enemy] call F_getUnitsCount;
                _side = GRLIB_side_friendly;
            };
            if (_enemy > 0) then {
                _gunner_list = (_static getVariable ["GRLIB_vehicle_gunner", []]) select { alive _x };
                if (count _gunner_list > 0) then {
                    _gunner = _gunner_list select 0;
                } else {
                    _gunner = (units _side) select {
                        (alive _x) && (isNull objectParent _x) &&
                        (isNil {_x getVariable "GRLIB_is_prisoner"}) &&
                        (secondaryWeapon _x == "") && (_x distance2D _static < 50) &&
                        isNil {_x getVariable "PAR_Grp_ID"}
                    } select 0;
                };
                if (!isNil "_gunner") then {
                    [_gunner] call F_fixPosUnit;
                    _gunner assignAsGunner _static;
                    [_gunner] orderGetIn true;
                    //_gunner moveInGunner _static;
                };
            };
        };

        // OPFor infinite Ammo
        if (_static_class in opfor_statics && side group _gunner == GRLIB_side_enemy) then {
            _static setVehicleAmmo 1;
            if !(isNull _gunner) then {
                [_gunner] spawn F_getNearestEnemy;
            };
        };

        sleep 0.5;
    } forEach _all_static;

	sleep 33;
};
