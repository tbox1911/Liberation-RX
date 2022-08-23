waitUntil {sleep 1; !isNil "GRLIB_player_scores"};
if (!([] call F_getValid)) exitWith {};

private [ "_nextplayer" , "_newscores", "_knownplayers", "_playerindex", "_ammo", "_fuel" ];

while { true } do {
	
	_knownplayers = [];
	_newscores = [] + GRLIB_player_scores;
	{ _knownplayers pushback (_x select 0) } foreach GRLIB_player_scores;

	{
		_nextplayer = _x;
		if (_nextplayer getVariable ["GRLIB_score_set", 0] == 0) then {
			// player saved score/ammo/fuel
			{
				if ( (getPlayerUID _nextplayer) == (_x select 0) ) then {
					_nextplayer addScore ((_x select 1) - (score _nextplayer));
					_nextplayer setVariable ["GREUH_score_last", score _nextplayer, true];
					_nextplayer setVariable ["GREUH_ammo_count", (_x select 2), true];
					//compat fix
					if ( typeName (_x select 3) == "STRING") then {
						_nextplayer setVariable ["GREUH_fuel_count", GREUH_start_fuel, true];
					} else {
						_nextplayer setVariable ["GREUH_fuel_count", (_x select 3), true];
					};
				};
			} foreach GRLIB_player_scores;

			// new player
			if (isNil {_nextplayer getVariable ["GREUH_score_last", nil]}) then {
				_nextplayer setVariable ["GREUH_score_last", 0, true];
				_nextplayer setVariable ["GREUH_ammo_count", GREUH_start_ammo, true];
				_nextplayer setVariable ["GREUH_fuel_count", GREUH_start_fuel, true];
				GRLIB_player_scores pushback [getPlayerUID _nextplayer, 0, GREUH_start_ammo, GREUH_start_fuel, name _nextplayer];
			};

			// set player rank
			_rank = [score _nextplayer] call get_rank;
			_nextplayer setVariable ["GRLIB_Rank", _rank, true];
			[] remoteExec ["set_rank", owner _nextplayer];
			
			_nextplayer setVariable ["GRLIB_score_set", 1, true];
		};

		sleep 0.2;
		if (_nextplayer getVariable "GRLIB_score_set" == 1) then {
			_ammo = round (_nextplayer getVariable ["GREUH_ammo_count",0]);
			_fuel = round (_nextplayer getVariable ["GREUH_fuel_count",0]);
			_playerindex = _knownplayers find (getPlayerUID _nextplayer);
			if ( _playerindex >= 0 ) then {
				_newscores set [_playerindex, [getPlayerUID _nextplayer, score _nextplayer, _ammo, _fuel, name _nextplayer]];
			} else {
				_newscores pushback [getPlayerUID _nextplayer, score _nextplayer, _ammo, _fuel, name _nextplayer];
			};
		};
	} foreach (AllPlayers - (entities "HeadlessClient_F"));
	GRLIB_player_scores = _newscores;
	publicVariable "GRLIB_player_scores";
	sleep 5;
};