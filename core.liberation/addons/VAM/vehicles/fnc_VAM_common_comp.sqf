//VAM Common Vehicle Comp Apply
disableSerialization;
private _VAM_display = findDisplay 4900;

private _list_selection = -1;
if (!(isNull _VAM_display)) then {
    _list_comp = _VAM_display displayCtrl 4920;
    _list_selection = lbSelection _list_comp select 0;
};

private _comp_array_total = [];
if (_list_selection >= 0) then {
	private _comp_array = current_comp;
	private "_comp_change";
	if (_comp_array select _list_selection isEqualTo 0) then {_comp_change = 1;};
	if (_comp_array select _list_selection isEqualTo 1) then {_comp_change = 0;};
	_comp_array set [_list_selection, _comp_change];

	{
		_comp_array_total pushBack (comp_class_names select _forEachIndex);
		_comp_array_total pushBack (_comp_array select _forEachIndex);
	} forEach comp_class_names;
} else {
	_comp_array_total = comp_class_names;
};

private _vehicle = VAM_targetvehicle;
[_vehicle,nil,_comp_array_total,nil] call BIS_fnc_initVehicle;

_vehicle setVariable ["GRLIB_vehicle_composant", _comp_array_total, true];

if (_list_selection >= 0) then {
	[] spawn fnc_VAM_common_comp_check;
};
