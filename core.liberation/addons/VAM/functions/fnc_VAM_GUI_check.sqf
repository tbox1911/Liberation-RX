//VAM Check
disableSerialization;

private _vehicle = VAM_targetvehicle;
private _vehicleclass = typeof _vehicle;
private _vehiclename = [_vehicleclass] call F_getLRXName;

private _VAM_display = findDisplay 4900;
private _currentvehicletext = _VAM_display displayCtrl 4950;
private _currentvehiclecargotext = _VAM_display displayCtrl 4952;

_currentvehicletext ctrlSetText _vehiclename;
_currentvehiclecargotext ctrlSetText ([_vehicle] call fnc_VAM_get_freecargo);

[] spawn fnc_VAM_common_setup;
