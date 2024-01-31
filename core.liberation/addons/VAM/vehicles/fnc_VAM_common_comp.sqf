//VAM Common Vehicle Comp Apply
disableSerialization;
private _VAM_display = findDisplay 4900;

private _list_selection = -1;
if (!(isNull _VAM_display)) then {
    _list_comp = _VAM_display displayCtrl 4920;
    _list_selection = lbSelection _list_comp select 0;
};

if (isNil "_list_selection") exitWith {};
private _vehicle = VAM_targetvehicle;
private _compo = comp_class_names;
private _state = 0;

if (_list_selection >= 0) then {
	_state = 1;
	if ((_compo select _list_selection) == 1) then { _state = 0 };
	_compo set [_list_selection, _state];
};

private _getvc = [_vehicle] call BIS_fnc_getVehicleCustomization;
private _comp_class_veh = _getvc select 1;

private _comp_veh_final = [];
private _comp_class_veh_final = [];
private _indx = 0;
private _name = "";
{
	if (typeName _x == "SCALAR") then {
		_state = 0;
		if (_indx < count _compo) then { _state = _compo select _indx };
		_comp_class_veh_final pushBack _name;
		_comp_class_veh_final pushBack _state;
		_comp_veh_final pushBack _state;
		_indx = _indx + 1;
	} else { _name = _x };
} forEach _comp_class_veh;

[_vehicle, false, _comp_class_veh_final] spawn BIS_fnc_initVehicle;

_vehicle setVariable ["GRLIB_vehicle_composant", _comp_veh_final, true];

if (_list_selection >= 0) then {
	[] spawn fnc_VAM_common_comp_check;
};
