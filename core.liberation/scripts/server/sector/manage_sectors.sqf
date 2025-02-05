waitUntil {sleep 1; !isNil "save_is_loaded"};
sleep 3;

GRLIB_sector_spawning = false;
publicVariable "GRLIB_sector_spawning";

private ["_nextsector", "_unit"];
private _countblufor = [];

active_sectors_hc = [];

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	_countblufor = (units GRLIB_side_friendly - units group chimeraofficer) select {
		(alive _x) && !(captive _x) &&
		(getPos _x select 2 < 50) && (speed (vehicle _x) <= 80)
	};

	{
		if (opforcap < GRLIB_opfor_cap && count active_sectors < GRLIB_max_active_sectors) then {
			_unit = _x;
			_nextsector = [GRLIB_sector_size, _unit, opfor_sectors] call F_getNearestSector;
			if (_nextsector != "" && !(_nextsector in active_sectors)) then {
				private _hc = [] call F_lessLoadedHC;
				if (isNull _hc) then {
					[_nextsector] spawn manage_one_sector;
				} else {
					diag_log format ["Sector: %1 spawned on %2", _nextsector, _hc];
					[_nextsector] remoteExec ["manage_one_sector", owner _hc];
					active_sectors_hc pushBack [_nextsector, _hc];
				};
				if (_nextsector in sectors_military) then {
					[_nextsector] spawn manage_ammoboxes;
				};
				sleep 2;
			};
		};
	} foreach _countblufor;

	// check HC sectors
	{
		_nextsector = _x select 0:
		_hc = _x select 1;
		if (owner _hc == 0 && _nextsector in opfor_sectors) then {
			gamelogic globalChat format ["Headless client %1 lost sector %2 management.", _hc, _nextsector];
			active_sectors = active_sectors - [_nextsector];
			publicVariable "active_sectors";
			active_sectors_hc = active_sectors_hc - [_x];
			sleep 1;		
		};
	} forEach active_sectors_hc;

	//diag_log format [ "Full sector scan at %1, active sectors: %2", time, active_sectors ];
	if ([] call F_checkVictory) then { [] spawn blufor_victory };
	sleep 2;
};