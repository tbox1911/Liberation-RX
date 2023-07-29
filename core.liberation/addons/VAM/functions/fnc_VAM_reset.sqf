[VAM_targetvehicle, true, [true]] spawn bis_fnc_initVehicle;

private _VAM_display = findDisplay 4900;
(_VAM_display displayCtrl 4910) lbSetCurSel 0;

hint localize "STR_VAM_COMPLETE_RESET";
hint "";