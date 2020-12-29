params ['_wnded'];
[(_wnded getVariable ['PAR_myMedic', objNull]), _wnded] call PAR_fn_medicRelease;
_wnded setVariable ['PAR_wounded', false];
_wnded setUnconscious false;
_wnded allowDamage true;
_wnded setDamage 1;
