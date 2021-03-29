if ( isDedicated ) exitWith {};
params [ "_location", "_penalty"];
if ([player] call F_getScore < GRLIB_perm_air || (player distance2D _location < GRLIB_sector_size) || time < (15 * 60) ) exitWith {};

_fobname = [ _location ] call F_getFobName;

private _msg = format ["Warning <t color='#00008f'>%1</t> !<br/><br/>
You failed to defend FOB: <t color='#0000F0'>%2</t>...<br/><br/>
The HQ order a score penalty of: <t color='#A00000'>%3</t>.<br/>", name player, _fobname, _penalty];
[_msg, 0, 0, 10, 0, 0, 90] spawn BIS_fnc_dynamicText;

playSound "taskfailed";
[player, -_penalty] call F_addScore;
