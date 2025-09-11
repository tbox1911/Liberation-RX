params ["_vehicle"];

private _cargo = [_vehicle] call taxi_cargo;
if (count _cargo > 0) then {
    [_cargo select 0] execVM "scripts\client\actions\do_eject.sqf";
    sleep 3;
};
player setVariable ["GRLIB_taxi_called", nil, true];
