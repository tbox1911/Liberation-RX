_cost = 5;

_msg = format ["<t align='center'>Fuel Jerican cost: %1 Ammo<br/>Are you sure ?</t>", _cost];
_result = [_msg, "Warning !", true, true] call BIS_fnc_guiMessage;
if (_result) then {
	if (!([_cost] call F_pay)) exitWith {};
	private _pos = player modelToWorld [0,1,1];
	private _can = createVehicle [canisterFuel, _pos, [], 0, "CAN_COLLIDE"];
	[_can] spawn R3F_LOG_FNCT_objet_deplacer;
	hintSilent "Jerican Fuel ready.\nThank you !";
};
