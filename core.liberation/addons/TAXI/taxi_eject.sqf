params ["_target"];

GRLIB_taxi_eject = true;
{ 
    if (isPlayer _x) then {
        _x action ["eject", _target];
        _x action ["getout", _target];
    } else {
        [_target, _x] spawn PAR_unit_eject;
    };
    sleep 0.2;
} forEach ([_target] call taxi_cargo);
