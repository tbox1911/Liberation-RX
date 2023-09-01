if (!isServer) exitWith {};
private ["_HoF", "_max", "_info"];

while {true} do {
	sleep (25 * 60);
	_max = 5;
	if (count GRLIB_player_scores < _max) then {
		_max = count GRLIB_player_scores;
	};

	if (_max > 1 && (GRLIB_side_friendly countSide allPlayers) > 1) then {
		_info = [_max] call F_hof_msg;
		_info remoteExec ["BIS_fnc_dynamicText", 0];
	};
};