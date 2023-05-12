[VAM_targetvehicle, true, [true]] call bis_fnc_initVehicle;
VAM_check_fnc_delay = false;

private _VAM_display = findDisplay 4900;
(_VAM_display displayCtrl 4910) lbSetCurSel 0;

hint localize "STR_VAM_COMPLETE_RESET";
hint "";