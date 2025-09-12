waitUntil {sleep 1; GRLIB_player_spawned};
waitUntil {sleep 1; !isNil "GRLIB_player_near_fob"};
sleep 60;

private _timer = 0;
private _checkCiv = {
	params ["_unit"];
	(
		!GRLIB_player_near_fob &&
		handgunWeapon _unit == "" &&
		primaryWeapon _unit == "" &&
		secondaryWeapon _unit == "" &&
		(vest _unit) == "" &&
		((uniform _unit) == "" || (uniform _unit) select [0,4] == "U_C_") &&
		((backpack _unit) == "" || (backpack _unit) select [0,5] == "B_Civ") &&
		(isNull objectParent _unit || typeOf (objectParent _unit) in civilian_vehicles)
	)
};

while {true} do {
	waitUntil {sleep 1; alive player && !(captive player)};

	// Renegade
	private _side = side player;
	if (_side == sideEnemy || rating player <= -2000) then {
		player addrating ((abs rating player) + 500);
		private _kill = 1 + (BTC_logic getVariable [PAR_Grp_ID, 0]);
		BTC_logic setVariable [PAR_Grp_ID, _kill, true];
		if (_kill == GRLIB_tk_count) then { [player] call LRX_tk_actions };
		GRLIB_player_group selectLeader player;
		gamelogic globalChat format [localize "STR_LOG_LRX_WRONG_SIDE", name player, _side];
	};

	// Leadership
	if (count units GRLIB_player_group > 1 && leader GRLIB_player_group != player && local GRLIB_player_group) then {
		player addrating 3000;
		GRLIB_player_group selectLeader player;
		gamelogic globalChat format [localize "STR_LOG_LRX_LEADERSHIP_TAKEN", name player];
	};

	// Civilian
	if (_side == GRLIB_side_friendly && count units GRLIB_player_group == 1 && ([player] call _checkCiv)) then {
		if (_timer < time) then {
			if (([player, GRLIB_capture_size, GRLIB_side_enemy] call F_getUnitsCount) == 0) then {
				[GRLIB_player_group, "del"] remoteExec ["addel_group_remote_call", 2];
				sleep 2;
				GRLIB_player_group = createGroup [GRLIB_side_civilian, true];
				waitUntil {
					[player] joinSilent GRLIB_player_group;
					sleep 0.5;
					(player in (units GRLIB_player_group));
				};
				private _msg = format ["<t color='#0000FF'>%1</t> you are a <t color='#660080'>Civilian</t> now...", name player];
				[_msg, 0, 0, 10, 0, 0, 90] spawn BIS_fnc_dynamicText;
				gamelogic globalChat format ["%1 goes to Civilian side...", name player];
			};
		};
	} else {
		_timer = time + 60;
	};

	if (_side == GRLIB_side_civilian && !([player] call _checkCiv)) then {
		GRLIB_player_group = createGroup [GRLIB_side_friendly, true];
		waitUntil {
			[player] joinSilent GRLIB_player_group;
			sleep 0.5;
			(player in (units GRLIB_player_group));
		};
		[GRLIB_player_group, "add"] remoteExec ["addel_group_remote_call", 2];
		private _msg = format ["<t color='#0000FF'>%1</t> you are back to the <t color='#004C99'>BLUFOR</t> side...", name player];
		[_msg, 0, 0, 10, 0, 0, 90] spawn BIS_fnc_dynamicText;
		gamelogic globalChat format ["%1 goes to Blufor side...", name player];
		_timer = time + 300;
	};

	sleep 3;
};
