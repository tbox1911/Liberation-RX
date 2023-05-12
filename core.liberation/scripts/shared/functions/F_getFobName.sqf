params [ "_fob" ];
private _fobname = "";
private _fobindex = -1;
private _currentidx = 0;

{
	if ( (_x distance2D _fob) < GRLIB_fob_range ) then {
		_fobindex = _currentidx;
	};
	_currentidx = _currentidx + 1;
} foreach GRLIB_all_fobs;

if ( _fobindex != -1 ) then {
	_fobname = military_alphabet select _fobindex;
};

_fobname
