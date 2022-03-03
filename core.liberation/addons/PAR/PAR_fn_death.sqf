params ["_wnded"];

if (isPlayer _wnded) then {
  private _score = score _wnded;
  private _penalty = 0;
  if ( _score > GRLIB_perm_inf ) then { _penalty = 25 };
  if ( _score > GRLIB_perm_air ) then { _penalty = 50 };
  if ( _score > GRLIB_perm_max ) then { _penalty = 100 };
  if ( _penalty > 0 ) then { [_wnded, -_penalty] remoteExec ["addScore", 2] };
};

[(_wnded getVariable ['PAR_myMedic', objNull]), _wnded] call PAR_fn_medicRelease;
_wnded setVariable ['PAR_wounded', false];
_wnded setUnconscious false;
_wnded allowDamage true;
_wnded setDamage 1;
