waitUntil {sleep 1; GRLIB_player_spawned};
waitUntil {sleep 1; !isNil "GRLIB_player_near_lhd"};

private _timer = time + 60;

while {true} do {
	waitUntil {sleep 1; !(captive player)};

	// Renegade
	private _side = side player;
	if (_side == sideEnemy) then {
		player addrating ((abs rating player) + 500);
		private _kill = 1 + (BTC_logic getVariable [PAR_Grp_ID, 0]);
		BTC_logic setVariable [PAR_Grp_ID, _kill, true];
		if (_kill == GRLIB_tk_count) then { [player] call LRX_tk_actions };
		GRLIB_player_group selectLeader player;
		gamelogic globalChat format [localize "STR_LOG_LRX_WRONG_SIDE", name player, _side];
	};

	// Leadership
	if (count units GRLIB_player_group > 1 && leader GRLIB_player_group != player && local GRLIB_player_group) then {
		player addrating ((abs rating player) + 500);
		GRLIB_player_group selectLeader player;
		gamelogic globalChat format [localize "STR_LOG_LRX_LEADERSHIP_TAKEN", name player];
	};

	// Civilian Undercover
	private _no_enemy = (([player, GRLIB_sector_size, GRLIB_side_enemy] call F_getUnitsCount) == 0);
	if (_no_enemy) then {
		{
			if !(isNil {_x getVariable "GRLIB_unit_detected"}) then { _x setVariable ["GRLIB_unit_detected", nil, true] };
		} forEach (units GRLIB_player_group);
	};
	private _undetected = ({ [_x] call F_detectedUnit } count (units GRLIB_player_group) == 0);
	if (_side == GRLIB_side_friendly && _undetected && _no_enemy) then {
		private _can_change = ({ [_x] call F_checkCivUnit } count (units GRLIB_player_group) == count units GRLIB_player_group);
		if (_timer < time && _can_change) then {
			private _msg = format [localize "STR_CHANGE_CIV"];
			private _result = [_msg, localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
			if !(_result) exitWith { _timer = time + 600 };

			private _player_units = (units GRLIB_player_group);
			[GRLIB_player_group, "del"] remoteExec ["addel_group_remote_call", 2];
			sleep 2;
			GRLIB_player_group = createGroup [GRLIB_side_civilian, true];
			waitUntil {
				[player] joinSilent GRLIB_player_group;
				sleep 0.5;
				(player in (units GRLIB_player_group));
			};
			_player_units joinSilent GRLIB_player_group;
			private _msg = format ["<t color='#0000FF'>%1</t> you are a <t color='#660080'>Civilian</t> now...", name player];
			[_msg, 0, 0, 10, 0, 0, 90] spawn BIS_fnc_dynamicText;
			gamelogic globalChat format ["%1 and his squad goes to the Civilian side...", name player];
		};
	} else {
		_timer = time + 60;
	};

	if (_side == GRLIB_side_civilian && !_undetected) then {
		private _player_units = (units GRLIB_player_group);
		GRLIB_player_group = createGroup [GRLIB_side_friendly, true];
		waitUntil {
			[player] joinSilent GRLIB_player_group;
			sleep 0.5;
			(player in (units GRLIB_player_group));
		};
		[GRLIB_player_group, "add"] remoteExec ["addel_group_remote_call", 2];
		_player_units joinSilent GRLIB_player_group;
		private _msg = format ["<t color='#0000FF'>%1</t> you are back to the <t color='#004C99'>BLUFOR</t> side...", name player];
		[_msg, 0, 0, 10, 0, 0, 90] spawn BIS_fnc_dynamicText;
		gamelogic globalChat format ["%1 and his squad go back to the Blufor side...", name player];
		_timer = time + 600;
	};

	sleep 3;
};
