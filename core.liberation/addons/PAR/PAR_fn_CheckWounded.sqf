params ["_medic"];

_search_radius = 30;

private _bros = (units player) select {(_x getVariable ["PAR_Grp_ID","0"]) == (_medic getVariable ["PAR_Grp_ID","1"])};
private _wounded_list = _bros select {
  round (_x distance2D _medic) < _search_radius &&
  vehicle _x == _x &&
  alive _x &&
  damage _x >= 0.1 &&
  behaviour _x != "COMBAT" &&
  lifeState _x != 'INCAPACITATED' &&
  isNil {_x getVariable 'PAR_busy'} &&
  isNil {_x getVariable 'PAR_healed'}
};

if (count (_wounded_list) > 0) then {
	_wounded = _wounded_list select 0;
	if (_medic != _wounded) then {
		_medic groupchat format [localize "STR_PAR_CW_01", name _wounded];
	};
	_medic setVariable ['PAR_heal', true];
	_wounded setVariable ['PAR_healed', true];

	if (!isplayer _wounded && _medic != _wounded) then {
		doStop _wounded;
	};

	while {
		alive _wounded &&
		alive _medic &&
		isNil {_wounded getVariable 'PAR_busy'} &&
		isNil {_medic getVariable 'PAR_busy'} &&
		lifeState _wounded != 'INCAPACITATED' &&
		lifeState _medic != 'INCAPACITATED' &&
		damage _wounded  >= 0.1 &&
		vehicle _medic == _medic &&
		vehicle _wounded == _wounded &&
		(behaviour _medic) != "COMBAT" &&
		(behaviour _wounded) != "COMBAT" &&
		(round (_medic distance2D _wounded) > 3 && round (_medic distance2D _wounded) < _search_radius)
	} do {
		_medic doMove (getPosATL _wounded);
		sleep 4;
	};

	if (lifeState _medic != 'INCAPACITATED' && lifeState _wounded != 'INCAPACITATED' && round (_medic distance2D _wounded) <= 3) then {
		_azimuth = _medic getDir _wounded;
		_medic setDir _azimuth;

		if (stance _medic == 'PRONE') then {
			_medic playMoveNow 'ainvppnemstpslaywrfldnon_medicother';
		} else {
			_medic playMoveNow 'ainvpknlmstpslaywrfldnon_medicother';
		};
		sleep 7;
		if (lifeState _medic != 'INCAPACITATED' && lifeState _wounded != 'INCAPACITATED' && round (_medic distance2D _wounded) <= 3) then {
			_wounded setDamage 0;
		};
	};

	sleep 2;
	_medic setVariable ['PAR_heal', nil];
	_medic doFollow leader player;
	_wounded setVariable ['PAR_healed', nil];
	_wounded doFollow leader player;
};