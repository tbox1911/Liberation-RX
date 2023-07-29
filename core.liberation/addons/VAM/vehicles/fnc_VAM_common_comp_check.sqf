//VAM Common Vehicle Component Check
private _VAM_display = findDisplay 4900;
private _list_comp = _VAM_display displayCtrl 4920;


private _current_comp = VAM_targetvehicle getVariable ["GRLIB_vehicle_composant", []];
//Check current applied components
{
	if (_x == 1) then {
		_list_comp lbSetSelected [_forEachIndex, true];
	} else {
		_list_comp lbSetSelected [_forEachIndex, false];
	};
} forEach _current_comp;
