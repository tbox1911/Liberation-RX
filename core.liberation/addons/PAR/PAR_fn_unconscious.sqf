params ["_unit"];

if (rating _unit < -2000) exitWith {_unit setDamage 1};
if (!([] call F_getValid)) exitWith {_unit setDamage 1};

_unit setUnconscious true;
waituntil {sleep 0.5; lifeState _unit == "INCAPACITATED" && (isTouchingGround (vehicle _unit) || (round (getPos _unit select 2) <= 1))};

if (isPlayer _unit) then {
  [] call PAR_show_marker;
  if ( [_unit] call F_getScore > GRLIB_perm_log + 5) then { [_unit, -1] remoteExec ["F_addScore", 2] };
} else {
  [_unit] call F_deathSound;
};

if (!isNil {_unit getVariable "PAR_busy"} || !isNil {_unit getVariable "PAR_heal"}) then {
  _unit setVariable ["PAR_busy", nil];
  _unit setVariable ["PAR_heal", nil];
};

_unit setVariable ["PAR_healed", nil];
[(_unit getVariable ["PAR_myMedic", objNull]), _unit] call PAR_fn_medicRelease;
_unit setCaptive true;

if (GRLIB_disable_death_chat && isPlayer _unit) then {
  for "_channel" from 0 to 4 do {
    _channel enableChannel false;
  };
};

_unit switchMove "";
_unit switchMove "AinjPpneMstpSnonWrflDnon";  // lay down
_unit playMoveNow "AinjPpneMstpSnonWrflDnon";
sleep 7;
_unit setVariable ["PAR_isUnconscious", true, true];

private _bld = createVehicle [(selectRandom PAR_BloodSplat), getPos _unit, [], 0, "CAN_COLLIDE"];
private _cnt = 0;
private ["_medic", "_msg"];
while {lifeState _unit == "INCAPACITATED" && time <= _unit getVariable ["PAR_BleedOutTimer", 0]} do {
  if (_cnt == 0) then {
    _unit setOxygenRemaining 1;
    private _bros = [_unit] call PAR_medic_units;
    if ( count _bros > 0 ) then {
      _medic = _unit getVariable ["PAR_myMedic", nil];
      if (isNil "_medic") then {
        _unit groupchat localize "STR_PAR_UC_01";
        _medic = [_unit] call PAR_fn_medic;
        if (!isNil "_medic") then { [_unit, _medic] call PAR_fn_911 };
      };
    } else {
        _msg = format [localize "STR_PAR_UC_03", name player];
        if (lifeState player == "INCAPACITATED") then {
          _msg = format [localize "STR_PAR_UC_02", name player];
        };
        _last_msg = player getVariable ["PAR_last_message", 0];
        if (time > _last_msg) then {
          [_unit, _msg] call PAR_fn_globalchat;
          player setVariable ["PAR_last_message", round(time + 20)];
        };
    };
    //systemchat str ((_unit getVariable ["PAR_BleedOutTimer", 0]) - time);
    _cnt = 10;
  };
  _cnt = _cnt - 1;
  sleep 1;
};
_bld spawn {sleep (30 + floor(random 30)); deleteVehicle _this};

[(_unit getVariable ["PAR_myMedic", objNull]), _unit] call PAR_fn_medicRelease;
_unit setCaptive false;

if (isPlayer _unit) then {
  if (primaryWeapon _unit != "") then { _unit selectWeapon primaryWeapon _unit };
  [] call PAR_del_marker;
  for "_channel" from 0 to 4 do {
    _channel enableChannel true;
  };
};

if (lifeState _unit == "INCAPACITATED" && time > _unit getVariable ["PAR_BleedOutTimer", 0]) then {
  _unit setDamage 1;
};
