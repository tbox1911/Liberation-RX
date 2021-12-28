params ["_wnded"];

if (isPlayer _wnded) then {
  if ( score _wnded > GRLIB_perm_log + 10 ) then { [_wnded, -10] remoteExec ["addScore", 2] };  
};

[(_wnded getVariable ['PAR_myMedic', objNull]), _wnded] call PAR_fn_medicRelease;
_wnded setVariable ['PAR_wounded', false];
_wnded setUnconscious false;
_wnded allowDamage true;
_wnded setDamage 1;
