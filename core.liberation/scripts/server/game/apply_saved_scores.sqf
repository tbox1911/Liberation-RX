private [ "_nextplayer" ];
waitUntil { !isNil "GRLIB_player_scores"};
waitUntil { !isNil "save_is_loaded" };

while { true } do {
	{
		_nextplayer = _x;
		if (isNil {_nextplayer getVariable ["GRLIB_score_set", nil]}) then {
			{
				if ( (getPlayerUID _nextplayer) == (_x select 0) ) then {
					_nextplayer addScore ((_x select 1) - (score _nextplayer));
					_nextplayer setVariable ["score_last",score _nextplayer, true];
					_nextplayer setVariable ["GREUH_ammo_count", (_x select 2), true];
				};
			} foreach GRLIB_player_scores;
			_nextplayer setVariable ["GRLIB_score_set", 1, true];
			};
	} foreach allPlayers;
	sleep 10;
};