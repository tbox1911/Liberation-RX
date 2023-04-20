params ["_medic"];

_search_radius = 30;

private _bros = allUnits select {(_x getVariable ["MGI_Grp_ID","0"]) == (_medic getVariable ["MGI_Grp_ID","1"])};
private _wounded_list = _bros select {
  round (_x distance2D _medic) < _search_radius &&
  vehicle _x == _x &&
  alive _x &&
  damage _x >= 0.1 &&
  behaviour _x != "COMBAT" &&
  lifeState _x != 'incapacitated' &&
  isNil {_x getVariable 'MGI_busy'} &&
  isNil {_x getVariable 'MGI_healed'}
};

if (count (_wounded_list) > 0) then {
	_wounded = _wounded_list select 0;
	if (_medic != _wounded) then {
		_medic groupchat format ["I'm going to heal %1 !", name _wounded];
	};
	_medic setVariable ['MGI_heal', true];
	_wounded setVariable ['MGI_healed', true];

	if (!isplayer _wounded && _medic != _wounded) then {
		doStop _wounded;
	};

	while {
		alive _wounded &&
		alive _medic &&
		isNil {_wounded getVariable 'MGI_busy'} &&
		isNil {_medic getVariable 'MGI_busy'} &&
		lifeState _wounded != 'incapacitated' &&
		lifeState _medic != 'incapacitated' &&
		damage _wounded  >= 0.1 &&
		vehicle _medic == _medic &&
		vehicle _wounded == _wounded &&
		(behaviour _medic) != "COMBAT" &&
		(behaviour _wounded) != "COMBAT" &&
		(round (_medic distance2D _wounded) > 3 && round (_medic distance2D _wounded) < _search_radius)
	} do {
		_medic doMove (getPosATL _wounded);
		sleep 4;
		//waitUntil {sleep 0.5; round (speed (vehicle _medic)) == 0};
	};

	if (lifeState _medic != 'incapacitated' && lifeState _wounded != 'incapacitated' && round (_medic distance2D _wounded) <= 3) then {
		_azimuth = _medic getDir _wounded;
		_medic setDir _azimuth;

		if (stance _medic == 'PRONE') then {
			_medic playMoveNow 'ainvppnemstpslaywrfldnon_medicother';
		} else {
			_medic playMoveNow 'ainvpknlmstpslaywrfldnon_medicother';
		};
		sleep 7;
		if (lifeState _medic != 'incapacitated' && lifeState _wounded != 'incapacitated' && round (_medic distance2D _wounded) <= 3) then {
			_wounded setDamage 0;
		};
	};

	sleep 2;
	_medic setVariable ['MGI_heal', nil];
	_medic doFollow leader player;
	_wounded setVariable ['MGI_healed', nil];
	_wounded doFollow leader player;
};