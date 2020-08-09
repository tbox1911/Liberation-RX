params ['_wnded'];
[(_wnded getVariable ['MGI_myMedic', objNull]), _wnded] call MGI_fn_medicRelease;
_wnded setVariable ['MGI_isUnconscious', false];
_wnded setUnconscious false;
_wnded allowDamage true;
_wnded setDamage 1;
