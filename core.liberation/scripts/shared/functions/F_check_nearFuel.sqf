params ["_vehicle"];
private _ret = false;
private _nearfuel = nearestObjects [(getPosATL _vehicle), ["Land_CanisterFuel_Red_F"], 15];
if (count _nearfuel > 0) then {_ret = true};

_ret;