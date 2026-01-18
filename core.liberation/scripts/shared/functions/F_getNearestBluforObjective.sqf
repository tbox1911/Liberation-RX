params ["_startpos", ["_check_water", true]];

private ["_sector_pos", "_refdistance"];
private _nearest_fob = [];
private _nearest_sect = [];
private _nearest = [];

// search BLUFOR Units
private _target = [_startpos, GRLIB_sector_size] call F_getNearestBlufor;
if (!isNull _target) exitWith {
	_sector_pos = getPos _target;
	_refdistance = round (_target distance2D _startpos);
	[_sector_pos, _refdistance];
};

// search FOB
if (count GRLIB_all_fobs > 0) then {
	_sector_pos = [_startpos, false, _check_water] call F_getNearestFob;
	_refdistance = round (_startpos distance2D _sector_pos);
	if (_refdistance <= GRLIB_spawn_max) then {
		_nearest_fob = [_sector_pos, _refdistance];
	};
};

// search BLUFOR Sectors
if (count blufor_sectors > 0) then {
	_next_sector = [GRLIB_spawn_max, _startpos, blufor_sectors, _check_water] call F_getNearestSector;
	if (_next_sector != "") then {
		_sector_pos = markerPos _next_sector;
		_refdistance = round (_startpos distance2D _sector_pos);
		_nearest_sect = [_sector_pos, _refdistance];
	};
};

// Check
if (count _nearest_fob > 0) then {
	if (count _nearest_sect > 0) then {
		if (((_nearest_fob select 1) - GRLIB_sector_size) < (_nearest_sect select 1)) then {
			_nearest = _nearest_fob;
		} else {
			_nearest = _nearest_sect;
		};
	} else {
		_nearest = _nearest_fob;
	}
} else {
	if (count _nearest_sect > 0) then {
		_nearest = _nearest_sect;
	} else {
		_nearest = [_startpos, 999999];
	};
};

_nearest;
