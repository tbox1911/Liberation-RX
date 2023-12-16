params ["_medic", "_wnded"];

_wnded setVariable ['PAR_healed', true];
if (_wnded == _medic) exitWith {
	_wnded playMoveNow 'ainvpknlmstpslaywrfldnon_medicother';
	sleep 7;
	if (lifeState _wnded != 'INCAPACITATED') then {
		_wnded setDamage 0;
	};
	sleep 2;
	_wnded setVariable ['PAR_healed', nil];
};

_medic groupchat format [localize "STR_PAR_CW_01", name _wnded];
_medic setVariable ['PAR_heal', true];

while {
	(currentCommand _medic != "STOP") &&
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
	if (!isPlayer _wnded) then { _wnded stop true};

	if (currentCommand _medic != "STOP") then {
		[_medic] doFollow (leader group player);
		if ((_wnded distance2D _medic) < 25) then {
			_medic doMove (getPosATL _wnded);
		} else {
			_medic doMove (getPos _wnded);
		};
		sleep 5;
		if (speed vehicle _medic < 1 && (_medic distance2D _wnded) > 5 && (currentCommand _medic != "STOP")) then {
			_medic setPosATL (getPosATL _medic vectorAdd [([] call F_getRND), ([] call F_getRND), 0.5]);
			_medic switchMove "AmovPercMwlkSrasWrflDf";
			_medic playMoveNow "AmovPercMwlkSrasWrflDf";
			sleep 3;
		};
	};
	sleep 1;	
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
	[[_medic, _wnded]] call PAR_fn_fixPos;
};

sleep 2;
_wnded stop false;
_medic setVariable ['PAR_heal', nil];
_wnded setVariable ['PAR_healed', nil];
[_medic, _wnded] doFollow (leader group player);
