waitUntil {sleep 1; !isNil "GRLIB_all_fobs" };
waitUntil {sleep 1; !isNil "blufor_sectors" };
waitUntil {sleep 1; (count (blufor_sectors) > 0 || count (GRLIB_all_fobs) > 0)};

attack_in_progress = [];

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	{
		_ownership = [ markerpos _x ] call F_sectorOwnership;
		if ( _ownership == GRLIB_side_enemy ) then {
			[ _x ] call attack_in_progress_sector;
		};
		sleep 0.1;
	} foreach blufor_sectors;

	{
		_ownership = [ _x ] call F_sectorOwnership;
		if ( _ownership == GRLIB_side_enemy ) then {
			[ _x ] call attack_in_progress_fob;
		};
		sleep 0.1;
	} foreach GRLIB_all_fobs;

	sleep 5;
};
