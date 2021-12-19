params ["_unit"];

if (rating _unit < -2000) exitWith {_unit spawn PAR_fn_death};
if (!([] call F_getValid)) exitWith {_unit spawn PAR_fn_death};
waituntil {sleep (0.5 + random 2); lifeState _unit == "INCAPACITATED" && (isTouchingGround _unit || (round (getPos _unit select 2) <= 1))};

if (isPlayer _unit) then {
  [] call PAR_show_marker;
  private _score = score _unit;
  private _penalty = 0;
  if ( _score > GRLIB_perm_inf ) then { _penalty = 1 };
  if ( _score > GRLIB_perm_air ) then { _penalty = 2 };
  if ( _score > GRLIB_perm_max ) then { _penalty = 3 };
  if ( _penalty > 0 ) then { [_unit, -_penalty] remoteExec ["addScore", 2] };
};

if (!isNil {_unit getVariable "PAR_busy"} || !isNil {_unit getVariable "PAR_heal"}) then {
  _unit setVariable ["PAR_busy", nil];
  _unit setVariable ["PAR_heal", nil];
  _unit switchMove "";
};

_unit setVariable ["PAR_healed", nil];
[(_unit getVariable ["PAR_myMedic", objNull]), _unit] call PAR_fn_medicRelease;
_unit setCaptive true;

if (GRLIB_disable_death_chat && isPlayer _unit) then {
  0 enableChannel false;
  1 enableChannel false;
};
_unit switchMove "AinjPpneMstpSnonWrflDnon";  // lay down
sleep 8;

[
  [_unit],
{
  if (isDedicated) exitWith {};
  params ["_wnded"];
  [
  _wnded,
  "<t color='#00C900'>" + localize "STR_PAR_AC_01" + "</t>",
  "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",
   "round(_this distance2D _target) < 3 &&
    lifeState _target == 'INCAPACITATED' &&
    _target getVariable ['PAR_isDragged',0] == 0 &&
    ( [_this] call PAR_has_medikit || [_this] call PAR_is_medic )",
  "round(_caller distance2D _target) < 3",
  {
    if (_caller == player) then {
      _msg = format [localize "STR_PAR_ST_01", name _caller, name _target];
      [_target, _msg] remoteExec ["PAR_fn_globalchat", 0];
      _bleedOut = _target getVariable ["PAR_BleedOutTimer", 0];
      _target setVariable ["PAR_BleedOutTimer", _bleedOut + PAR_BleedOutExtra, true];
    };
    _grbg = createVehicle [(selectRandom PAR_MedGarbage), getPos _target, [], 0, "CAN_COLLIDE"];
    _grbg spawn {sleep (60 + floor(random 30)); deleteVehicle _this};
    if (stance _caller == 'PRONE') then {
      _caller playMoveNow 'ainvppnemstpslaywrfldnon_medicother';
    } else {
      _caller playMoveNow 'ainvpknlmstpslaywrfldnon_medicother';
    };
  },
  {},
  {
    if (local _target) then {
      [_target, _caller] call PAR_fn_sortie;
    } else {
      [[_target, _caller], {
        if (isDedicated) exitWith {};
        if (!isNil "GRLIB_player_spawned") then {
           if (GRLIB_player_spawned) then {
            [(_this select 0),(_this select 1)] call PAR_fn_sortie;
           };
         };
        }] remoteExec ["bis_fnc_call", 0];
    };
  },
  {
    _caller switchMove "";
  },
  [time],6,12] call BIS_fnc_holdActionAdd;
  _wnded addAction ["<t color='#C90000'>" + localize "STR_PAR_AC_02" + "</t>", "addons\PAR\PAR_fn_drag.sqf", ["action_drag"], 9, false, true, "", "!PAR_isDragging", 3];
  _wnded addAction ["<t color='#C90000'>" + localize "STR_PAR_AC_03" + "</t>", { PAR_isDragging = false }, ["action_release"], 10, true, true, "", "PAR_isDragging"];
}] remoteExec ["bis_fnc_call", 0];

private _bld = createVehicle [(selectRandom PAR_BloodSplat), getPos _unit, [], 0, "CAN_COLLIDE"];
private _cnt = 0;
while {lifeState _unit == "INCAPACITATED" && time <= _unit getVariable ["PAR_BleedOutTimer", 0]} do {
  if (_cnt == 0) then {
    _unit setOxygenRemaining 1;
    private _bros = allunits select {(_x getVariable ["PAR_Grp_ID","0"]) == (_unit getVariable ["PAR_Grp_ID","1"]) && alive _x && lifeState _x != "INCAPACITATED"};
    if ( count _bros > 0 ) then {
      _medic = _unit getVariable ["PAR_myMedic", nil];
      if (isNil "_medic") then {
        _unit groupchat localize "STR_PAR_UC_01";
        _medic = _unit call PAR_fn_medic;
        if (!isNil "_medic") then { [_unit, _medic] call PAR_fn_911 };
      };
    } else {
        if (isPlayer _unit) then {
          _msg = format [localize "STR_PAR_UC_02", name _unit];
          [_unit, _msg] call PAR_fn_globalchat;
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
  [] call PAR_del_marker;
  if (GRLIB_disable_death_chat) then {
    0 enableChannel true;
    1 enableChannel true;
  };
};

if (lifeState _unit == "INCAPACITATED" && time > _unit getVariable ["PAR_BleedOutTimer", 0]) then {
  _unit spawn PAR_fn_death;
};
