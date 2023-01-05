params [ "_fob_pos", "_status", ["_sector_timer", 0] ];

if (isDedicated || (!hasInterface && !isServer)) exitWith {};

private _fob_name = [_fob_pos] call F_getFobName;
private _fob_type = "FOB";
private _near_outpost = (count (_fob_pos nearObjects [FOB_outpost, 50]) > 0);
if (_near_outpost) then {_fob_type = "Outpost"};

if ( _status == 0 ) then {
	[ "lib_fob_built", [ _fob_type, _fob_name ] ] call BIS_fnc_showNotification;
};

if ( _status == 1 ) then {
	[ "lib_fob_attacked", [ _fob_type, _fob_name ] ] call BIS_fnc_showNotification;
	"opfor_capture_marker" setMarkerPosLocal _fob_pos;
	sector_timer = _sector_timer;
};

if ( _status == 2 ) then {
	[ "lib_fob_lost", [ _fob_type, _fob_name ] ] call BIS_fnc_showNotification;
	"opfor_capture_marker" setMarkerPosLocal markers_reset;
	sector_timer = _sector_timer;
};

if ( _status == 3 ) then {
	[ "lib_fob_safe", [ _fob_type, _fob_name ] ] call BIS_fnc_showNotification;
	"opfor_capture_marker" setMarkerPosLocal markers_reset;
	sector_timer = _sector_timer;
};

if ( _status == 4 ) then {
	if (player distance2D _fob_pos > GRLIB_sector_size) then {
		[ "lib_fob_attacked", [ _fob_type, _fob_name ] ] call BIS_fnc_showNotification;
	};
};
