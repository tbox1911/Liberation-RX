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
  //_medic removeitem "FirstAidKit";
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
_isMedic = [_medic] call PAR_is_medic;
_hasMedikit = [_medic] call PAR_has_medikit;
if (_isMedic && _hasMedikit) then {
  _wnded setDamage 0;
} else {
  _wnded setDamage 0.25;
};

[
  [_wnded],
{
  if (isDedicated) exitWith {};
  params ["_wnded"];
  {
    if ([localize "STR_PAR_AC_01",(_wnded actionParams _x) select 0] call bis_fnc_inString) then {
      [_wnded, _x] call BIS_fnc_holdActionRemove;
    };
    if ([localize "STR_PAR_AC_02",(_wnded actionParams _x) select 0] call bis_fnc_inString) then {
      _wnded removeAction _x;
    };
    if ([localize "STR_PAR_AC_03",(_wnded actionParams _x) select 0] call bis_fnc_inString) then {
      _wnded removeAction _x;
    };
  } count (actionIDs _wnded);
}] remoteExec ["bis_fnc_call", 0];

if (primaryWeapon _wnded != "") then { _wnded selectWeapon primaryWeapon _wnded };
sleep 0.5;

if (isPlayer _wnded) then {
  player setVariable ["PAR_isUnconscious", 0, true];
  player setVariable ["PAR_isDragged", 0, true];
  group _wnded selectLeader player;
  if (isPlayer _medic && score _medic <= GRLIB_perm_tank) then {
    private _bonus = 5;
    [_medic,_bonus] remoteExec ["addScore", 2];
	
	_medic setVariable ["GREUH_ammo_count", ( (_medic getVariable ["GREUH_ammo_count", 0]) + _bonus ), true];
	
    private _text = format ["You revived %1!\nBonus score %2,\nThank you!", name _wnded, _bonus];
	  [_text] remoteExec ["hintSilent", owner _medic];
  };
} else {
  _wnded switchMove "amovpknlmstpsraswrfldnon"; //go up
  _wnded setSpeedMode (speedMode group player);
};
[_medic, _wnded] call PAR_fn_medicRelease;

if (round (getPosASL _wnded select 2) <= -1) then {_wnded switchmove ""};
if (round (getPosASL _medic select 2) <= -1) then {_medic switchmove ""};

[_wnded] spawn {
    params ["_unit"];
    uIsleep 10;   //time to recover
    _unit setCaptive false;
    _unit setVariable ["PAR_wounded", false];
    _unit allowDamage true;
};
