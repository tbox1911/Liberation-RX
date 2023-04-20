// check if vehicle is abandoned
params ["_vehicle"];
private _ret = (_vehicle getVariable ["GRLIB_vehicle_owner", ""] == "");
_ret;
