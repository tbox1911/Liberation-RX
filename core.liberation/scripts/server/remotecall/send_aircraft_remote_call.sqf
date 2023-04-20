if (!isServer && hasInterface) exitWith {};
params ["_unit"];

_targetsector = [sectors_allSectors, _unit] call F_nearestPosition;
[getMarkerPos _targetsector, GRLIB_side_friendly] spawn spawn_air;

_msg = format ["Commander <t color='#00008f'>%1</t>, ask for<br/><br/>
<t color='#0000F0'>Air</t> <t color='#F00000'>Suppremacy</t><br/><br/>
on Sector: <t color='#008000'>%2</t><br/>
<t size='0.7'>Lucky Bastards !!</t>", name _unit, markerText _targetsector];
[_msg, 0, 0, 10, 0, 0, 90] remoteExec ["BIS_fnc_dynamicText", 0];
sleep 7;
["lib_reinforcementsblu"] remoteExec ["bis_fnc_shownotification", 0];