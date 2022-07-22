params [ "_targetsector" ];
diag_log format ["Spawn Reinforcement Sector %1 at %2", _targetsector, time];
if (combat_readiness > 15) then {
	_init_units_count = (([ getMarkerPos _targetsector, GRLIB_capture_size, GRLIB_side_enemy ] call F_getUnitsCount));

	if (!(_targetsector in sectors_bigtown)) then {
		while { (_init_units_count * 0.75) <= ( [ getMarkerPos _targetsector, GRLIB_capture_size, GRLIB_side_enemy ] call F_getUnitsCount) } do {
			sleep 5;
		};
	};

	if (_targetsector in active_sectors) then {
		_nearestower = [markerPos _targetsector, GRLIB_side_enemy, GRLIB_radiotower_size * 1.4] call F_getNearestTower;

		if (_nearestower != "") then {
			_reinforcements_time = (((((markerPos _nearestower) distance (markerPos _targetsector)) / 1000) ^ 1.66 ) * 120) / (GRLIB_difficulty_modifier * GRLIB_csat_aggressivity);
			if (_targetsector in sectors_bigtown) then {
				_reinforcements_time = _reinforcements_time * 0.35;
			};
			_current_timer = time;

			waitUntil {
				sleep 0.3;
				(_current_timer + _reinforcements_time < time) || (_targetsector in blufor_sectors) || (_nearestower in blufor_sectors)
			};

			sleep 15;

			if ((_targetsector in active_sectors) && !(_targetsector in blufor_sectors) && !(_nearestower in blufor_sectors) && (!([] call F_isBigtownActive) || _targetsector in sectors_bigtown)) then {
				reinforcements_sector_under_attack = _targetsector;
				reinforcements_set = true;
				["lib_reinforcements", [markertext _targetsector]] remoteExec ["bis_fnc_shownotification", 0];
				if (isNil "sector_reinforcement") then {
					sector_reinforcement = false
				};
				if (sector_reinforcement) then {
					[ markerPos _targetsector ] spawn send_paratroopers;
					[ markerPos _targetsector, true] spawn spawn_battlegroup;
				} else {
					[ markerPos _targetsector ] spawn send_paratroopers
				};
			};
			stats_reinforcements_called = stats_reinforcements_called + 1;
			publicVariable "stats_reinforcements_called";
		};
	};
};
