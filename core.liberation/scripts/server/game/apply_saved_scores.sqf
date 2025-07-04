waitUntil {sleep 1; !isNil "GRLIB_player_scores"};
if (!([] call F_getValid)) exitWith {};

private [ "_nextplayer", "_nextplayer_uid", "_newscores", "_knownplayers", "_playerindex", "_score", "_rank", "_ammo", "_fuel" ];

while {true} do {
	_newscores = GRLIB_player_scores;
	_knownplayers = GRLIB_player_scores apply { _x select 0 };

	{
		_nextplayer = _x;
		_nextplayer_uid = getPlayerUID _nextplayer;

		if (_nextplayer_uid != "") then {
			if (_nextplayer getVariable ["GRLIB_score_set", 0] == 0) then {
				// player saved score/ammo/fuel
				{
					if ( _nextplayer_uid == (_x select 0) ) then {
						_nextplayer setVariable ["GREUH_score_count", (_x select 1), true];
						_nextplayer setVariable ["GREUH_score_last", (_x select 1), true];
						_nextplayer setVariable ["GREUH_ammo_count", (_x select 2), true];
						_nextplayer setVariable ["GREUH_fuel_count", (_x select 3), true];
						_nextplayer setVariable ["GREUH_reput_count", (_x select 4), true];
					};
				} foreach GRLIB_player_scores;

				// new player
				if (isNil {_nextplayer getVariable ["GREUH_score_count", nil]}) then {
					_nextplayer setVariable ["GREUH_score_count", 0, true];
					_nextplayer setVariable ["GREUH_score_last", 0, true];
					_nextplayer setVariable ["GREUH_ammo_count", GREUH_start_ammo, true];
					_nextplayer setVariable ["GREUH_fuel_count", GREUH_start_fuel, true];
					_nextplayer setVariable ["GREUH_reput_count", 0, true];
					GRLIB_permissions pushback [_nextplayer_uid, (GRLIB_permissions select 0 select 1)];
					publicVariable "GRLIB_permissions";
				};

				_score = _nextplayer getVariable ["GREUH_score_count", 0];
				[_score] remoteExec ["set_rank", owner _nextplayer];
				_rank = ([_score] call F_getRank) select 0;
				_nextplayer setVariable ["GRLIB_Rank", _rank, true];
				_nextplayer setVariable ["GRLIB_score_set", 1, true];
			} else {
				_score = _nextplayer getVariable ["GREUH_score_count",0];
				_ammo = _nextplayer getVariable ["GREUH_ammo_count",0];
				_fuel = _nextplayer getVariable ["GREUH_fuel_count",0];
				_reput = _nextplayer getVariable ["GREUH_reput_count",0];

				_playerindex = _knownplayers find _nextplayer_uid;
				if ( _playerindex >= 0 ) then {
					_newscores set [_playerindex, [_nextplayer_uid, _score, _ammo, _fuel, _reput, name _nextplayer]];
				} else {
					_newscores pushback [_nextplayer_uid, _score, _ammo, _fuel, _reput, name _nextplayer];
				};
			};

			_score = _nextplayer getVariable ["GREUH_score_count", 0];
			_nextplayer addScore (_score - score _nextplayer);
			sleep 0.2;
		};
	} foreach (AllPlayers - (entities "HeadlessClient_F"));

	GRLIB_player_scores = _newscores;
	publicVariable "GRLIB_player_scores";
	sleep 4;
};