// VAM Common Vehicle GUI Setup
disableSerialization;
private _VAM_display = findDisplay 4900;
private _list_camo = _VAM_display displayCtrl 4910;
private _list_comp = _VAM_display displayCtrl 4920;
private _list_arsenal = _VAM_display displayCtrl 4921;
private _reset = _VAM_display displayCtrl 4940;
private _confirm = _VAM_display displayCtrl 4930;

camo_class_names = [];
camo_display_names = [];
comp_class_names = [];

// Get A3 camouflages (texture sets)
private _camo_path = "true" configClasses (configOf VAM_targetvehicle >> "TextureSources");
{
	camo_class_names pushBack (configName _x);
	camo_display_names pushBack (configName _x);
} forEach _camo_path;

// Get LRX camouflages (static, custom textures set)
{
	camo_display_names pushBack (_x select 0);
	camo_class_names pushBack (_x select 1);
} forEach RPT_colorList;

// Get all components(animations)
private _getvc = [VAM_targetvehicle] call BIS_fnc_getVehicleCustomization;
private _check_comp = _getvc select 1;
{
	if (_x isEqualType "STRING") then {
		comp_class_names pushBack (_check_comp select _forEachIndex);
	};
} forEach _check_comp;
comp_display_names = [];
{
	_name = getText (configOf VAM_targetvehicle >> "AnimationSources" >> _x >> "DisplayName");
	comp_display_names pushBack _name;
} forEach comp_class_names;

{
	if (_x isEqualTo "") then {
		comp_display_names set [_forEachIndex, comp_class_names select _forEachIndex];
	};
} forEach comp_display_names;

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
if (comp_class_names isEqualTo []) then {
	_list_comp lbAdd localize "STR_VAM_NO_COMPONENT";
} else {
	{_list_comp lbAdd _x} forEach comp_display_names;
};
if (VAM_arsenal_class_names isEqualTo []) then {
	_list_arsenal lbAdd localize "STR_VAM_NO_COMPONENT";
} else {
	{_list_arsenal lbAdd ([_x] call F_getLRXName)} forEach VAM_arsenal_class_names;
};

// Spawn check functions
VAM_arsenal_item = [];
VAM_camo_check_complete = true;
VAM_comp_check_complete = true;
VAM_check_fnc_delay = false;

if !(camo_class_names isEqualTo []) then {
	[] spawn fnc_VAM_common_camo_check;
	VAM_camo_check_complete = false;
};
if !(comp_class_names isEqualTo []) then {
	[] spawn fnc_VAM_common_comp_check;
	VAM_comp_check_complete = false;
};
waitUntil {uisleep 0.1; VAM_camo_check_complete && VAM_comp_check_complete};

// Add UIEH
if !(camo_class_names isEqualTo []) then {
	_list_camo ctrlAddEventHandler ["LBSelChanged", {[] spawn fnc_VAM_common_camo;}];
};
if !(comp_class_names isEqualTo []) then {
	_list_comp ctrlAddEventHandler ["LBSelChanged", {[] spawn fnc_VAM_common_comp;}];
};
if !(VAM_arsenal_class_names isEqualTo []) then {
	_list_arsenal ctrlAddEventHandler ["LBSelChanged", {
		params ["_control", "_lbCurSel", "_lbSelection"];
		VAM_arsenal_item = _this;
		_control ctrlSetTooltip (VAM_arsenal_class_names select _lbCurSel);
	}];
};

_reset ctrlAddEventHandler ["ButtonClick", {VAM_check_fnc_delay = true; [] spawn fnc_VAM_common_camo_check; [] spawn fnc_VAM_common_comp_check;}];
//_confirm ctrlAddEventHandler ["ButtonClick", {[] spawn fnc_VAM_variable_cleaner;}];