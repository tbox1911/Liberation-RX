params ["_warehouse_pos"];

private ["_typename", "_box_count", "_indx"];
{
	_typename = _x;
	_box_count = GRLIB_warehouse get _typename;
	_indx = 0;
	{
		if (getPosATL _x distance2D _warehouse_pos < 20) then {
			if (_indx >= _box_count) then {
				_x hideObjectGlobal true;
			} else {
				_x hideObjectGlobal false;
			};
			_indx = _indx + 1;
		};
	} foreach allSimpleObjects [_typename];
} foreach (keys GRLIB_warehouse);
