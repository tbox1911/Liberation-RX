private _cost = support_vehicles select { (_x select 0) == canister_fuel_typename } select 0 select 2;
private _result = [format [localize "STR_DO_BUYFUEL", _cost], localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
if (_result) then {
	if (!([_cost] call F_pay)) exitWith {};
	private _can = createVehicle [canister_fuel_typename, (player modelToWorld [0,1,1]), [], 0, "CAN_COLLIDE"];
	[_can, player, 0, true] spawn R3F_LOG_FNCT_objet_deplacer;
	hintSilent localize "STR_FUEL_READY";
};
