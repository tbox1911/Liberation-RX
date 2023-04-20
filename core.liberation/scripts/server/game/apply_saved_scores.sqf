private [ "_nextplayer" ];
waitUntil { !isNil "GRLIB_player_scores"};
if (!([] call F_getValid)) exitWith {};

while { true } do {
	private [ "_newscores", "_knownplayers", "_playerindex" ];
	_knownplayers = [];
	_newscores = [] + GRLIB_player_scores;
	{ _knownplayers pushback (_x select 0) } foreach GRLIB_player_scores;

	{
		_nextplayer = _x;
		if (_nextplayer getVariable "GRLIB_score_set" == 0) then {
			// player saved score/ammo
			{
				if ( (getPlayerUID _nextplayer) == (_x select 0) ) then {
					[_nextplayer, ((_x select 1) - ([_nextplayer] call F_getScore))] call F_addScore;
					_nextplayer setVariable ["GREUH_score_last",[_nextplayer] call F_getScore, true];
					_nextplayer setVariable ["GREUH_ammo_count", (_x select 2), true];
				};
			} foreach GRLIB_player_scores;

			// new player
			if (isNil {_nextplayer getVariable ["GREUH_score_last", nil]}) then {
				_nextplayer setVariable ["GREUH_score_last", 0, true];
				_nextplayer setVariable ["GREUH_ammo_count", GREUH_start_ammo, true];
				GRLIB_player_scores pushback [getPlayerUID _nextplayer, 0, GREUH_start_ammo, name _nextplayer];
			};
			_nextplayer setVariable ["GRLIB_score_set", 1, true];
		};

		if (_nextplayer getVariable "GRLIB_score_set" == 1) then {
			_ammo = _nextplayer getVariable ["GREUH_ammo_count",0];
			_playerindex = _knownplayers find (getPlayerUID _nextplayer);
			if ( _playerindex >= 0 ) then {
				_newscores set [_playerindex, [getPlayerUID _nextplayer, [_nextplayer] call F_getScore, _ammo, name _nextplayer]];
			} else {
				_newscores pushback [getPlayerUID _nextplayer, [_nextplayer] call F_getScore, _ammo, name _nextplayer];
			};
		};
	} foreach allPlayers;
	GRLIB_player_scores = _newscores;
	sleep 10;
};