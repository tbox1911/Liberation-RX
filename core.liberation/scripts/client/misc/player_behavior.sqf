waitUntil {sleep 1; GRLIB_player_spawned};
waitUntil {sleep 1; !isNil "GRLIB_player_near_lhd"};

private _detectedUnit = {
    params ["_unit"];
	(_unit getVariable ["GRLIB_unit_detected", 0] >= 1.5) &&
    !([_unit] call F_checkCivUnit);
};

private _detectedVehicle = {
	params ["_vehicle"];
	private _ret = false;
	if (isNull _vehicle) exitWith { _ret };
	{
		if ((_x select 1) in ["commander","gunner"]) exitWith { _ret = true };
	} forEach (fullCrew [_vehicle, "", true]);
	_ret;
};

private _timer = time + 60;
private _timer_bonus = 120;

while {true} do {
	waitUntil {sleep 1; alive player && !(captive player)};

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

	if (GRLIB_Undercover_mode == 1) then {
		// Civilian Undercover
		if (!GRLIB_player_near_lhd) then {
			// go CIV
			private _no_enemy = (([player, GRLIB_capture_size, GRLIB_side_enemy] call F_getUnitsCount) == 0);
			if (_side == GRLIB_side_friendly && _no_enemy) then {
				private _can_change = ({ [_x] call F_checkCivUnit && !([objectParent _x] call _detectedVehicle)} count (units GRLIB_player_group) == count units GRLIB_player_group);
				if (_timer < time && _can_change) then {
					closeDialog 0;
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
					_timer = time + 600;
					_timer_bonus = 120;
				};
			} else {
				_timer = time + 60;
			};
		};

		// go BLU
		if (_side == GRLIB_side_civilian) then {
			private _undetected = ({ [_x] call _detectedUnit || [objectParent _x] call _detectedVehicle } count (units GRLIB_player_group) == 0);
			if (_undetected) then {
				private _awareness = player getVariable ["GRLIB_unit_detected", 0];
				private _level = linearConversion [0, 1.5, _awareness, 0, 100, true];
				private _msg = format ["%1 detection level: %2%%", name player, round _level];
				hintSilent _msg;
				_timer_bonus = _timer_bonus - 3;
				if (_timer_bonus <= 0) then {
					[_winner, 1] call F_addReput;
					_timer_bonus = 60;
				};
			} else {
				private _msg = format ["<t color='#0000FF'>%1</t> you are back to the <t color='#004C99'>BLUFOR</t> side...", name player];
				[_msg, 0, 0, 10, 0, 0, 90] spawn BIS_fnc_dynamicText;
				private _player_units = (units GRLIB_player_group);
				GRLIB_player_group = createGroup [GRLIB_side_friendly, true];
				waitUntil {
					[player] joinSilent GRLIB_player_group;
					sleep 0.5;
					(player in (units GRLIB_player_group));
				};
				[GRLIB_player_group, "add"] remoteExec ["addel_group_remote_call", 2];
				_player_units joinSilent GRLIB_player_group;
				{ _x setVariable ["GRLIB_unit_detected", 0, true] } forEach (units GRLIB_player_group);
				gamelogic globalChat format ["%1 and his squad go back to the Blufor side...", name player];
				hintSilent "";
				_timer = time + 600;
			};
		};
	};

	sleep 3;
};
