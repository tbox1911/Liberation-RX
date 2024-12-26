if (count VAM_arsenal_item == 0) exitWith {};

private _id = VAM_arsenal_item select 1;
private _item = VAM_arsenal_class_names select _id;
private _cost = 0;
if (_item in VAM_arsenal_cargo_class_names) then {
	{ if (_x select 0 == _item) exitWith {_cost = _x select 2} } forEach support_vehicles;
} else {
	_cost = [_item] call F_loadoutPrice;
};
private _VAM_display = findDisplay 4900;
private _currentvehiclecargotext = _VAM_display displayCtrl 4952;
private _vehicle = VAM_targetvehicle;

if !([_cost] call F_pay) exitWith {};

private _msg = format ["%1 added to Cargo.", ([_item] call F_getLRXName)];
if (_item in VAM_arsenal_cargo_class_names) then {
	[_vehicle, [_item]] call R3F_LOG_FNCT_transporteur_charger_auto;
} else {
	if (_vehicle canAdd _item) then {
		_vehicle addItemCargoGlobal [_item, 1];
		_currentvehiclecargotext ctrlSetText  ([_vehicle] call fnc_VAM_get_freecargo);
	} else {
		_msg = "Vehicle Inventory is Full!";
	};
};

if (_msg != "") then {
	hintSilent _msg;
	systemchat _msg;
};
