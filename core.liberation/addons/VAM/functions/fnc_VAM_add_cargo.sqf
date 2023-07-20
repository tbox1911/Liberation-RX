if (count VAM_arsenal_item == 0) exitWith {};

private _msg = "";
private _id = VAM_arsenal_item select 1;
private _item = VAM_arsenal_class_names select _id;
private _VAM_display = findDisplay 4900;
private _currentvehiclecargotext = _VAM_display displayCtrl 4952;
private _vehicle = VAM_targetvehicle;

if (_vehicle canAdd _item) then {
	private _cost = [_item] call F_loadoutPrice;
	if ([_cost] call F_pay) then {
		_vehicle addItemCargoGlobal [_item, 1];
		_msg = format ["%1 added to Cargo.", ([_item] call F_getLRXName)];
		_currentvehiclecargotext ctrlSetText  ([_vehicle] call fnc_VAM_get_freecargo);
	};
} else {
	_msg = "Vehicle Inventory is Full!";
};

if (_msg != "") then {
	hintSilent _msg;
	systemchat _msg;
};
