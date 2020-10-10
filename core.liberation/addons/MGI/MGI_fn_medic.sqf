params ["_wnded"];

private _bros = (units player) select {(_x getVariable ["MGI_Grp_ID","0"]) == (_wnded getVariable ["MGI_Grp_ID","1"])};
private _medics = _bros select {
  round (_x distance2D _wnded) <= 300 &&
  (!(objectParent _x iskindof "Steerable_Parachute_F")) &&
  !isPlayer _x &&
  _x != _wnded &&
  alive _x &&  speed (vehicle _x) <= 20 &&
  lifeState _x != "incapacitated" &&
  isNil {_x getVariable "MGI_busy"}
};

if (count _medics == 0) exitWith {
  _wnded setVariable ["MGI_myMedic", nil];
  _msg = format ["Sorry %1, but there is no medic nearby...", name _wnded];
  [_wnded, _msg] call MGI_fn_globalchat;

  _lst = _bros select {!isPlayer _x && alive _x && lifeState _x != "incapacitated"};
  _msg = format ["Units alive in your squad : %1", count (_lst)];
  [_wnded, _msg] call MGI_fn_globalchat;
};

_medics = _medics apply {[_x distance2D _wnded, _x]};
_medics sort true;

private _medic = _medics select 0 select 1;
_msg = format ["Hold on %1 !, Brother %2 (dist: %3m), come to save you !", name _wnded, name _medic, round (_medics select 0 select 0)];
[_wnded, _msg] call MGI_fn_globalchat;

_medic setVariable ["MGI_busy", true];
_wnded setVariable ["MGI_myMedic", _medic];

if (count units _medic > 1) then {
  _medic setVariable ["MGI_AIgrp", group _medic];
  _medic setVariable ["isLeader", leader _medic == _medic];
};
_medic