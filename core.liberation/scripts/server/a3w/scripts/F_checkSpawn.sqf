// Mission spawn trop proche d'un secteur capture
params ['_markers'];
private _list=[];

{
	private _item = true;
	private _position = markerPos _x;
	{
		if ( (_position distance2D ( markerPos _x)) <= GRLIB_spawn_min/2 ) exitWith { _item = false };
	} forEach blufor_sectors;

	{
		if ( (_position distance2D ( markerPos _x)) <= GRLIB_spawn_min/2 ) exitWith { _item = false };
	} forEach (sectors_allSectors - blufor_sectors);

	if ( (_position distance2D ([_position] call F_getNearestFob)) <= GRLIB_spawn_min ) then { _item = false };
	if ( ([_position] call F_getNearestBluforObjective select 1) > GRLIB_spawn_max ) then { _item = false };

	if ( _x in A3W_sectors_in_use ) then { _item = false };

	if (_item) then { _list pushback _x };
} forEach _markers;

_list;
