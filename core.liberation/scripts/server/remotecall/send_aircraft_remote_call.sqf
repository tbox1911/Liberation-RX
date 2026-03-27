if (!isServer && hasInterface) exitWith {};
params ["_unit"];

if (isNil "_unit") exitWith {};
if (isNull _unit) exitWith {};

private _plane_count = 3 + (floor random 4);
private _target = [sectors_allSectors, _unit] call F_nearestPosition;
[markerPos _target, GRLIB_side_friendly, _plane_count] spawn spawn_air;

_msg = format ["Commander <t color='#00008f'>%1</t>, ask for<br/><br/>
<t color='#0000F0'>Air</t> <t color='#F00000'>Suppremacy</t><br/><br/>
on Sector: <t color='#008000'>%2</t><br/>
<t size='0.7'>Lucky Bastards !!</t>", name _unit, markerText _target];
[_msg, 0, 0, 10, 0, 0, 90] remoteExec ["BIS_fnc_dynamicText", 0];

sleep 7;
["lib_reinforcementsblu"] remoteExec ["bis_fnc_shownotification", 0];
private _msg = format ["--- Air Support: %1 units are incoming...", _plane_count];
[gamelogic, _msg] remoteExec ["globalChat", 0];
