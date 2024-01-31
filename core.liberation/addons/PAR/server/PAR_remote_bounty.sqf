params ["_medic", "_wnded", "_bonus"];

if (isNull _medic) exitWith {};

[_medic, _bonus] call F_addScore;
_medic setVariable ["PAR_lastRevive", round(time + 5*60), true];

private _name = name _wnded;
if (isNull _wnded) then { _name = "Unknown" };

private _text = format [localize "STR_PAR_ST_02", _bonus, _name];
[_text] remoteExec ["hintSilent", owner _medic];
