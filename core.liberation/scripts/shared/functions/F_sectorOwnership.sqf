params ["_position", ["_distance", GRLIB_capture_size]];

private _cap_thresold_count = 3;
private _cap_thresold_ratio = 0.85;
private _sectorside = GRLIB_side_civilian;
private _countblufor = [_position, _distance, GRLIB_side_friendly] call F_getUnitsCount;
private _countopfor = [_position, _distance, GRLIB_side_enemy] call F_getUnitsCount;

private _blufor_ratio = 0;
if (_countblufor + _countopfor != 0) then {
	_blufor_ratio = (_countblufor / (_countopfor + _countblufor));
};

if (_countblufor == 0) then {
	if (_countopfor <= _cap_thresold_count) then {
		_sectorside = GRLIB_side_civilian;
	} else {
		_sectorside = GRLIB_side_enemy;
	};
} else {
	if (_blufor_ratio >= _cap_thresold_ratio || _countopfor <= _cap_thresold_count) then {
		_sectorside = GRLIB_side_friendly;
	} else {
		_sectorside = GRLIB_side_enemy;
	};
};

_sectorside;
