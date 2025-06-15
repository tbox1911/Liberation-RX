createMarkerLocal ["opfor_bg_marker", markers_reset];
"opfor_bg_marker" setMarkerTypeLocal "mil_unknown";
"opfor_bg_marker" setMarkerColorLocal GRLIB_color_enemy_bright;

createMarkerLocal ["opfor_capture_marker", markers_reset];
"opfor_capture_marker" setMarkerTypeLocal "mil_objective";
"opfor_capture_marker" setMarkerColorLocal GRLIB_color_enemy_bright;

waitUntil {sleep 1; !isNil "sector_timer"};
private _sector_timer = 0;

while {true} do {
	sleep 1;
	_sector_timer = round (sector_timer - serverTime);
	if (_sector_timer > 0) then {
		"opfor_capture_marker" setMarkerTextLocal format ["%1",([_sector_timer] call F_secondsToTimer)];
	} else {
		"opfor_capture_marker" setMarkerTextLocal "VULNERABLE";
		waitUntil{ sleep 1;	(sector_timer - serverTime) > 0 };
	};
};