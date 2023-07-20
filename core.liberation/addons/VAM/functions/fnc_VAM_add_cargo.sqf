//diag_log VAM_arsenal_item;
if (GRLIB_build_version != "internal-dev") exitWith {systemchat str "Work in Progress!"};

if (count VAM_arsenal_item == 0) exitWith {};

private _msg = "";
private _id = VAM_arsenal_item select 1;
private _item = VAM_arsenal_class_names select _id;

//loadAbs _unit < (maxLoad _target - loadAbs _target)
if (VAM_targetvehicle canAdd _item) then {

	systemchat str _item;
	diag_log _item;
	//systemchat str VAM_targetvehicle;

	// pay item
	VAM_targetvehicle addItemCargoGlobal [_item, 1];
	
	_msg = format ["%1 added to Cargo.", ([_item] call F_getLRXName)];
} else {
	_msg = "Vehicle Inventory is Full!";
};

hintSilent _msg;
systemchat _msg;
