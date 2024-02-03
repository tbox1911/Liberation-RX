waitUntil {sleep 1; GRLIB_player_spawned};

private [ "_all_static", "_static" ];
private _static_classname = list_static_weapons - static_vehicles_AI;

while { true } do {
    _all_static = vehicles select { local _x && alive _x && (typeOf _x) in _static_classname };
    {
        _static = _x;
  
        // No damage
        if (isDamageAllowed _static) then {
            _static allowDamage false;
        };

        // Correct static position
        [_static] call F_vehicleUnflip;

        sleep 0.5;
    } forEach _all_static;

	sleep 10;
};
