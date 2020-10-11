params ['_unit'];

if (rating _unit < -2000) exitWith {_unit call PAR_fn_death};
waituntil {sleep 0.5; lifeState _unit == 'incapacitated' && (isTouchingGround _unit || (round (getPos _unit select 2) <= 1))};

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
    if (_caller != player) then {
      _msg = format ["%1 is healing %2 now...", name _caller, name _target];
      [gamelogic, _msg] remoteExec ["globalChat", owner _target];
      //extend PAR_BleedOut
    };
    if (stance _caller == 'PRONE') then {
      _caller playMoveNow 'ainvppnemstpslaywrfldnon_medicother';
    } else {
      _caller playMoveNow 'ainvpknlmstpslaywrfldnon_medicother';
    };
  },
  {
    if ((diag_tickTime > (_this select 3 select 0) + PAR_BleedOut) && ! isPlayer _target && lifeState _target == 'incapacitated') then {
      _target call PAR_fn_death;
    }
  },
  {
    if (local _target) then {
      [_target, _caller] spawn PAR_fn_sortie;
    } else {
      [[_target, _caller], {[(_this select 0),(_this select 1)] spawn PAR_fn_sortie}] remoteExec ["bis_fnc_call", owner _target];
    };
  },
  {
    _caller switchMove "";
  },
  [diag_tickTime],6,12] call BIS_fnc_holdActionAdd;
}] remoteExec ["bis_fnc_call", 0];
sleep 5;

_timer = diag_tickTime;
while {lifeState _unit == 'incapacitated' && diag_tickTime <= _timer + PAR_BleedOut} do {
  if ( count units player > 1 ) then {
    _medic = _unit getVariable ['PAR_myMedic', nil];
    if (isNil "_medic") then {
      _unit groupchat "I need a Medic !!";
      _medic = _unit call PAR_fn_medic;
      if (!isNil "_medic") then {
        [_unit, _medic] call PAR_fn_911;
      };
    };
  };
  sleep 10;
};

[(_unit getVariable ['PAR_myMedic', objNull]), _unit] call PAR_fn_medicRelease;
_unit setCaptive false;

if (lifeState _unit == 'incapacitated' && diag_tickTime > _timer + PAR_BleedOut) then {
  _unit call PAR_fn_death;
};
