[VAM_targetvehicle, true, [true]] spawn bis_fnc_initVehicle;

private _VAM_display = findDisplay 4900;
(_VAM_display displayCtrl 4910) lbSetCurSel 0;

private _list_comp = _VAM_display displayCtrl 4920;
{
	comp_class_names set [_forEachIndex, 0];
	_list_comp lbSetSelected [_forEachIndex, false];
} forEach comp_class_names;

VAM_targetvehicle setVariable ["GRLIB_vehicle_color", "", true];
VAM_targetvehicle setVariable ["GRLIB_vehicle_color_name", "", true];
VAM_targetvehicle setVariable ["GRLIB_vehicle_composant", [], true];

hintSilent localize "STR_VAM_COMPLETE_RESET";
