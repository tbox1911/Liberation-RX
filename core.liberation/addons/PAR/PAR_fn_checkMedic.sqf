params ["_wnded","_medic"];
private _cnt = 3;
private _fail = 0;
private _old = 999;

_check_sortie = {
  params ["_wnded","_medic"];
  private _ret = false;
  //systemchat format ["dbg: wnded 2D dist : %1 sqr dist %2   speed %3", _wnded distance2D _medic, _wnded distanceSqr _medic, round (speed (vehicle _medic)) ];

  if ( !alive _medic || !alive _wnded ||
       isNil {_wnded getVariable ["PAR_myMedic", nil]} ||
       vehicle _medic != _medic || vehicle _wnded != _wnded
    ) then {
      _fail = 99;
      //_ret = true;
  };

  if (_wnded distance2D _medic <= 6 && _fail != 99) then {
    if ((getPosATL _wnded) select 2 > 5) then {
      _medic doMove (getPosATL _wnded);
      sleep 3;
    };
    waitUntil {sleep 0.5; round (speed (vehicle _medic)) == 0};
    _ret = true;
  };
  _ret;
};

_release_medic = {
  params ["_wnded","_medic"];
  [_medic,_wnded] call PAR_fn_medicRelease;
};

while {lifeState _wnded == "INCAPACITATED" || lifeState _medic != "INCAPACITATED" || isNil {_wnded getVariable ["PAR_myMedic", nil]} } do {

  if (lifeState _medic == "INCAPACITATED" || _fail > 6 || isNil {_wnded getVariable ["PAR_myMedic", nil]}) exitWith {
      [_wnded,_medic] call _release_medic;
  };

  if ([_wnded, _medic] call _check_sortie) exitWith {[_wnded,_medic] call PAR_fn_sortie};
  if (_fail == 99) exitWith {[_wnded,_medic] call _release_medic};

  _msg = "";
  _dist = round (_wnded distance2D _medic);
  if (_dist > 600) exitWith {[_wnded,_medic] call _release_medic};
  if (_dist >= _old && round (speed (vehicle _medic)) == 0) then {
    _fail = _fail + 1;
    doStop _medic;
    _medic setDir (_medic getDir _wnded);
    sleep 0.5;
    unassignVehicle _medic;
    if (!isnull objectParent _medic) then {
      doGetOut _medic;
      sleep 3;
    };

    if ([_wnded,_medic] call _check_sortie) exitWith {[_wnded,_medic] call PAR_fn_sortie};
    if (_fail == 99) exitWith {[_wnded,_medic] call _release_medic};

    if (_fail < 3) then {
      if (_wnded distance2D _medic < 25) then {
        _medic doMove (getPosATL _wnded);
      } else {
        _medic doMove (getPos _wnded);
      };
    };

    if (_fail > 4) then {
      _medic allowDamage false;
      _newpos = _medic getPos [3, _medic getDir _wnded];
      _newpos = _newpos vectorAdd [0, 0, 3];
      _medic setPos _newpos;
      sleep 1;
      _medic allowDamage true;
      if ([_wnded,_medic] call _check_sortie) exitWith {[_wnded,_medic] call PAR_fn_sortie};
      if (_fail == 99) exitWith {[_wnded,_medic] call _release_medic};

      _dist = round (_wnded distance2D _medic);
    };

    if (_fail == 3) then {
      _medic setDir (_medic getDir _wnded);
      _relpos = _medic getRelPos [_dist/2, 0];
      _medic doMove _relpos;
    };

    _msg = format [localize "STR_PAR_CM_01", name _wnded, name _medic, _dist, _fail];
  } else {
    _fail = 0;
  };
  _old = _dist;

  if (_cnt == 0 && !isNull _wnded) then {
    if (_fail == 0) then {
      _msg = format [localize "STR_PAR_CM_02", name _wnded, name _medic, _dist, round (speed _medic)];
    };
    [_wnded, _msg] call PAR_fn_globalchat;
    _cnt = 3;
  } else {
    _cnt = _cnt - 1;
  };
  sleep 3;
};

 [_medic, _wnded] call PAR_fn_medicRelease;