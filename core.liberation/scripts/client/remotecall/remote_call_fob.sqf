params [ "_fobpos", "_status", ["_sector_timer", 0] ];

if (isDedicated || (!hasInterface && !isServer)) exitWith {};

private _fob_name = [_fobpos] call F_getFobName;
private _fob_type = "FOB";
if (_fobpos in GRLIB_all_outposts) then {_fob_type = "Outpost"};

sector_timer = _sector_timer;
if ( _status == 0 ) then {
	sleep 1;
	[ "lib_fob_built", [ _fob_type, _fob_name ] ] call BIS_fnc_showNotification;
};

if ( _status == 1 ) then {
	[ "lib_fob_attacked", [ _fob_type, _fob_name ] ] call BIS_fnc_showNotification;
	"opfor_capture_marker" setMarkerPosLocal _fobpos;
};

if ( _status == 2 ) then {
	[ "lib_fob_lost", [ _fob_type, _fob_name ] ] call BIS_fnc_showNotification;
	"opfor_capture_marker" setMarkerPosLocal markers_reset;
};

if ( _status == 3 ) then {
	[ "lib_fob_safe", [ _fob_type, _fob_name ] ] call BIS_fnc_showNotification;
	"opfor_capture_marker" setMarkerPosLocal markers_reset;
};

if ( _status == 4 ) then {
	if (player distance2D _fobpos > GRLIB_sector_size) then {
		[ "lib_fob_attacked", [ _fob_type, _fob_name ] ] call BIS_fnc_showNotification;
		"opfor_capture_marker" setMarkerPosLocal _fobpos;
	};
};

if ( _status == 5 ) then {
	sleep 4;
	[ "lib_fob_repacked", [ _fob_type, _fob_name ] ] call BIS_fnc_showNotification;
	"opfor_capture_marker" setMarkerPosLocal markers_reset;
};
