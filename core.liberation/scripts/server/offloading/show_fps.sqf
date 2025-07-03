private [ "_sourcestr", "_position", "_myfpsmarker", "_myfps", "_bluforcap", "_opforcap", "_civcap"];

_sourcestr = "Server";
_position = 0;
_myfpsmarker = createMarkerLocal [format ["fpsmarker%1", _sourcestr ], [200, 200 + (200 * _position)]];
_myfpsmarker setMarkerTypeLocal "mil_start";
_myfpsmarker setMarkerSizeLocal [0.7, 0.7];

while {true} do {
	_myfps = diag_fps;
	_myfpsmarker setMarkerColorLocal "ColorGREEN";
	if ( _myfps < 30 ) then { _myfpsmarker setMarkerColorLocal "ColorYELLOW"; };
	if ( _myfps < 20 ) then { _myfpsmarker setMarkerColorLocal "ColorORANGE"; };
	if ( _myfps < 10 ) then { _myfpsmarker setMarkerColorLocal "ColorRED"; };

	_bluforcap = { alive _x && local _x && !(captive _x) && (_x distance2D lhd) >= 200 } count (units GRLIB_side_friendly);
	_opforcap = { alive _x && local _x && !(captive _x) } count (units GRLIB_side_enemy);
	_civcap = { alive _x && local _x  && !(captive _x) && !(isAgent teamMember _x) } count (units GRLIB_side_civilian);

	_myfpsmarker setMarkerText format [ "%1: %2 fps - Up: %6 - civ:%3 blu:%4 red:%5",
		_sourcestr, ( round ( _myfps * 100.0 ) ) / 100.0 ,
		_civcap, _bluforcap, _opforcap,
		[time/3600,"HH:MM:SS"] call BIS_fnc_timeToString];

	sleep 15;
};
