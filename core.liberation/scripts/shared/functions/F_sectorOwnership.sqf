params [ "_thatpos", [ "_localsize", GRLIB_capture_size ] ];

private _cap_thresold_count = 3;
private _cap_thresold_ratio = 0.75;
private _sectorside = GRLIB_side_civilian;
private _countblufor_ownership = [_thatpos, _localsize, GRLIB_side_friendly] call F_getUnitsCount;
private _countopfor_ownership = [_thatpos, _localsize, GRLIB_side_enemy] call F_getUnitsCount;

private _blufor_ratio = 0;
if ( _countblufor_ownership + _countopfor_ownership != 0 ) then {
	_blufor_ratio = _countblufor_ownership / ( _countblufor_ownership + _countopfor_ownership);
};

if ( _countblufor_ownership == 0 ) then {
	if ( _countopfor_ownership <= _cap_thresold_count ) then {
		_sectorside = GRLIB_side_civilian;
	} else {
		_sectorside = GRLIB_side_enemy;
	};
} else {
	if ( _blufor_ratio >= _cap_thresold_ratio ) then {
		_sectorside = GRLIB_side_friendly;
	} else {
		_sectorside = GRLIB_side_enemy;
	};
};

//radio is down
if ( [_thatpos, GRLIB_side_enemy, GRLIB_capture_size] call F_getNearestTower != "" ) then {
	private _towers = [ nearestObjects [ _thatpos, [Radio_tower], 50], {
		alive _x &&
		(_x getVariable ['GRLIB_Radio_Tower', false]) 
	}] call BIS_fnc_conditionalSelect;

	if (count _towers > 0) then {
		_sectorside = GRLIB_side_enemy;
	};
};

_sectorside
