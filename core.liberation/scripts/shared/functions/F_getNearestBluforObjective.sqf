params [ "_startpos" ];

private _currentnearest = [];
private _refdistance = 99999;
private _tpositions = [];

if ( count GRLIB_all_fobs != 0 || count blufor_sectors != 0 ) then {
	// search FOB first
	{ _tpositions pushback _x; } foreach GRLIB_all_fobs;

	{
		if ( _startpos distance2D _x < _refdistance ) then {
			_refdistance = round (_startpos distance2D _x);
			_currentnearest = [_x,_refdistance];
		};
	} foreach _tpositions;

	// if nearset FOB too far, search sectors
	if ( _refdistance > 2000 ) then {
		{ _tpositions pushback (markerpos _x); } foreach blufor_sectors;

		{
			if ( _startpos distance2D _x < _refdistance ) then {
				_refdistance = round (_startpos distance2D _x);
				_currentnearest = [_x,_refdistance];
			};
		} foreach _tpositions;
	};
} else {
	_currentnearest = _startpos;
};

_currentnearest
