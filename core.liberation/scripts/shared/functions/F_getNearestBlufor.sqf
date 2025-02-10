params ["_startpos", ["_radius", GRLIB_capture_size]];
private _countblufor = (units GRLIB_side_friendly - units group chimeraofficer);
private _blufor_selected = _countblufor select {
	(alive _x) && !(captive _x) &&
	(getPosATL _x select 2 < 150) && (speed vehicle _x <= 80) &&
	(_x distance2D _startpos < _radius)
};
(selectRandom _blufor_selected);
