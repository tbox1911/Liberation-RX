private _distvehclose = 5;

waitUntil {sleep 1; !isNil "build_confirmed" };
waitUntil {sleep 1; !isNil "one_synchro_done" };
waitUntil {sleep 1; one_synchro_done };
waitUntil {sleep 1; !isNil "GRLIB_player_spawned" };

while { true } do {

	// If Dog
	private _my_dog = player getVariable ["my_dog", nil];
	if (!isNil "_my_dog") then {

		// Hide Dog
		// go to ..\addons\PAR\PAR_EventHandler.sqf
		private _onfoot = isNull objectParent player;

		// Reset Dog
		private _dog_pos = getPos _my_dog;
		if ( _onfoot && _dog_pos distance2D player > 300 ) then {
			_my_dog setPos (getPos player);
			_my_dog setVariable ["do_find", nil];
			sleep 1;
		};

		// Mission for Dog
		_man = _my_dog getVariable ["do_find", nil];
		if (!isNil "_man") then {
			// Find !
			_is_captured = !(_man getVariable ["GRLIB_is_prisonner", true]);
			if (!alive _man || side _man == GRLIB_side_friendly || _is_captured) then {
				_my_dog setVariable ["do_find", nil];
			} else {
				private _dist = round (_dog_pos distance2D _man);
				if (_dist <= 3) then {
					_my_dog setDir (_my_dog getDir _man);
					[player, "bark"] remoteExec ["dog_action_remote_call", 2];
					_my_dog playMoveNow "Dog_Idle_Bark";
					sleep selectRandom [3,4,5];
					_my_dog playMoveNow "Dog_Stop";
				} else {
					_my_dog moveTo (getPos _man);
					_dog_move = "Dog_Walk";
					switch (true) do {
						case (_dist > 20 && _dist <= 40): {_dog_move = "Dog_Run"};
						case (_dist > 40): {_dog_move = "Dog_Sprint"};
					};
					_my_dog playMoveNow _dog_move;
				};
			};
		} else {
			private _dist = round (_dog_pos distance2D player);

			// Stop
			if (stopped _my_dog) then {
				_my_dog setDir (_my_dog getDir player);
				_my_dog playMove "Dog_Sit";
			};

			// Relax
			if (_onfoot && _dist <= 10 && !(stopped _my_dog)) then {
				_my_dog playMove "Dog_Idle_Stop";
			};

			// Return
			if (_onfoot && _dist > 15 && !(stopped _my_dog)) then {
				_my_dog stop false;
				_my_dog moveTo (getPos player);
				_dog_move = "Dog_Walk";
				switch (true) do {
					case (_dist > 20 && _dist <= 40): {_dog_move = "Dog_Run"};
					case (_dist > 40): {_dog_move = "Dog_Sprint"};
				};
				_my_dog playMoveNow _dog_move;
			};
		};
	};
	sleep 5;
};
