private [ "_all_static", "_static", "_static_class", "_all_light" , "_side", "_gunner", "_next_gunner", "_gunner_list" ];
private _static_classname = list_static_weapons - static_vehicles_AI;

while { true } do {
    _all_static = [vehicles, { local _x && alive _x && (typeOf _x) in _static_classname }] call BIS_fnc_conditionalSelect;

    {
        _static = _x;
        _static_class = typeOf _static;

        // No damage
        if (isDamageAllowed _static) then {
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
        _gunner = gunner _static;
        _gunner_list = _static getVariable ["GRLIB_vehicle_gunner", []];
        if (isNull _gunner) then {
            if ({alive _x} count _gunner_list == 0) then {
                _gunner_list = [];
                _side = GRLIB_side_enemy;
                _enemy = [_static, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount;
                if (_static_class in (blufor_statics - static_vehicles_AI)) then {
                    _enemy = [_static, GRLIB_sector_size, GRLIB_side_enemy] call F_getUnitsCount;
                    _side = GRLIB_side_friendly;
                };
                if (_static_class in resistance_squad_static) then {
                    _side = GRLIB_side_resistance;
                    _enemy = 1;
                };
                if (_enemy > 0) then {
                    _next_gunner = (units _side) select {
                        (alive _x) && (isNull objectParent _x) &&
                        (secondaryWeapon _x == "") && (_x distance2D _static < 50) &&
                        isNil {_x getVariable "PAR_Grp_ID"}
                    } select 0;
                    if (!isNil "_next_gunner") then { _gunner_list = [_next_gunner] };
                    _static setVariable ["GRLIB_vehicle_gunner", _gunner_list];
                };
            };

            {
                if (alive _x) exitWith {
                    _x assignAsGunner _static;
                    [_x] orderGetIn true;
                    //_x moveInGunner _static;
                    sleep 1;
                };
            } forEach _gunner_list;
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
