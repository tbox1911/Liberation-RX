params ["_warehouse_pos"];

private ["_typename", "_box_count", "_indx"];
{
	_typename = _x select 0;
	_box_count = _x select 1;
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
} foreach GRLIB_warehouse;
