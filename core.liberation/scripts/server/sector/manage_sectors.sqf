waitUntil {sleep 1; !isNil "opfor_sectors" };
waitUntil {sleep 1; !isNil "active_sectors" };

private ["_nextsector", "_hc"];

while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	{
		_nextsector = _x;
		if ( opforcap < GRLIB_opfor_cap && count active_sectors < GRLIB_max_active_sectors && !(_nextsector in active_sectors) ) then {
			if ( ([markerPos  _nextsector, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount > 0) ) then {
				private _hc = [] call F_lessLoadedHC;
				if (isNull _hc) then {
					[_nextsector] spawn manage_one_sector;
				} else {
					diag_log format [ "Sector: %1 spawned on %2", _nextsector, _hc ];
					[_nextsector] remoteExec ["manage_one_sector", owner _hc];
				};
				if ( _nextsector in sectors_military ) then {
					[_nextsector] spawn manage_ammoboxes;
				};
			};
		};
		sleep 0.25;
	} foreach opfor_sectors;

	//diag_log format [ "Full sector scan at %1, active sectors: %2", time, active_sectors ];
	if ([] call F_checkVictory) then { [] spawn blufor_victory };
	sleep 5;
};