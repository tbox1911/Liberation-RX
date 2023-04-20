params ["_vehicle"];

private _ret = false;
if (_vehicle getVariable ["GRLIB_vehicle_owner", ""] == "") then {
	_ret = true;
};
_ret;
