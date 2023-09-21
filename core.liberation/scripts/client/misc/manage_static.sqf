waitUntil {sleep 1; GRLIB_player_spawned};

private [ "_all_static", "_static" ];
private _static_classname = list_static_weapons - static_vehicles_AI;

while { true } do {
    _all_static = [vehicles, { local _x && alive _x && (typeOf _x) in _static_classname }] call BIS_fnc_conditionalSelect;

    {
        _static = _x;
  
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

        sleep 0.5;
    } forEach _all_static;

	sleep 10;
};
