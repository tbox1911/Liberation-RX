waitUntil { sleep 10; !isNil "GRLIB_all_fobs" };
waitUntil { sleep 10; !isNil "blufor_sectors" };
waitUntil { sleep 10; !isNil "active_sectors" };

GRLIB_last_active_sectors = -1;

// active_sectors watcher
[] spawn {
    while {true} do {
        if (count active_sectors == 0) then {
            if (GRLIB_last_active_sectors < 0) then {
                GRLIB_last_active_sectors = time;
            };
        } else {
            GRLIB_last_active_sectors = -1;
        };
		sleep 5;
    };
};

sleep GRLIB_battlegroup_timer;

private ["_players_hi", "_players_lo", "_attack"];
while { GRLIB_endgame == 0 && GRLIB_global_stop == 0 } do {
	waitUntil {
		sleep 5;
		(
			diag_fps >= 30.0 && !opforcap_max &&
			count GRLIB_all_fobs >= 1 &&
			count blufor_sectors >= 5 &&
			combat_readiness >= 50 &&
			time >= (GRLIB_last_battlegroup + GRLIB_battlegroup_timer) &&
			time >= (GRLIB_last_active_sectors + GRLIB_battlegroup_timer)
		)
	};

	_attack = false;
	_players_hi = (AllPlayers - (entities "HeadlessClient_F")) select { ([_x] call F_getScore >= GRLIB_perm_tank) };
	if (count _players_hi >= 2 && combat_readiness >= 55) then {
		_attack = true;
	};

	_players_lo = (AllPlayers - (entities "HeadlessClient_F")) select { ([_x] call F_getScore >= GRLIB_perm_log) };
	if (count _players_lo >= 3 && combat_readiness >= 70) then {
		_attack = true;
	};
	if (count _players_lo >= 1 && combat_readiness >= 80) then {
		_attack = true;
	};

	if (_attack) then {
		if (count _players_hi >= 1 && combat_readiness >= 70) then {
			_target = selectRandom _players_hi;
			if (_target getVariable ["GRLIB_BN_timer", 0] < time) then {
				_target setVariable ["GRLIB_BN_timer", round (time + (20 * 60))];
				if (floor random 4 == 0) exitWith {};
				diag_log format ["Spawn Attack on player %1 at %2", name _target, time];
				_target setVariable ["GRLIB_BN_timer", round (time + (40 * 60))];
				_msg = format ["<img size='1' image='%2'/> - <img size='1' image='%2'/> - <img size='1' image='%2'/><br/><t color='#0000FF'>%1</t> is now the <t color='#808080'>'Bete Noire'</t> of the <t color='#F00000'>OPFor</t>!<br/><br/>You better take cover...<br/><img size='1' image='%2'/> - <img size='1' image='%2'/> - <img size='1' image='%2'/>", name _target, getMissionPath "res\skull.paa"];
				[_msg, 0, 0, 10, 0, 0, 90] remoteExec ["BIS_fnc_dynamicText", 0];
				waitUntil {sleep 2; isNull objectParent _target};
				[getPosATL _target, GRLIB_side_enemy, 3] spawn spawn_air;
				sleep 10;
				[getPosATL _target] spawn send_paratroopers;
				_attack = false;
			};
		};

		if (_attack) then {
			diag_log format ["Spawn Random BattleGroup at %1", time];
			private _pilots = _players_hi select { (objectParent _x) isKindOf "Air" && (driver vehicle _x) == _x };
			if (count _pilots > 0 && floor random 2 == 0) then {
				[getPosATL (selectRandom _pilots), GRLIB_side_enemy, 3] spawn spawn_air;
			};
			sleep 10;
			[] spawn spawn_battlegroup;
			stats_hostile_battlegroups = stats_hostile_battlegroups + 1;
			publicVariable "stats_hostile_battlegroups";
		};
	};

	sleep 60;
};
