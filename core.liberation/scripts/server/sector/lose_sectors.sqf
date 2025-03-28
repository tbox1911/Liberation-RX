waitUntil {sleep 1; !isNil "GRLIB_all_fobs" };
waitUntil {sleep 1; !isNil "blufor_sectors" };
waitUntil {sleep 1; (count (blufor_sectors) > 0 || count (GRLIB_all_fobs) > 0)};

attack_in_progress_cooldown = [];

private _countopfor = 0;
while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	{
		_countopfor = [markerpos _x, GRLIB_capture_size, GRLIB_side_enemy] call F_getUnitsCount;
		if (_countopfor > 3) then { [_x] call attack_in_progress_sector };
		sleep 0.1;
	} foreach blufor_sectors;

	{
		_countopfor = [_x, GRLIB_capture_size, GRLIB_side_enemy] call F_getUnitsCount;
		if (_countopfor > 3) then {	[_x] call attack_in_progress_fob };
		sleep 0.1;
	} foreach GRLIB_all_fobs;

	sleep 5;
};
