// VAM Common Vehicle GUI Setup
disableSerialization;
private _VAM_display = findDisplay 4900;
private _list_camo = _VAM_display displayCtrl 4910;
private _list_comp = _VAM_display displayCtrl 4920;
private _list_arsenal = _VAM_display displayCtrl 4921;
private _reset = _VAM_display displayCtrl 4940;
private _confirm = _VAM_display displayCtrl 4930;

// Get A3 camouflages (texture sets)
camo_class_names = [];
camo_display_names = [];

private _camo_path = "true" configClasses (configOf VAM_targetvehicle >> "TextureSources");
{
	camo_class_names pushBack (configName _x);
	camo_display_names pushBack (configName _x);
} forEach _camo_path;

// Get LRX camouflages (static, custom textures set)
{
	if (count _x > 2) then {
		if (PAR_Grp_ID in (_x select 2)) then {
			camo_display_names pushBack (_x select 0);
			camo_class_names pushBack (_x select 1);
		};
	} else {
		camo_display_names pushBack (_x select 0);
		camo_class_names pushBack (_x select 1);
	};
} forEach RPT_colorList;

// Get all components(animations)
comp_class_names = [];
comp_display_names = [];

private _getvc = [VAM_targetvehicle] call BIS_fnc_getVehicleCustomization;
private _check_comp = _getvc select 1;
{
	if (typeName _x == "SCALAR") then { comp_class_names pushBack 0 };
	if (typeName _x == "STRING") then {
		_name = getText (configOf VAM_targetvehicle >> "AnimationSources" >> _x >> "DisplayName");
		if (_name == "") then { _name = _x };
		comp_display_names pushBack _name;
	};
} forEach _check_comp;

private _saved_comp_class = VAM_targetvehicle getVariable ["GRLIB_vehicle_composant", []];
if (count _saved_comp_class > 0) then {
	comp_class_names = _saved_comp_class;
};

// Put camouflages and components in list
if (camo_class_names isEqualTo []) then {
	_list_camo lbAdd localize "STR_VAM_NO_CAMOUFLAGE";
} else {
	{
		_name = getText (configOf VAM_targetvehicle >> "TextureSources" >> _x >> "DisplayName");
		if (_name != "") then {
			_list_camo lbAdd _name;
		} else {
			_list_camo lbAdd _x;
		};	
	} forEach camo_display_names;
};
if (count comp_class_names == 0) then {
	_list_comp lbAdd localize "STR_VAM_NO_COMPONENT";
} else {
	{_list_comp lbAdd _x} forEach comp_display_names;
};

VAM_arsenal_item = [];
if (count VAM_arsenal_class_names == 0) then {
	_list_arsenal lbAdd localize "STR_VAM_NO_COMPONENT";
} else {
	{_list_arsenal lbAdd ([_x] call F_getLRXName)} forEach VAM_arsenal_class_names;
	_list_arsenal ctrlAddEventHandler ["LBSelChanged", {
		params ["_control", "_lbCurSel", "_lbSelection"];
		VAM_arsenal_item = _this;
		_control ctrlSetTooltip (VAM_arsenal_class_names select _lbCurSel);
	}];	
};

if (count camo_class_names > 0) then {
	[] call fnc_VAM_common_camo_check;
	_list_camo ctrlAddEventHandler ["LBSelChanged", {[] spawn fnc_VAM_common_camo;}];
};
if (count comp_class_names > 0) then {
	[] call fnc_VAM_common_comp_check;
	_list_comp ctrlAddEventHandler ["LBSelChanged", {[] spawn fnc_VAM_common_comp;}];
};

_reset ctrlAddEventHandler ["ButtonClick", {[] spawn fnc_VAM_common_camo_check; [] spawn fnc_VAM_common_comp_check;}];
//_confirm ctrlAddEventHandler ["ButtonClick", {[] spawn fnc_VAM_variable_cleaner;}];