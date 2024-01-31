params [ "_startpos", ["_include_fob", true], ["_radius", (GRLIB_sector_size * 3)] ];

private _sector_pos = zeropos;
private _refdistance = 99999;
private _currentnearest = [_startpos, _refdistance];

if ( count GRLIB_all_fobs > 0 || count blufor_sectors > 0 ) then {
	// search FOB first
	if (_include_fob) then {
		{
			_sector_pos = _x;
			if ( _startpos distance2D _sector_pos < _refdistance ) then {
				_refdistance = round (_startpos distance2D _sector_pos);
				_currentnearest = [_sector_pos, _refdistance];
			};
		} foreach GRLIB_all_fobs;
	};

	// if nearset FOB too far, search sectors
	if (_refdistance > _radius) then {
		{
			_sector_pos = markerPos _x;
			if ((_startpos distance2D _sector_pos < _refdistance) && !([_startpos, _sector_pos] call F_isWaterBetween)) then {
				_refdistance = round (_startpos distance2D _sector_pos);
				_currentnearest = [_sector_pos, _refdistance];
			};
		} foreach blufor_sectors;
	};
};

_currentnearest
