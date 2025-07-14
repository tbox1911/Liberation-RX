
private _price = [canister_fuel_typename, support_vehicles] call F_getObjectPrice;
private _result = [format [localize "STR_DO_BUYFUEL", _price], localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
if (!_result) exitWith {};

buildtype = GRLIB_BuildTypeDirect;
build_unit = [canister_fuel_typename,[],1,[],[],[],[]];
dobuild = 1;

waitUntil { sleep 0.5; dobuild == 0 };
if (build_confirmed == 0) then {
	if (!([_price] call F_pay)) then {
		deleteVehicle build_vehicle;
	};
	hintSilent localize "STR_FUEL_READY";
};
