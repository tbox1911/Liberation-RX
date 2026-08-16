params ["_vehicle"];

private _lst_r3f = [];

if (GRLIB_ACE_enabled) then {
	{
		if (typeName _x == "STRING") then {
			_lst_r3f pushback _x;
		} else {
			private _class = typeOf _x;
			if (_class != "") then { _lst_r3f pushback _class };
		};
	} forEach (_vehicle getVariable ["ace_cargo_loaded", []]);
} else {
	{
		private _class = typeOf _x;
		if (_class != "") then { _lst_r3f pushback _class };
	} forEach (_vehicle getVariable ["R3F_LOG_objets_charges", []]);
};

_lst_r3f;
