params ["_wnded", "_medic"];
//diag_log format ["DBG_fn_sortie WNDED:%1 MEDIC:%2", name _wnded, name _medic];

if (lifeState _wnded != "incapacitated") exitWith { [_medic, _wnded] call MGI_fn_medicRelease };

if (!isPlayer _medic) then {
  _msg = format ["%1 is healing %2 now...", name _medic, name _wnded];
  [_wnded, _msg] call MGI_fn_globalchat;
  _medic setDir (_medic getDir _wnded);
  //_medic removeitem "FirstAidKit";
  if (stance _medic == "PRONE") then {
    _medic playMoveNow "ainvppnemstpslaywrfldnon_medicother";
  } else {
    _medic playMoveNow "ainvpknlmstpslaywrfldnon_medicother";
  };
  sleep 6;
};

if (lifeState _medic == "incapacitated") exitWith { [_medic, _wnded] call MGI_fn_medicRelease };

// Revived
_wnded setUnconscious false;
_wnded doFollow player;
_isMedic = [_medic] call FAR_is_medic;
_hasMedikit = [_medic] call FAR_has_medikit;
if (_isMedic && _hasMedikit) then {
  _wnded setDamage 0;
} else {
  _wnded setDamage 0.25;
};
_wnded selectWeapon primaryWeapon _wnded;
sleep 0.5;

if (isPlayer _wnded) then {
  player setVariable ["FAR_isUnconscious", 0, true];
  player setVariable ["FAR_isDragged", 0, true];
  group _wnded selectLeader player;
  if (isPlayer _medic) then {
    [_medic, 5] remoteExec ["addScore", 2];
  };
} else {
  {
    if (["Revive",(_wnded actionParams _x) select 0] call bis_fnc_inString) then {
      [ _wnded,_x] call BIS_fnc_holdActionRemove;
    };
  } count (actionIDs _wnded);
  _wnded switchMove "amovpknlmstpsraswrfldnon"; //go up
  _wnded setSpeedMode (speedMode group player);
};
[_medic, _wnded] call MGI_fn_medicRelease;

if (round (getPosASL _wnded select 2) <= -1) then {_wnded switchmove ""};
if (round (getPosASL _medic select 2) <= -1) then {_medic switchmove ""};

[_wnded] spawn {
    params ["_unit"];
    uIsleep 10;   //time to recover
    _unit setCaptive false;
    _unit setVariable ["MGI_isUnconscious", false];
    _unit allowDamage true;
};
