if (isDedicated || (!hasInterface && !isServer)) exitWith {};
params ["_sector", "_status", ["_info", 0]];

private _marker_pos = markerpos _sector;
if (_marker_pos isEqualTo [0,0,0]) exitWith {};
private _location_name = [_marker_pos] call F_getLocationName;

if (_status == 0) then {
	private _lst_player = "Thanks to: - ";
	{
		if (_x distance2D _marker_pos < GRLIB_sector_size) then {
			_lst_player = _lst_player + name _x + " - ";
		};
	} forEach allPlayers;
	["lib_sector_captured_info", [_lst_player], 3] call BIS_fnc_showNotification;
	["lib_sector_captured", [_location_name], 7] call BIS_fnc_showNotification;
};

if (_status == 1) then {
	["lib_sector_attacked", [_location_name]] call BIS_fnc_showNotification;
	"opfor_capture_marker" setMarkerPosLocal (markerpos _sector);
};

if (_status == 2) then {
	["lib_sector_lost", [_location_name]] call BIS_fnc_showNotification;
	"opfor_capture_marker" setMarkerPosLocal markers_reset;
};

if (_status == 3) then {
	["lib_sector_safe", [_location_name]] call BIS_fnc_showNotification;
	"opfor_capture_marker" setMarkerPosLocal markers_reset;
};

if (_status == 4) then {
	["lib_sector_building", [_info]] call BIS_fnc_showNotification;
};

{ _x setMarkerColorLocal GRLIB_color_friendly } foreach blufor_sectors;
{ _x setMarkerColorLocal GRLIB_color_enemy } foreach opfor_sectors;
