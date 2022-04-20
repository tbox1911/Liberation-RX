// check if vehicle is public
params ["_vehicle"];
private _ret = (_vehicle getVariable ["GRLIB_vehicle_owner", ""] == "public");
_ret;
