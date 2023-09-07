// Mission spawn trop proche d'un secteur capture
params ['_markers'];
private _list = [];

{
	private _item = true;
	private _position = markerPos _x;
	if ( ([_position] call F_getNearestBluforObjective select 1) < GRLIB_sector_size ) then { _item = false };
	if ( _x in A3W_sectors_in_use ) then { _item = false };
	if (_item) then { _list pushback _x };
} forEach _markers;

_list;
