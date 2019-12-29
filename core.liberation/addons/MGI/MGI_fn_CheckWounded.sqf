params ["_medic"];

Search_radius = 30;

private _wounded_list = MGI_bros select {
  round (_x distance2D _medic) < Search_radius &&
  round (getPosATL _x select 2) < 1 &&
  vehicle _x == _x &&
  alive _x &&
  damage _x >= 0.1 &&
  behaviour _x != "COMBAT" &&
  !(_x getVariable ["MGI_isUnconscious",false]) &&
  lifeState _x != 'incapacitated' &&
  isNil {_x getVariable 'MGI_busy'} &&
  isNil {_x getVariable 'MGI_healed'} &&
  _x getVariable [format["Bros_%1",MGI_Grp_ID], nil]
};

release_lock = {
	params ["_medic", "_wounded"];
	_medic setVariable ['MGI_heal', nil];
	_wounded setVariable ['MGI_healed', nil];
	_wounded doFollow leader player;
	_medic doFollow leader player;
};

if (count (_wounded_list) > 0) then {
	_x = _wounded_list select 0;
	if (_medic != _x) then {
		_medic groupchat format ["I'm going to heal %1 !", name _x];
	};
	_medic setVariable ['MGI_heal', true];
	_x setVariable ['MGI_healed', true];

	while {
		alive _x &&
		alive _medic &&
		isNil {_x getVariable 'MGI_busy'} &&
		isNil {_medic getVariable 'MGI_busy'} &&
		lifeState _x != 'incapacitated' &&
		lifeState _medic != 'incapacitated' &&
		damage _x  >= 0.1 &&
		vehicle _medic == _medic &&
		vehicle _x == _x &&
		(behaviour _medic) != "COMBAT" &&
		(behaviour _x) != "COMBAT" &&
		(round (_medic distance2D _x) > 3 && round (_medic distance2D _x) < Search_radius)
	} do {
		if (!isplayer _x) then {
			doStop _x;
		};
		_medic doMove (getPosATL _x);
		sleep 4;
		//waitUntil {sleep 0.5; round (speed (vehicle _medic)) == 0};
	};

	if (lifeState _medic != 'incapacitated' && lifeState _x != 'incapacitated' && round (_medic distance2D _x) <= 3) then {
		_azimuth = _medic getDir _x;
		_medic setDir _azimuth;

		if (stance _medic == 'PRONE') then {
			_medic playMove 'ainvppnemstpslaywrfldnon_medicother';
		} else {
			_medic playMove 'ainvpknlmstpslaywrfldnon_medicother';
		};
		sleep 7;
		if (lifeState _medic != 'incapacitated' && lifeState _x != 'incapacitated' && round (_medic distance2D _x) <= 3) then {
			_x setDamage 0;
		};
	};

	sleep 2;
	[_medic, _x] call release_lock;
};