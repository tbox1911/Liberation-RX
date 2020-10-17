params ['_unit'];

if (rating _unit < -2000) exitWith {_unit call PAR_fn_death};
waituntil {sleep (0.5 + random 2); lifeState _unit == 'incapacitated' && (isTouchingGround _unit || (round (getPos _unit select 2) <= 1))};

if (!isNil {_unit getVariable 'PAR_busy'} || !isNil {_unit getVariable 'PAR_heal'}) then {
  _unit setVariable ['PAR_busy', nil];
  _unit setVariable ['PAR_heal', nil];
  _unit switchMove "";
};

_unit setVariable ['PAR_healed', nil];
[(_unit getVariable ['PAR_myMedic', objNull]), _unit] call PAR_fn_medicRelease;
_unit setCaptive true;
_unit switchMove "AinjPpneMstpSnonWrflDnon";  // lay down

[
  [_unit],
{
  [
  (_this select 0),
  "<t color='#00C900'>Revive</t>",
  "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",
   "round(_this distance2D _target) < 3 &&
    lifeState _target == 'incapacitated' &&
    _target getVariable ['FAR_isDragged',0] == 0 &&
    ((FAR_AidKit in (items _this)) || ([_this] call FAR_is_medic && [_this] call FAR_has_medikit))",
  "round(_caller distance2D _target) < 3",
  {
    if (_caller == player) then {
      _msg = format ["%1 is healing %2 now...", name _caller, name _target];
      [_target, _msg] remoteExec ["PAR_fn_globalchat", [0,-2] select isDedicated,true];
      _target setVariable ['PAR_extratime', 20, true];
    };
    if (stance _caller == 'PRONE') then {
      _caller playMoveNow 'ainvppnemstpslaywrfldnon_medicother';
    } else {
      _caller playMoveNow 'ainvpknlmstpslaywrfldnon_medicother';
    };
  },
  {
    _extra_time = _target getVariable ['PAR_extratime', 0];
    if ((time > (_this select 3 select 0) + PAR_BleedOut + _extra_time) && lifeState _target == 'incapacitated') then {
      _target call PAR_fn_death;
    };
  },
  {
    if (local _target) then {
      [_target, _caller] call PAR_fn_sortie;
    } else {
      [[_target, _caller], {[(_this select 0),(_this select 1)] call PAR_fn_sortie}] remoteExec ["bis_fnc_call", [0,-2] select isDedicated,true];
    };
  },
  {
    _caller switchMove "";
  },
  [time],6,12] call BIS_fnc_holdActionAdd;
}] remoteExec ["bis_fnc_call", [0,-2] select isDedicated,true];
sleep 6;

_bleedOut = time + PAR_BleedOut;
_extra_time = 0;
while {lifeState _unit == 'incapacitated' && time <= _bleedOut + _extra_time} do {
  if ( count units player > 1 ) then {
    _medic = _unit getVariable ['PAR_myMedic', nil];
    if (isNil "_medic") then {
      _unit groupchat "I need a Medic !!";
      _medic = _unit call PAR_fn_medic;
      if (!isNil "_medic") then { [_unit, _medic] call PAR_fn_911 };
    };
    _extra_time = _unit getVariable ['PAR_extratime', 0];
  };
  sleep 10;
};

[(_unit getVariable ['PAR_myMedic', objNull]), _unit] call PAR_fn_medicRelease;
_unit setCaptive false;

if (lifeState _unit == 'incapacitated' && time > _bleedOut + _extra_time) then {
  _unit call PAR_fn_death;
};
