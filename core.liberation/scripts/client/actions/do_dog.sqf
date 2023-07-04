private _cmd = (_this select 3);
private _my_dog = player getVariable ["my_dog", nil];

if (!isNil "_my_dog") then {

	if (_cmd == "del") then {
		_msg = format [localize "STR_DISMISS_DOG"];
		_result = [_msg, localize "STR_WARNING", true, true] call BIS_fnc_guiMessage;
		if (_result) then {
			player setVariable ["my_dog", nil, true];
			_my_dog setDir (_my_dog getDir player);
			playSound3D ["a3\sounds_f\ambient\animals\dog2.wss", _my_dog, false, getPosASL _my_dog, 2, 0.8, 0];
			_my_dog playMoveNow "Dog_Idle_Bark";
			sleep 3;
			deleteVehicle _my_dog;
		};
	};

	if (_cmd == "find") then {
		_enemy_lst = (getPos player) nearEntities ["Man", 300];
		_enemy_lst = _enemy_lst select {alive _x && (side _x == GRLIB_side_enemy || {_x getVariable ["GRLIB_is_prisonner", false]})};

		_msg = localize "STR_DOG_FOUND_NOTHING";
		if (count _enemy_lst > 0) then {
			_enemy_lst = _enemy_lst apply {[_x distance2D player, _x]};
			_enemy_lst sort true;
			_dist = (_enemy_lst select 0) select 0;
			_man = (_enemy_lst select 0) select 1;
			_msg = format [localize "STR_DOG_FOUND", round (_dist)];
			_my_dog setVariable ["do_find", _man];
			_my_dog stop false;
		};
		gamelogic globalChat _msg;
	};

	if (_cmd == "find_gun") then {
		_weapons_lst = nearestObjects [player, ["GroundWeaponHolder"], 300];
		_weapons_lst = _weapons_lst + nearestObjects [player, ["WeaponHolderSimulated"], 300];
		_weapons_lst = _weapons_lst select {
			_wp = ((getWeaponCargo _x) select 0);
			if (count _wp > 0) then {
				_wp_info = (_wp select 0) call BIS_fnc_weaponComponents;
				(format ["Weapon_%1", (_wp_info select 0)] isKindOf "Weapon_Base_F")
			} else { false };
		};
		_msg = localize "STR_DOG_FOUND_NOTHING";
		if (count _weapons_lst > 0) then {
			_weapons_lst = _weapons_lst apply {[_x distance2D player, _x]};
			_weapons_lst sort true;
			_dist = (_weapons_lst select 0) select 0;
			_man = (_weapons_lst select 0) select 1;
			_msg = format [localize "STR_DOG_FOUND", round (_dist)];
			_my_dog setVariable ["do_find", _man];
			_my_dog stop false;
		};
		gamelogic globalChat _msg;
	};

	if (_cmd == "recall") then {
		_my_dog setVariable ["do_find", nil];
		_my_dog stop false;
	};

	if (_cmd == "stop") then {
		_my_dog setVariable ["do_find", nil];
		_my_dog stop true;
		_my_dog playMove "Dog_Stop";
	};

};
