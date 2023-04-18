params ["_owner"];
private _warehouse = _owner getVariable ["GRLIB_Warehouse", objNull];
if (isNull _warehouse) exitWith {};
private _warehouse_pos = getPosATL _warehouse;

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

// update others warehouse
{
	if (typeOf _x == "B_RangeMaster_F" && _x != _owner) then {
		if (!isNull (_x getVariable ["GRLIB_Warehouse", objNull])) then {
			[_x] call warehouse_update_remote_call;
		};
	};
} forEach (units (group chimeraofficer));