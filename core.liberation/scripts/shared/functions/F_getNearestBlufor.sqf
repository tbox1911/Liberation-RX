params ["_startpos", ["_radius", GRLIB_capture_size]];

private _target = selectRandom ((units GRLIB_side_friendly) select { alive _x && _x distance2D lhd > GRLIB_fob_range && _x distance2D _startpos < _radius && !([_x, uavs] call F_itemIsInClass) });
_target;
