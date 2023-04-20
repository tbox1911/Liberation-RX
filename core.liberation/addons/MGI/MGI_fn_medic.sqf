_wnded = _this;
private '_medic';
_wnded setVariable ['MGI_myMedic', nil];

private _medics = MGI_bros select {
  round (_x distance2D _wnded) < 250 &&
  (!(objectParent _x iskindof "Steerable_Parachute_F")) &&
  !isPlayer _x &&
  _x != _wnded &&
  alive _x &&  speed (vehicle _x) <= 20 &&
  lifeState _x != 'incapacitated' &&
  isNil {_x getVariable 'MGI_busy'}
};

if (count _medics == 0) exitWith {
  _medic = objNull;
  if (isNull _wnded) exitWith {_medic};
  _wnded setVariable ['MGI_myMedic', nil];
  if (lifeState _wnded == 'incapacitated') exitWith {
    _lst = MGI_bros select {!isPlayer _x && alive _x && lifeState _x != 'incapacitated'};
    gamelogic globalChat format ["Sorry %1, but there is no medic nearby...", name _wnded];
    gamelogic globalChat format ["Units alive in your squad : %1", count (_lst)];
    if (_wnded == player && count (_lst) >= 1) then {
      {
        if (isNil {_x getVariable 'MGI_busy'}) then {_x doMove (getPos player)};
      } forEach _lst;
    };
    _medic;
  };
  _medic;
};
_medics = _medics apply {[_x distance2D _wnded, _x]};
_medics sort true;
_medic = _medics select 0 select 1;
_msg = format ["Hold on %1 !, Brother %2 (dist: %3m), come to save you !", name _wnded, name _medic, round (_medics select 0 select 0)];
gamelogic globalChat _msg;

_medic setVariable ['MGI_busy', true];
_wnded setVariable ['MGI_myMedic', _medic];

if (count units _medic > 1) then {
  _medic setVariable ['MGI_AIgrp', group _medic];
  _medic setVariable ['isLeader', leader _medic == _medic];
};
_medic