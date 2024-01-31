private [ "_sourcestr", "_position", "_myfpsmarker", "_myfps", "_opforcap", "_civcap"];

waitUntil{ sleep 1; !isNil "opfor_sectors" };
waitUntil{ sleep 1; !isNil "unitcap" };

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

	_opforcap = opforcap;
	_civcap = civcap;
	if (count (entities "HeadlessClient_F") > 0) then {
		_opforcap = { alive _x && local _x && !(captive _x) } count (units GRLIB_side_enemy);
		_civcap = { alive _x && local _x && !(typeOf _x in [SHOP_Man, SELL_Man, WRHS_Man, commander_classname])} count (units GRLIB_side_civilian);
	};

	_myfpsmarker setMarkerText format [ "%1: %2 fps - Up: %6 - civ:%3 blu:%4 red:%5",
		_sourcestr, ( round ( _myfps * 100.0 ) ) / 100.0 ,
		_civcap, unitcap, _opforcap,
		[time/3600,"HH:MM:SS"] call BIS_fnc_timeToString];

	sleep 15;
};
