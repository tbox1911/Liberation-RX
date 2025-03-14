params ["_wnded", "_medic"];
private _cnt = 3;
private _fail = 0;
private _dist = 0;
private _msg = "";
private _new_medic = objNull;

private _check_sortie = {
	params ["_wnded", "_medic"];
	if (isNil {_wnded getVariable "PAR_myMedic"}) exitWith { false };
	private _ret = false;
	if (_wnded distance2D _medic <= 6) then {
		if (surfaceIsWater (getPos _wnded)) then {
			_medic setPosASL (getPosASL _wnded);
		} else {
			if ((getPosATL _wnded) select 2 > 5) then {
				_medic doMove (getPosATL _wnded);
				sleep 3;
			};
			waitUntil {sleep 0.5; round (speed vehicle _medic) == 0};
		};
		_ret = true;
	};
	_ret;
};

private _healed = false;
while { ([_wnded] call PAR_is_wounded) && _fail <= 6 } do {
	_msg = "";
	_dist = round (_wnded distance2D _medic);
	// systemchat format ["dbg: wnded 2D dist : %1 dist speed %2 fail %3", _wnded distance2D _medic, round (speed vehicle _medic), _fail];
	if (_dist > 500 || vehicle _medic != _medic || vehicle _wnded != _wnded) exitWith {};
	_new_medic = [_wnded] call PAR_fn_nearestMedic;
	if (!isNil "_new_medic" && _dist > 20) then {
		if ((_new_medic distance2D _wnded) + 6 < (_medic distance2D _wnded)) then { _wnded setVariable ["PAR_myMedic", nil] };
	};
	if (isNil {_wnded getVariable "PAR_myMedic"}) exitWith {};

	if ([_wnded, _medic] call _check_sortie) exitWith { _healed = true };

	if (round (speed vehicle _medic) == 0) then {
		_fail = _fail + 1;
		_medic setDir (_medic getDir _wnded);
		_medic switchMove "AmovPercMwlkSrasWrflDf";
		_medic playMoveNow "AmovPercMwlkSrasWrflDf";

		if (_fail < 3) then {
			if (_dist < 25) then {
				_medic doMove (getPosATL _wnded);
			} else {
				_medic doMove (getPos _wnded);
			};
		};

		if (_fail in [3, 4, 5]) then {
			_medic setDir (_medic getDir _wnded);
			_relpos = _medic getRelPos [_dist/2, 0];
			_medic doMove _relpos;
		};

		if (_fail > 5) then {
			_medic allowDamage false;
			_newpos = _medic getPos [3, _medic getDir _wnded];
			_newpos = _newpos vectorAdd [0, 0, 3];
			_medic setPos _newpos;
			sleep 1;
			_medic allowDamage true;
		};

		_msg = format [localize "STR_PAR_CM_01", name _wnded, name _medic, _dist, _fail];
		sleep 3;
	} else {
		_fail = 0;
	};

	if ([_wnded, _medic] call _check_sortie) exitWith { _healed = true };

	if (_cnt == 0 && !isNull _wnded) then {
		if (_fail == 0) then {
			_msg = format [localize "STR_PAR_CM_02", name _wnded, name _medic, _dist, round (speed vehicle _medic)];
		};
		[_wnded, _msg] call PAR_fn_globalchat;
		_cnt = 3;
	} else {
		_cnt = _cnt - 1;
	};

	sleep 3;
};

if (_healed) then {
	[_wnded, _medic] call PAR_fn_sortie;
} else {
	[_medic, _wnded] call PAR_fn_medicRelease;
};
