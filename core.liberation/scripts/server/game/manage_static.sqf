private [ "_all_static", "_static" ];

while { true } do {
    _all_static = [vehicles, { alive _x && typeOf _x in (list_static_weapons - static_vehicles_AI)}] call BIS_fnc_conditionalSelect;

    {
        _static = _x;
  
        // No damage
        _static allowDamage false;

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

        // Nearest enemy
        private _gunner = gunner _static;
        if (!isNull _gunner) then {
            [_gunner] call F_getNearestEnemy;
        };

    } forEach _all_static;

	sleep 10;
};
