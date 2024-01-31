params ["_vehicle"];

[_vehicle] execVM "addons\TAXI\taxi_eject.sqf";
player setVariable ["GRLIB_taxi_called", nil, true];
