//VAM Common Vehicle Camouflage Check
disableSerialization;
waitUntil {sleep 0.1; !(VAM_check_fnc_delay)};
private _VAM_display = findDisplay 4900;
private _list_camo = _VAM_display displayCtrl 4910;

private _current_camo = VAM_targetvehicle getVariable ["GRLIB_vehicle_color", ""];
_list_camo lbSetCurSel (camo_class_names find _current_camo);

VAM_camo_check_complete = true;
