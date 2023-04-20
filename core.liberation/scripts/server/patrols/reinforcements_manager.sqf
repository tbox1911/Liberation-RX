params [ "_targetsector" ];

if (combat_readiness < 35 || GRLIB_csat_aggressivity < 1 || diag_fps < 35) exitWith {};

diag_log format ["Spawn Reinforcement on Sector %1 at %2", _targetsector, time];
private _nb_player = count (AllPlayers - (entities "HeadlessClient_F"));

if ( _targetsector in active_sectors ) then {
	// before attack
	private _nearestower = [markerpos _targetsector, GRLIB_side_enemy, GRLIB_radiotower_size * 1.4] call F_getNearestTower;
	if ( _nearestower != "" ) then {
		sleep (60 + floor(random 60));
		if (_targetsector in active_sectors) then {
			diag_log format ["Spawn Paratroopers on Sector %1 at %2", _targetsector, time];
			["lib_reinforcements", [markertext _targetsector]] remoteExec ["bis_fnc_shownotification", 0];
			[ markerPos _targetsector ] spawn send_paratroopers;
			stats_reinforcements_called = stats_reinforcements_called + 1;
		};
	};

	if ( combat_readiness >= 80 && _nb_player > 1 ) then {
		sleep (60 + floor(random 60));
		if (_targetsector in active_sectors) then {
			diag_log format ["Spawn Paratroopers on Sector %1 at %2", _targetsector, time];
			["lib_reinforcements", [markertext _targetsector]] remoteExec ["bis_fnc_shownotification", 0];
			[ markerPos _targetsector ] spawn send_paratroopers;
			stats_reinforcements_called = stats_reinforcements_called + 1;
		};
	};
} else {
	// after attack
	if !(_targetsector in blufor_sectors) exitWith {};
	private _sector1 = "";
	private _sector2 = "";
	private _sector3 = "";
	private _defensecount = 2;

	_sector1 = [GRLIB_sector_size * 2, markerpos _targetsector, (sectors_allSectors - blufor_sectors)] call F_getNearestSector;
	if (_sector1 != "" && !(_sector1 in active_sectors)) then {
		diag_log format ["Spawn Defense on Sector %1 at %2", _sector1, time];
		if ( _sector1 in sectors_tower) then {
			[_sector1, _defensecount] spawn static_manager;
		} else {
			[_sector1, (1 + floor (random 2))] spawn patrol_manager;
		};
		sleep 3;
		if ( _sector1 in sectors_military) then {
			[_sector1, 2] spawn patrol_manager;
		};
		stats_reinforcements_called = stats_reinforcements_called + 1;
	};
	sleep 5;

	if ( combat_readiness > 65 ) then {
		_sector2 = [GRLIB_sector_size * 3, markerpos _targetsector, (sectors_allSectors - blufor_sectors - [_sector1])] call F_getNearestSector;
		if (_sector2 != "" && !(_sector2 in active_sectors) && _nb_player > 1) then {
			diag_log format ["Spawn Defense on Sector %1 at %2", _sector2, time];
			if ( _sector2 in sectors_tower) then {
				[_sector2, _defensecount] spawn static_manager;
			} else {
				[_sector2, (1 + floor (random 2))] spawn patrol_manager;
			};
			sleep 3;
			if ( _sector2 in sectors_military) then {
				[_sector2, 2] spawn patrol_manager;
			};
			stats_reinforcements_called = stats_reinforcements_called + 1;
		};
	 };
	 sleep 5;

	if ( combat_readiness > 90 ) then {
		_sector3 = [GRLIB_sector_size * 4, markerpos _targetsector, (sectors_allSectors - blufor_sectors - [_sector1, _sector2])] call F_getNearestSector;
		if (_sector3 != "" && !(_sector3 in active_sectors) && _nb_player > 2) then {
			diag_log format ["Spawn Defense on Sector %1 at %2", _sector3, time];
			if ( _sector3 in sectors_tower) then {
				[_sector3, _defensecount] spawn static_manager;
			} else {
				[_sector3, (1 + floor (random 2))] spawn patrol_manager;
			};
			sleep 3;
			if ( _sector3 in sectors_military) then {
				[_sector3, 2] spawn patrol_manager;
			};
			stats_reinforcements_called = stats_reinforcements_called + 1;
		};
	 };
};

publicVariable "stats_reinforcements_called";
