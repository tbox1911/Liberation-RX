if (!isServer) exitWith {};
private ["_HoF", "_max", "_info"];

while {true} do {
	sleep (10 * 60);
	_info = [] call F_weather_notice;
	[_info] remoteExec ["remote_call_showtext", 0];

	sleep (35 * 60);
	_max = 5;
	if (count GRLIB_player_scores < _max) then {
		_max = count GRLIB_player_scores;
	};

	if (_max > 1 && (GRLIB_side_friendly countSide allPlayers) > 1) then {
		_info = [_max] call F_hof_msg;
		[_info] remoteExec ["remote_call_showtext", 0];
	};
};