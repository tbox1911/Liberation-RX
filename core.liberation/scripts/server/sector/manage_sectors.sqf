waitUntil {sleep 1; !isNil "GRLIB_init_server"};
sleep 30;

active_sectors_hc = [];
private _hc_missions = [];
private ["_sector", "_count_blu"];

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	{
		waitUntil { sleep 1; !GRLIB_sector_spawning && !opforcap_max && count active_sectors < GRLIB_max_active_sectors };
		_sector = _x;
		_count_blu = [markerPos _sector, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount;
		if (_count_blu > 0) then { [_sector] call start_sector };
		sleep 0.1;
	} forEach (opfor_sectors - active_sectors);

	_hc_missions = active_sectors_hc;
	{
		_nextsector = _x select 0;
		_hc = _x select 1;
		if (owner _hc == 2 && _nextsector in active_sectors) then {
			private _msg = format ["Headless client %1 lost control of sector %2!", str _hc, _nextsector];
			[gamelogic, _msg] remoteExec ["globalChat", 0];
			diag_log _msg;
			sleep 0.1;
			_msg = format ["Restarting sector %1 on Server, Warning!", _nextsector];
			[gamelogic, _msg] remoteExec ["globalChat", 0];
			active_sectors_hc = active_sectors_hc - [_x];
			active_sectors = active_sectors - [_nextsector];
			publicVariable "active_sectors";
			GRLIB_sector_spawning = false;
			publicVariable "GRLIB_sector_spawning";
			sleep 30;
		};

		if !(_nextsector in active_sectors) then {
			active_sectors_hc = active_sectors_hc - [_x];
		};
	} forEach _hc_missions;

	//diag_log format [ "Full sector scan at %1, active sectors: %2", time, active_sectors ];
	sleep 5;
};
