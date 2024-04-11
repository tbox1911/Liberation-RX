private [ "_all_static", "_static", "_static_class", "_all_light" , "_sector", "_side", "_gunner", "_gunner_list", "_enemy" ];
private _static_classname = list_static_weapons - static_vehicles_AI;

waitUntil {sleep 1; !isNil "blufor_sectors"};
waitUntil {sleep 1; !isNil "opfor_sectors" };

while { true } do {
    _all_static = vehicles select { alive _x && (typeOf _x) in _static_classname };
    {
        _static = _x;
        _static_class = typeOf _static;

        // Correct static position
        [_static] call F_vehicleUnflip;

        // Keep gunner
        _gunner = gunner _static;
        if (isNull _gunner) then {
            _sector = [GRLIB_sector_size, _static] call F_getNearestSector;
            if (_sector in opfor_sectors && _static getVariable ["GRLIB_vehicle_owner", ""] == "server") then {
                _gunner_list = (_static getVariable ["GRLIB_vehicle_gunner", []]) select { alive _x };
                if (count _gunner_list > 0) then {
                    _gunner = _gunner_list select 0;
                } else {
                    _enemy = [_static, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount;
                    if (_enemy > 0) then {
                        _gunner = (units GRLIB_side_enemy) select {
                            (alive _x) && (isNull objectParent _x) &&
                            (isNil {_x getVariable "GRLIB_is_prisoner"}) &&
                            (secondaryWeapon _x == "") && (_x distance2D _static < 80) &&
                            isNil {_x getVariable "PAR_Grp_ID"}
                        } select 0;
                    };
                };
                if (!isNil "_gunner") then {
                    [_gunner] call F_fixPosUnit;
                    _gunner assignAsGunner _static;
                    [_gunner] orderGetIn true;
                    //_gunner moveInGunner _static;
                };
            };
        } else {
            // OPFor infinite Ammo
            if (side group _gunner == GRLIB_side_enemy) then {
                _static setVehicleAmmo 1;
                [_gunner, GRLIB_side_friendly] spawn F_getNearestEnemy;
            };
        };

        sleep 0.5;
    } forEach _all_static;

	sleep 33;
};
