params [ "_startpos", ["_include_fob", true], ["_check_water", true] ];

private _radius = (GRLIB_sector_size * 2.5);
private _sector_pos = zeropos;
private _sector_dist = 0;
private _refdistance = 99999;
private _currentnearest = [_startpos, _refdistance];
private _is_water = false;

if ( count GRLIB_all_fobs > 0 || count blufor_sectors > 0 ) then {
	// search units
	private _target = selectRandom ((units GRLIB_side_friendly) select { _x distance2D lhd > GRLIB_fob_range && _x distance2D _startpos < _radius && !([_x, uavs] call F_itemIsInClass) });
	if (!isNil "_target") then {
		_sector_pos = getPosATL _target;
		_refdistance = round (_target distance2D _startpos);
		_currentnearest = [_sector_pos, _refdistance];
	};

	// search FOB first
	if (_refdistance > _radius && _include_fob) then {
		{
			_sector_pos = _x;
			_sector_dist = _startpos distance2D _sector_pos;
			if ( _sector_dist < _refdistance ) then {
				_refdistance = round _sector_dist;
				_currentnearest = [_sector_pos, _refdistance];
			};
		} foreach GRLIB_all_fobs;
	};

	// search sectors
	if (_refdistance > _radius) then {
		{
			_sector_pos = markerPos _x;
			_sector_dist = _startpos distance2D _sector_pos;
			_is_water = false;
			if (_check_water) then {
				_is_water = [_startpos, _sector_pos] call F_isWaterBetween;
			};
			if ((_sector_dist < _refdistance) && !_is_water) then {
				_refdistance = round _sector_dist;
				_currentnearest = [_sector_pos, _refdistance];
			};
		} foreach blufor_sectors;
	};
};

_currentnearest;
