//VAM Common Vehicle Component Check
private _VAM_display = findDisplay 4900;
private _list_comp = _VAM_display displayCtrl 4920;

//Check current applied components
{
	if (_x == 1) then {
		_list_comp lbSetSelected [_forEachIndex, true];
	} else {
		_list_comp lbSetSelected [_forEachIndex, false];
	};
} forEach comp_class_names;
