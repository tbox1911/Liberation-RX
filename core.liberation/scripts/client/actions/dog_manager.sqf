private _distvehclose = 5;

waitUntil {sleep 1; !isNil "build_confirmed" };
waitUntil {sleep 1; !isNil "one_synchro_done" };
waitUntil {sleep 1; one_synchro_done };
waitUntil {sleep 1; !isNil "GRLIB_player_spawned" };

private _dog_bark = true;
private _dog_close = true;

while { true } do {

	// Dog
	private _my_dog = player getVariable ["my_dog", nil];

	if (!isNil "_my_dog") then {
		private _onfoot = vehicle player == player;
		if (_onfoot) then {
			_my_dog hideObjectGlobal false;
		} else {
			_my_dog hideObjectGlobal true;
		};

		private _dog_pos = getPos _my_dog;
		if ( _onfoot && _dog_pos distance2D player > 300 ) then {
			_my_dog setPos (getPos player);
			_my_dog setVariable ["do_find", nil];
			sleep 1;
		};

		_man = _my_dog getVariable ["do_find", nil];
		if (!isNil "_man") then {
			// Find !
			if (!alive _man || { _man getVariable ["GRLIB_is_prisonner", false]} ) then {
				_my_dog setVariable ["do_find", nil];
			};

			private _dist = round (_dog_pos distance2D _man);
			if (_dist <= 3) then {
				_my_dog setDir (getDir _man);
				playSound3D ["a3\sounds_f\ambient\animals\dog1.wss", _my_dog, false, _dog_pos , 6, 0.8, 0];
				_my_dog playMoveNow "Dog_Idle_Bark";
				sleep 3;
				_my_dog playMove "Dog_Stop";
			} else {
				_my_dog moveTo (getPos _man);
				_my_dog playMoveNow "Dog_Walk"
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
