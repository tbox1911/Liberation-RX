// Mission spawn trop proche d'un secteur capture
params ['_markers'];

private _list = _markers select {
	(([markerPos _x, true, false] call F_getNearestBluforObjective select 1) >= GRLIB_sector_size) &&
	!( _x in (A3W_sectors_in_use + active_sectors))
};
_list;
