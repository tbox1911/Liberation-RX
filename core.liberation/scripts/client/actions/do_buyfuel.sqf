private ["_cost", "_can", "_result"];

_cost = support_vehicles select { (_x select 0) == canister_fuel_typename } select 0 select 2;
_result = [format [localize "STR_DO_BUYFUEL", _cost], localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
if (_result) then {
	if (!([_cost] call F_pay)) exitWith {};
	_can = createVehicle [canister_fuel_typename, (player modelToWorld [0,1,1]), [], 0, "CAN_COLLIDE"];
	_can enableSimulationGlobal false;
	[_can, player, 0, true] spawn R3F_LOG_FNCT_objet_deplacer;
	hintSilent localize "STR_FUEL_READY";
	sleep 3;
	_can enableSimulationGlobal true;
};
