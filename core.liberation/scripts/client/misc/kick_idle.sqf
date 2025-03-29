private ["_timer", "_time_left", "_last_pos"];
private _sleep = 60;

while { hasInterface } do {
	waitUntil {sleep 1; GRLIB_player_spawned};
    _last_pos = getPosATL player;
	_timer = 1;
    while { (player distance2D _last_pos) < 2 && lifeState player != "INCAPACITATED" } do {
		_time_left = round ((GRLIB_kick_idle - (_timer*_sleep))/60);
		if (_timer % 5 == 0) then {
			systemchat format [localize "STR_KICK_IDLE_MSG", round ((_timer*_sleep)/60), _time_left];
		};
		if (_time_left <= 0) then {
			disableUserInput true;
			private _msg = localize "STR_MSG_IDLE_TIMEOUT";
			titleText [_msg, "BLACK FADED", 100];
			uisleep 10;
			disableUserInput false;
			disableUserInput true;
			disableUserInput false;
			endMission "LOSER";
			("#kick " + name player) remoteExec ["serverCommand", 2];
		};
		_timer = _timer + 1;
        sleep _sleep;
    };
	sleep 60;
};
