private ["_timer", "_last_pos", "_last_time"];
sleep 300;

while { hasInterface } do {
    _last_pos = getPosATL player;
	_last_time = round time;

    while { (getPosATL player) isEqualTo _last_pos } do {
        _timer = (round time - _last_time);

		if (_timer % 300 == 0) then {
			systemchat format [localize "STR_KICK_IDLE_MSG", (_timer/60), (GRLIB_kick_idle - _timer)/60];
		};

		if (_timer >= GRLIB_kick_idle) then {
			private _msg = "You are idle for too long, good bye!";
			titleText [_msg, "BLACK FADED", 100];
			uisleep 10;
			endMission "LOSER";
		};
        sleep 60;
    };
	sleep 5;
};
