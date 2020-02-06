private _distvehclose = 5;

waitUntil {sleep 1; !isNil "build_confirmed" };
waitUntil {sleep 1; !isNil "one_synchro_done" };
waitUntil {sleep 1; one_synchro_done };
waitUntil {sleep 1; !isNil "GRLIB_player_spawned" };

private _dog_bark = true;
private _dog_close = true;

while { true } do {

	// If Dog
	private _my_dog = player getVariable ["my_dog", nil];
	if (!isNil "_my_dog") then {

		// Hide Dog
		// go to ..\addons\FAR_revive\FAR_EventHandler.sqf
		private _onfoot = vehicle player == player;

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
					_my_dog playMoveNow "Dog_Walk"
				};
			};
		} else {
			// Relax
			private _dist = round (_dog_pos distance2D player);
			if (_onfoot && _dist <= 10 && _dog_close) then {
				_my_dog playMove "Dog_Stop";
				_dog_close = false;
			};

			if (_onfoot && _dist > 10) then {
				_my_dog moveTo (getPos player);
				switch (true) do {
					case (_dist <= 20): {_my_dog playMoveNow "Dog_Walk"};
					case (_dist > 20 && _dist <= 40): {_my_dog playMoveNow "Dog_Run"};
					case (_dist > 40): {_my_dog playMoveNow "Dog_Sprint"};
					default {};
				};
				_dog_close = true;
				sleep 5;
			};
		};
	};
	sleep 5;
};
