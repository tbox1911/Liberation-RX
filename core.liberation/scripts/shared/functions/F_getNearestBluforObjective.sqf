params ["_startpos", ["_check_water", true]];

private _sector_pos = zeropos;
private _sector_dist = 0;
private _refdistance = 99999;
private _currentnearest = [_startpos, _refdistance];
private _currentnearest_fob = [_startpos, _refdistance];
private _currentnearest_sect = [_startpos, _refdistance];
private _is_water = false;

if (count GRLIB_all_fobs > 0 || count blufor_sectors > 0) then {
	// search units
	private _target = [_startpos, GRLIB_sector_size] call F_getNearestBlufor;
	if (!isNil "_target") exitWith {
		_sector_pos = getPosATL _target;
		_refdistance = round (_target distance2D _startpos);
		_currentnearest = [_sector_pos, _refdistance];
	};

	// search FOB
	_refdistance = 99999;
	{
		_sector_pos = _x;
		_sector_dist = _startpos distance2D _sector_pos;
		_is_water = false;
		if (_check_water) then {
			_is_water = [_startpos, _sector_pos] call F_isWaterBetween;
		};
		if (_sector_dist < _refdistance && !_is_water) then {
			_refdistance = round _sector_dist;
			_currentnearest_fob = [_sector_pos, _refdistance];
		};
	} foreach GRLIB_all_fobs;

	// search sectors
	_refdistance = 99999;
	{
		_sector_pos = markerPos _x;
		_sector_dist = _startpos distance2D _sector_pos;
		_is_water = false;
		if (_check_water) then {
			_is_water = [_startpos, _sector_pos] call F_isWaterBetween;
		};
		if (_sector_dist < _refdistance && !_is_water) then {
			_refdistance = round _sector_dist;
			_currentnearest_sect = [_sector_pos, _refdistance];
		};
	} foreach blufor_sectors;

	if ( 0 max ((_currentnearest_fob select 1) - 400) < (_currentnearest_sect select 1)) then {
		_currentnearest = _currentnearest_fob;
	} else {
		_currentnearest = _currentnearest_sect;
	};
};

_currentnearest;
