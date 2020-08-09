params ['_unit'];

if (rating _unit < -2000) exitWith {_unit call MGI_fn_death};
waituntil {sleep 0.5; lifeState _unit == 'incapacitated' && (isTouchingGround _unit || (round (getPos _unit select 2) <= 1))};

if (!isNil {_unit getVariable 'MGI_busy'} || !isNil {_unit getVariable 'MGI_heal'}) then {
  _unit setVariable ['MGI_busy', nil];
  _unit setVariable ['MGI_heal', nil];
  _unit switchMove "";
};

_unit setVariable ['MGI_healed', nil];
[(_unit getVariable ['MGI_myMedic', objNull]), _unit] call MGI_fn_medicRelease;
_unit setCaptive true;
_unit switchMove "AinjPpneMstpSnonWrflDnon";  // lay down

if (!isPlayer _unit) then {
  [
  _unit,
  "<t color='#00C900'>Heal Bros</t>",
  "\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa","\a3\ui_f\data\IGUI\Cfg\holdactions\holdAction_reviveMedic_ca.paa",
  "round(player distance2D _target) < 3 && lifeState _target == 'incapacitated' && _target getVariable ['FAR_isDragged',0] == 0 ",
  "round(player distance2D _target) < 3",
  {   if (stance player == 'PRONE') then {
        player playMoveNow 'ainvppnemstpslaywrfldnon_medicother';
      } else {
        player playMoveNow 'ainvpknlmstpslaywrfldnon_medicother';
    };
  },
  {
    if ((diag_tickTime > (_this select 3 select 0) + MGI_BleedOut) && lifeState _target == 'incapacitated') then {
      _target call MGI_fn_death;
    }
  },
  {
    [_target, player] call MGI_fn_sortie;
  },
  {
    player switchMove "";
  },
  [diag_tickTime],5,12,true,false] call BIS_fnc_holdActionAdd;
};
sleep 10;

_timer = diag_tickTime;
while {lifeState _unit == 'incapacitated' && diag_tickTime <= _timer + MGI_BleedOut} do {
  _medic = _unit getVariable ['MGI_myMedic', nil];
  if (isNil "_medic") then {
    _unit groupchat "I need a Medic !!";
    _medic = _unit call MGI_fn_medic;
    if (!isNil "_medic") then {
      [_unit, _medic] call MGI_fn_911;
    };
  };
  sleep 10;
};

[(_unit getVariable ['MGI_myMedic', objNull]), _unit] call MGI_fn_medicRelease;
_unit setCaptive false;

if (lifeState _unit == 'incapacitated' && diag_tickTime > _timer + MGI_BleedOut) then {
  _unit call MGI_fn_death;
};
