private _cmd = (_this select 3);
private _my_dog = player getVariable ["my_dog", nil];

if (!isNil "_my_dog") then {

	if (_cmd == "del") then {
		_msg = format ["<t align='center'>Dismiss the Dog<br/>Are you sure ?</t>"];
		_result = [_msg, "Warning !", true, true] call BIS_fnc_guiMessage;
		if (_result) then {
			_my_dog setDir (_my_dog getDir player);
			playSound3D ["a3\sounds_f\ambient\animals\dog2.wss", _my_dog, false, getPosASL _my_dog, 2, 0.8, 0];
			_my_dog playMoveNow "Dog_Idle_Bark";
			sleep 3;
			deleteVehicle _my_dog;
			player setVariable ["my_dog", nil, true];
		};
	};

	if (_cmd == "find") then {
		_enemy_lst = (getPos player) nearEntities ["Man", 300];
		_enemy_lst = _enemy_lst select {alive _x && (side _x == GRLIB_side_enemy || {_x getVariable ["GRLIB_is_prisonner", false]})};

		_msg = "The dog found nothing...";
		if (count _enemy_lst > 0) then {
			_enemy_lst = _enemy_lst apply {[_x distance2D player, _x]};
			_enemy_lst sort true;
			_dist = (_enemy_lst select 0) select 0;
			_man = (_enemy_lst select 0) select 1;
			_msg = format ["The dog found something %1m away !!", round (_dist)];
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