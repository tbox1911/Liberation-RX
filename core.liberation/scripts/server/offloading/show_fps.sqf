private [ "_sourcestr", "_position", "_myfpsmarker", "_myfps"];

waitUntil{ sleep 1; !isNil "opfor_sectors" };

_sourcestr = "Server";
_position = 0;
_myfpsmarker = createMarker [ format ["fpsmarker%1", _sourcestr ], [ 200, 200 + (200 * _position) ] ];
_myfpsmarker setMarkerType "mil_start";
_myfpsmarker setMarkerSize [ 0.7, 0.7 ];

while { true } do {
	_myfps = diag_fps;
	_myfpsmarker setMarkerColor "ColorGREEN";
	if ( _myfps < 30 ) then { _myfpsmarker setMarkerColor "ColorYELLOW"; };
	if ( _myfps < 20 ) then { _myfpsmarker setMarkerColor "ColorORANGE"; };
	if ( _myfps < 10 ) then { _myfpsmarker setMarkerColor "ColorRED"; };

	_myfpsmarker setMarkerText format [ "%1: %2 fps - Up: %6 - civ:%3 blu:%4 red:%5",
		_sourcestr, ( round ( _myfps * 100.0 ) ) / 100.0 ,
		civcap, unitcap, opforcap,
		[time/3600,"HH:MM:SS"] call BIS_fnc_timeToString];

	sleep 15;
};
