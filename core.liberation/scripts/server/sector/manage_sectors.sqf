waitUntil {sleep 1; !isNil "GRLIB_init_server"};
sleep 3;

GRLIB_sector_spawning = false;
publicVariable "GRLIB_sector_spawning";

private ["_nextsector", "_unit", "_msg"];
private _countblufor = [];
private _hc_missions = [];
active_sectors_hc = [];

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	_countblufor = (AllPlayers - (entities "HeadlessClient_F")) select {
        (alive _x) && !(captive _x) &&
        (getPosATL _x select 2 < 150) && (speed vehicle _x <= 80)
    };

	{
		if (!opforcap_max && count active_sectors < GRLIB_max_active_sectors) then {
			_unit = _x;
			_nextsector = [GRLIB_sector_size, _unit, (opfor_sectors - active_sectors)] call F_getNearestSector;
			if (_nextsector != "") then {
				private _hc = [] call F_lessLoadedHC;
				if (isNull _hc) then {
					[_nextsector] spawn manage_one_sector;
				} else {
					diag_log format ["--- LRX Server: Sector: %1 spawned on %2", _nextsector, _hc];
					[_nextsector] remoteExec ["manage_one_sector", owner _hc];
					active_sectors_hc pushBack [_nextsector, _hc];
				};
				if (_nextsector in sectors_military) then {
					[_nextsector] spawn manage_ammoboxes;
				};
				sleep 30;
			};
		};
		sleep 0.1;
	} foreach _countblufor;

	_hc_missions = active_sectors_hc;
	{
		_nextsector = _x select 0;
		_hc = _x select 1;
		if (owner _hc == 2 && _nextsector in active_sectors) then {
			_msg = format ["Headless client %1 lost control of sector %2!", str _hc, _nextsector];
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
	if ([] call F_checkVictory) then { [] spawn blufor_victory };
	sleep 2;
};