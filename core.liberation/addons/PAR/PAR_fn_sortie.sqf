params ["_wnded", "_medic"];

if (isDedicated) exitWith {};
if (!(local _wnded)) exitWith {};
if (lifeState _wnded != "INCAPACITATED") exitWith { [_medic, _wnded] call PAR_fn_medicRelease };

if (!isPlayer _medic) then {
  _msg = format [localize "STR_PAR_ST_01", name _medic, name _wnded];
  [_wnded, _msg] call PAR_fn_globalchat;
  _bleedOut = _wnded getVariable ["PAR_BleedOutTimer", 0];
  _wnded setVariable ["PAR_BleedOutTimer", _bleedOut + PAR_BleedOutExtra, true];
  _medic setDir (_medic getDir _wnded);
  if (stance _medic == "PRONE") then {
    _medic playMoveNow "ainvppnemstpslaywrfldnon_medicother";
  } else {
    _medic playMoveNow "ainvpknlmstpslaywrfldnon_medicother";
  };
  private _grbg = createVehicle [(selectRandom PAR_MedGarbage), getPos _wnded, [], 0, "CAN_COLLIDE"];
  _grbg spawn {sleep (60 + floor(random 30)); deleteVehicle _this};
  sleep 6;
};

if (lifeState _medic == "INCAPACITATED" || (!alive _wnded)) exitWith { [_medic, _wnded] call PAR_fn_medicRelease };

// Revived
_wnded setUnconscious false;
_wnded doFollow player;
if (GRLIB_revive == 2) then { 
  _medic removeItem "FirstAidKit";
};
if ([_medic] call PAR_is_medic) then {
  _wnded setDamage 0;
} else {
  _wnded setDamage 0.25;
};

if (isPlayer _wnded) then {
  player setVariable ["PAR_isUnconscious", 0, true];
  player setVariable ["PAR_isDragged", 0, true];
  group _wnded selectLeader player;
  private _bounty_ok = (([(GRLIB_capture_size * 2), getPosATL _medic] call F_getNearestSector) in (sectors_allSectors - blufor_sectors) && _medic getVariable ["PAR_lastRevive",0] < time);
  if (isPlayer _medic && _bounty_ok) then {
    private _bonus = 5;
    [_medic, _bonus] remoteExec ["F_addScore", 2];
    _medic setVariable ["PAR_lastRevive", round(time + 5*60), true];
    private _text = format [localize "STR_PAR_ST_02", name _wnded, _bonus];
    [[_medic, _text], {
      if (player == (_this select 0)) then { hintSilent (_this select 1) };
    }] remoteExec ["bis_fnc_call", -2];
  };
} else {
  _wnded switchMove "amovpknlmstpsraswrfldnon"; //go up
  _wnded playMoveNow "amovpknlmstpsraswrfldnon";
  _wnded setSpeedMode (speedMode group player);
};
[_medic, _wnded] call PAR_fn_medicRelease;

if (underwater vehicle _medic) then {_medic switchMove "";_medic playMoveNow ""};
if (underwater vehicle _wnded) then {_wnded switchMove "";_wnded playMoveNow ""};

[_wnded] spawn {
    params ["_unit"];
    uIsleep 10;   //time to recover
    _unit setCaptive false;
    _unit setVariable ["PAR_wounded", false];
    _unit allowDamage true;
};
