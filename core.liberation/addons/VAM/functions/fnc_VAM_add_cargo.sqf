if (count VAM_arsenal_item == 0) exitWith {};

private _id = VAM_arsenal_item select 1;
private _item = VAM_arsenal_class_names select _id;
private _cost = 0;
private _VAM_display = findDisplay 4900;
private _currentvehiclecargotext = _VAM_display displayCtrl 4952;
private _vehicle = VAM_targetvehicle;
private _msg = "Vehicle Inventory is Full!";

if (_item in VAM_arsenal_cargo_class_names) then {
	private _veh_load = [_vehicle] call R3F_LOG_FNCT_calculer_chargement_vehicule;
	private _load_cur = _veh_load select 0;
	private _load_max = _veh_load select 1;
	private _fonct = [typeOf _vehicle] call R3F_LOG_FNCT_determiner_fonctionnalites_logistique;
	private _item_load = _fonct select R3F_LOG_IDX_can_be_transported_cargo_cout;
	if (_load_cur + _item_load <= _load_max) then {
		{ if (_x select 0 == _item) exitWith {_cost = _x select 2} } forEach (support_vehicles + static_vehicles);
		if !([_cost] call F_pay) exitWith { _msg = "" };
		[_vehicle, [_item]] call R3F_LOG_FNCT_transporteur_charger_auto;
 		_msg = format ["%1 added to Cargo.", ([_item] call F_getLRXName)];
	};
} else {
	if (_vehicle canAdd _item) then {
		_cost = [_item] call F_loadoutPrice;
		if !([_cost] call F_pay) exitWith { _msg = "" };
		_vehicle addItemCargoGlobal [_item, 1];
		_currentvehiclecargotext ctrlSetText  ([_vehicle] call fnc_VAM_get_freecargo);
		_msg = format ["%1 added to Cargo.", ([_item] call F_getLRXName)];
	};
};

if (_msg != "") then {
	hintSilent _msg;
	gamelogic globalChat _msg;
};
