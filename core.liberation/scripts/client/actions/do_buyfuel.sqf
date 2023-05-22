private _cost = support_vehicles select { (_x select 0) == canister_fuel_typename } select 0 select 2;
private _result = [format [localize "STR_DO_BUYFUEL", _cost], localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
if (!_result) exitWith {};

buildtype = 9;
build_unit = [canister_fuel_typename,[],1,[],[],[]];
dobuild = 1;

waitUntil { sleep 0.5; dobuild == 0 };

if (build_confirmed == 0) then {
	if (!([_cost] call F_pay)) then {
		deleteVehicle build_vehicle;
	};
	hintSilent localize "STR_FUEL_READY";
};
