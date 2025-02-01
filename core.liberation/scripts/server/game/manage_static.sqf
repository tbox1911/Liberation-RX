private ["_basic_static", "_ai_static", "_static", "_sector", "_side", "_gunner", "_gunner_list", "_enemy"];
private ["_timer", "_vehicle_name", "_near_arsenal", "_vehicle_need_ammo", "_near_repair", "_vehicle_need_repair" ];

waitUntil {sleep 1; !isNil "blufor_sectors"};
waitUntil {sleep 1; !isNil "opfor_sectors" };

while { true } do {
    _basic_static = vehicles select { alive _x && (typeOf _x) in (list_static_weapons - static_vehicles_AI) };
    {
        _static = _x;
        [_static] call F_vehicleUnflip;
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
                    [_gunner] spawn F_fixPosUnit;
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
        sleep 1;
    } forEach _basic_static;

    sleep 1;

    _ai_static = vehicles select { alive _x && (typeOf _x) in static_vehicles_AI };
    {
        _static = _x;
        [_static] call F_vehicleUnflip;

        _near_arsenal = ([_static, "REAMMO", 80] call F_check_near);
        _vehicle_need_ammo = (([_static] call F_getVehicleAmmoDef) <= 0.85);
        _vehicle_name = [_static] call F_getLRXName;
	    if (_near_arsenal && _vehicle_need_ammo) then {
            _timer = _static getVariable ["GREUH_rearm_timer", 0];
            if (_timer <= time) then {
                _static setVehicleAmmo 1;
                _static setVariable ["GREUH_rearm_timer", round (time + (3*60))];  // min cooldown
            } else {
                private _player = ([_static, 30] call F_getNearbyPlayers) select 0;
                if (!isNil "_player") then {
                    _screenmsg = format [ "%1\nRearming Cooldown (%2 sec), Please Wait...", _vehicle_name, round (_timer - time) ];
                    [[_screenmsg, "PLAIN DOWN"]] remoteExec ["titleText", owner _player];
                };
            };
        };

        _near_repair = ([_static, "REPAIR_AI", 80] call F_check_near);
        _vehicle_need_repair = [_static] call F_VehicleNeedRepair;
        if (_near_repair && _vehicle_need_repair) then {
            _timer = _static getVariable ["GREUH_repair_timer", 0];
            if (_timer <= time) then {
                _static setDamage 0;
                _static setVariable ["GREUH_repair_timer", round (time + (5*60))];  // min cooldown
            } else {
                private _player = ([_static, 30] call F_getNearbyPlayers) select 0;
                if (!isNil "_player") then {
                    _screenmsg = format [ "%1\nRepairing Cooldown (%2 sec), Please Wait...", _vehicle_name, round (_timer - time) ];
                   [[_screenmsg, "PLAIN DOWN"]] remoteExec ["titleText", owner _player];
                };
            };
        };
        sleep 1;
    } forEach _ai_static;
	sleep 60;
};
