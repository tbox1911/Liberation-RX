params ["_startpos", ["_radius", GRLIB_capture_size]];
private _blufor_selected = (units GRLIB_side_friendly) select {
	(_x distance2D _startpos < _radius) &&
	(alive _x) && !(captive _x) &&
	(getPosATL _x select 2 < 150) && (speed vehicle _x <= 80)
};
(selectRandom _blufor_selected);
