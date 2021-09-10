if ( isDedicated ) exitWith {};
params [ "_location", "_penalty"];
if (score player < GRLIB_perm_tank || (player distance2D _location < GRLIB_sector_size) || time < (15 * 60) ) exitWith {};

_fobname = [ _location ] call F_getFobName;

private _msg = format [localize "STR_REMOTE_PENALTY", name player, _fobname, _penalty];
[_msg, 0, 0, 10, 0, 0, 90] spawn BIS_fnc_dynamicText;

playSound "taskfailed";
[player, -_penalty] remoteExec ["addScore", 2];
