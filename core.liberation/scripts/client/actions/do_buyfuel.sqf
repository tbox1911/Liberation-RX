_cost = 5;

_msg = format [localize "STR_DO_BUYFUEL", _cost];
_result = [_msg, localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
if (_result) then {
	if (!([_cost] call F_pay)) exitWith {};
	private _pos = player modelToWorld [0,1,1];
	private _can = createVehicle [canisterFuel, _pos, [], 0, "CAN_COLLIDE"];
	[_can] spawn R3F_LOG_FNCT_objet_deplacer;
	hintSilent localize "STR_FUEL_READY";
};
