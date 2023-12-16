params ["_medic", "_wnded", "_bonus"];

[_medic, _bonus] call F_addScore;
_medic setVariable ["PAR_lastRevive", round(time + 5*60), true];

private _text = format [localize "STR_PAR_ST_02", _bonus, name _wnded];
[_text] remoteExec ["hintSilent", owner _medic];
