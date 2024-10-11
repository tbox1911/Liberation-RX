params ["_startpos", ["_radius", GRLIB_capture_size]];
private _countblufor = (units GRLIB_side_friendly - units group chimeraofficer);
(selectRandom (_countblufor select {
	alive _x &&
	_x distance2D lhd > GRLIB_fob_range &&
	_x distance2D _startpos < _radius &&
	!(typeOf _x in uavs_vehicles)
	})
);