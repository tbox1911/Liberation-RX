params ["_vehicle"];

private _vehicle_cargo = _vehicle getVariable ["GRLIB_ammo_vehicle_load", []];
if (count _vehicle_cargo == 0) exitWith {[]};

private _lst_lrx = [];
{
	_class = (typeOf _x);
	if (_class == cargo_sling_typename) exitWith {
		_lst_lrx = [_class, ([_x] call save_lrx_object_direct)];
	};
	_lst_lrx pushback _class;
} forEach _vehicle_cargo;

_lst_lrx;
