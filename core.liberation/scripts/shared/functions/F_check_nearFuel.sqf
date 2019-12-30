params ["_vehicle"];
private _distveh = 15;
private _ret = false;
private _nearfuel = nearestObjects [(getPosATL _vehicle), ["Land_CanisterFuel_Red_F"], _distveh];
if (count _nearfuel > 0) then {_ret = true};

_ret;