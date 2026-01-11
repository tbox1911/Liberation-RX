params ["", "", "", "_cmd", ["_classname",""]];

if (_cmd == "add" && _classname != "") exitWith {
	private _pos = getPosATL player;
	private _my_dog = createAgent [_classname, _pos, [], 5, "CAN_COLLIDE"];
	_my_dog setVariable ["BIS_fnc_animalBehaviour_disable", true];
	_my_dog allowDamage false;
	player setVariable ["my_dog", _my_dog, true];
	private _dog_snd = selectRandom ["dog1.wss", "dog2.wss", "dog3.wss"];
	private _tone = [_dog_snd, random [0.7, 1, 1.5]];
	_my_dog setVariable ["my_dog_tone", _tone];
	_my_dog setDir (_my_dog getDir player);
	[_my_dog, _tone] spawn dog_bark;
	[true] call player_dog_actions;
	build_refresh = true;
};

private _my_dog = player getVariable ["my_dog", nil];
if (!isNil "_my_dog") then {

	if (_cmd == "del") then {
		private _msg = format [localize "STR_DISMISS_DOG"];
		_result = [_msg, localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
		if (_result) then {
			_my_dog setDir (_my_dog getDir player);
			[_my_dog, ["dog4.wss", 1]] spawn dog_bark;
			sleep 4;
			[_my_dog] call do_dog_cleanup;
		};
	};

	if (_cmd == "find") then {
		private _all_men = (getPos player) nearEntities ["CAManBase", 300];
		private _enemy_lst = _all_men select {
			(side group _x == GRLIB_side_enemy || (_x getVariable ["GRLIB_is_prisoner", false]) || (_x getVariable ["GRLIB_A3W_Mission_HC2", false]))
		};
		private _msg = localize "STR_DOG_FOUND_NOTHING";
		if (count _enemy_lst > 0) then {
			private _enemy_sorted = _enemy_lst apply {[_x distance2D player, _x]};
			_enemy_sorted sort true;
			private _target = _enemy_sorted select 0;
			_msg = format [localize "STR_DOG_FOUND", round (_target select 0)];
			_my_dog setVariable ["do_find", (_target select 1)];
			_my_dog stop false;
		};
		gamelogic globalChat _msg;
	};

	if (_cmd == "find_gun") then {
		_my_dog_pos = getPosATL _my_dog;
		_weapons_lst = nearestObjects [_my_dog_pos, ["GroundWeaponHolder", "WeaponHolderSimulated"], 200];
		_weapons_lst = _weapons_lst select {
			_wp = ((getWeaponCargo _x) select 0);
			if (count _wp > 0) then {
				_wp_info = (_wp select 0) call BIS_fnc_weaponComponents;
				_wp_weapon = format ["Weapon_%1", (_wp_info select 0)];
				([_wp_weapon, ["Weapon_Base_F", "Launcher_Base_F"]] call F_itemIsInClass);
			} else { false };
		};
		private _msg = localize "STR_DOG_FOUND_NOTHING";
		if (count _weapons_lst > 0) then {
			_weapons_lst = _weapons_lst apply {[_x distance2D _my_dog_pos, _x]};
			_weapons_lst sort true;
			_dist = (_weapons_lst select 0) select 0;
			_man = (_weapons_lst select 0) select 1;
			_msg = format [localize "STR_DOG_FOUND", round (_dist)];
			_my_dog setVariable ["do_find", _man];
			_my_dog stop false;
		};
		gamelogic globalChat _msg;
	};

	if (_cmd == "patrol") then {
		private _dog_pos = getPosATL player;
		private _radius = 80;
		private _patrolcorners = [
			[ (_dog_pos select 0) - _radius, (_dog_pos select 1) - _radius, 0 ],
			[ (_dog_pos select 0) + _radius, (_dog_pos select 1) - _radius, 0 ],
			[ (_dog_pos select 0) + _radius, (_dog_pos select 1) + _radius, 0 ],
			[ (_dog_pos select 0) - _radius, (_dog_pos select 1) + _radius, 0 ]
		];
		_my_dog setVariable ["do_find_wp", _patrolcorners];
		_my_dog setVariable ["do_find", (_patrolcorners select 0)];
		_my_dog stop false;
	};

	if (_cmd == "recall") then {
		[_my_dog, false] remoteExec ["hideObjectGlobal", 2];
		_my_dog setVariable ["do_find", nil];
		_my_dog setVariable ["do_find_wp", nil];
		_my_dog stop false;
	};

	if (_cmd == "pet") then {
		player playMove 'AinvPknlMstpSlayWrflDnon_medicOther';
		_my_dog = player getVariable ["my_dog", nil];
		_my_dog stop true;
		_my_dog setDir (_my_dog getDir player);
		_my_dog playMoveNow "Dog_Idle_01";
		sleep 3;
		_my_dog playMoveNow "Dog_Idle_10";
		sleep 3;
		_my_dog stop false;
		_tone = _my_dog getVariable "my_dog_tone";
		[_my_dog, _tone] spawn dog_bark;
	};

	if (_cmd == "stop") then {
		_my_dog setVariable ["do_find", nil];
		_my_dog setVariable ["do_find_wp", nil];
		_my_dog stop true;
		_my_dog playMove "Dog_Stop";
	};

};
