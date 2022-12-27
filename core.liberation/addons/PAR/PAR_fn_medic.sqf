params ["_wnded"];

if (_wnded == player && player getVariable ["SOG_player_in_tunnel", false]) exitWith {};
private _medic = [_wnded] call PAR_fn_nearestMedic;

if (isNil "_medic") exitWith {
  _wnded setVariable ["PAR_myMedic", nil];
  _msg = format [localize "STR_PAR_MD_01", name _wnded];
  [_wnded, _msg] call PAR_fn_globalchat;

  if (GRLIB_revive in [1,2]) then {
    _msg = localize "STR_PAR_MD_04";
    [_wnded, _msg] call PAR_fn_globalchat;
  };

  _lst = allunits select {!isPlayer _x && alive _x && (_x getVariable ["PAR_Grp_ID","0"]) == (_wnded getVariable ["PAR_Grp_ID","1"]) && lifeState _x != "INCAPACITATED"};
  _msg = format [localize "STR_PAR_MD_02", count (_lst)];
  [_wnded, _msg] call PAR_fn_globalchat;
};

private _msg = format [localize "STR_PAR_MD_03", name _wnded, name _medic, round (_medic distance2D _wnded)];
[_wnded, _msg] call PAR_fn_globalchat;

_medic setVariable ["PAR_busy", true];
_wnded setVariable ["PAR_myMedic", _medic];

if (count (units _medic) > 1) then {
  _medic setVariable ["PAR_AIgrp", group _medic];
  _medic setVariable ["isLeader", (leader _medic == _medic)];
};
_medic