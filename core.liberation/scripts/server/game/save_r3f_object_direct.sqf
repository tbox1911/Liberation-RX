params ["_vehicle"];

private _lst_r3f = [];

if (GRLIB_ACE_enabled) then {
	{
		if (typeName _x == "STRING") then {
			_lst_r3f pushback _x;
		} else {
			_lst_r3f pushback (typeOf _x);
		};
	} forEach (_vehicle getVariable ["ace_cargo_loaded", []]);
} else {
	{_lst_r3f pushback (typeOf _x)} forEach (_vehicle getVariable ["R3F_LOG_objets_charges", []]);
};

_lst_r3f;
