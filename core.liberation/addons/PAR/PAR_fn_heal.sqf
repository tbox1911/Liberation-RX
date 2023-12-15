params ["_medic", "_wnded"];

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
	((_medic distance2D _wnded) > 3 && (_medic distance2D _wnded) < 30)
} do {
	[_medic] doFollow (leader group player);
	if ((_wnded distance2D _medic) < 25) then {
		_medic doMove (getPosATL _wnded);
	} else {
		_medic doMove (getPos _wnded);
		sleep 7;
		if (speed _medic < 1) then {
			[[_medic]] spawn PAR_unblock_AI;
			sleep 3;
		};
	};
	sleep 3;
};

if (lifeState _medic != 'INCAPACITATED' && lifeState _wnded != 'INCAPACITATED' && (_medic distance2D _wnded) <= 3) then {
	_medic setDir (_medic getDir _wnded);
	if (stance _medic == 'PRONE') then {
		_medic playMoveNow 'ainvppnemstpslaywrfldnon_medicother';
	} else {
		_medic playMoveNow 'ainvpknlmstpslaywrfldnon_medicother';
	};
	sleep 7;
	if (lifeState _medic != 'INCAPACITATED' && lifeState _wnded != 'INCAPACITATED' && (_medic distance2D _wnded) <= 3) then {
		_wnded setDamage 0;
	};
	[_medic, _wnded] call PAR_fn_fixPos;
};

sleep 2;
_medic setVariable ['PAR_heal', nil];
_wnded setVariable ['PAR_healed', nil];
[_medic, _wnded] doFollow (leader group player);
