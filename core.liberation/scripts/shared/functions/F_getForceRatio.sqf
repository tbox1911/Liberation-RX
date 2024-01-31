params [ "_sector" ];
private [ "_actual_capture_size", "_red_forces", "_blue_forces", "_ratio" ];

private _actual_capture_size = GRLIB_capture_size;
if ( _sector in sectors_bigtown ) then {
	_actual_capture_size = GRLIB_capture_size * 1.4;
};

private _red_forces = [(markerpos _sector), _actual_capture_size, GRLIB_side_enemy] call F_getUnitsCount;
private _blue_forces = [(markerpos _sector), _actual_capture_size, GRLIB_side_friendly] call F_getUnitsCount;

if (_blue_forces == 0 || _red_forces == 0) exitWith {
	private _ret = 0;
	if (_sector in blufor_sectors) then { _ret = 1 };
	_ret; 
};
(_blue_forces / (_red_forces + _blue_forces));
