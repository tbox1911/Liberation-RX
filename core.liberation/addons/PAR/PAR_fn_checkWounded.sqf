params ["_medic"];

_search_radius = 30;

private _wnded_list = PAR_AI_bros select {
  round (_x distance2D _medic) < _search_radius &&
  vehicle _x == _x &&
  alive _x &&
  damage _x >= 0.1 &&
  behaviour _x != "COMBAT" &&
  lifeState _x != 'INCAPACITATED' &&
  isNil {_x getVariable 'PAR_busy'} &&
  isNil {_x getVariable 'PAR_healed'}
};

if (count (_wnded_list) > 0) then {
	_wnded = _wnded_list select 0;
	if (_medic != _wnded) then {
		_medic groupchat format [localize "STR_PAR_CW_01", name _wnded];
	};
	_medic setVariable ['PAR_heal', true];
	_wnded setVariable ['PAR_healed', true];

	if (!isplayer _wnded && _medic != _wnded) then {
		doStop _wnded;
	};

	while {
		alive _wnded &&
		alive _medic &&
		isNil {_wnded getVariable 'PAR_busy'} &&
		isNil {_medic getVariable 'PAR_busy'} &&
		lifeState _wnded != 'INCAPACITATED' &&
		lifeState _medic != 'INCAPACITATED' &&
		damage _wnded  >= 0.1 &&
		vehicle _medic == _medic &&
		vehicle _wnded == _wnded &&
		(behaviour _medic) != "COMBAT" &&
		(behaviour _wnded) != "COMBAT" &&
		(round (_medic distance2D _wnded) > 3 && round (_medic distance2D _wnded) < _search_radius)
	} do {
		_medic doMove (getPosATL _wnded);
		sleep 5;
	};

	if (lifeState _medic != 'INCAPACITATED' && lifeState _wnded != 'INCAPACITATED' && round (_medic distance2D _wnded) <= 3) then {
		_azimuth = _medic getDir _wnded;
		_medic setDir _azimuth;

		if (stance _medic == 'PRONE') then {
			_medic playMoveNow 'ainvppnemstpslaywrfldnon_medicother';
		} else {
			_medic playMoveNow 'ainvpknlmstpslaywrfldnon_medicother';
		};
		sleep 7;
		if (lifeState _medic != 'INCAPACITATED' && lifeState _wnded != 'INCAPACITATED' && round (_medic distance2D _wnded) <= 3) then {
			_wnded setDamage 0;
		};
		[_medic, _wnded] call PAR_fn_fixPos;
	};

	sleep 2;
	_medic setVariable ['PAR_heal', nil];
	_wnded setVariable ['PAR_healed', nil];
	[_medic, _wnded] doFollow player;
};