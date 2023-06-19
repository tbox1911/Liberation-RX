if (!isServer && hasInterface) exitWith {};
params ["_unit", "_position"];

_targetsector = [300, _position ] call F_getNearestSector;
_msg = format ["Commander <t color='#00008f'>%1</t>, ask for<br/><br/>
<t color='#0000F0'>Artillery</t> <t color='#F00000'>Suppremacy</t><br/><br/>
on Sector: <t color='#008000'>%2</t><br/>
<t size='0.7'>Lucky Bastards !!</t>",name _unit, markerText _targetsector];
[_msg, 0, 0, 10, 0, 0, 90] remoteExec ["BIS_fnc_dynamicText", 0];

sleep 3;
//["lib_reinforcementsblu"] remoteExec ["bis_fnc_shownotification", 0];

private _ammo_list = [ "8Rnd_82mm_Mo_shells", "8Rnd_82mm_Mo_guided"];
private _mortar = "B_Mortar_01_F" createVehicle _position;

for "_i" from 1 to 4 do { 
	_mortar setVehicleAmmo 1;
	_ammo = selectRandom _ammo_list;   
	_tgt = _position getRelPos [(50 + round random 100), random 360];   
	_mortar doArtilleryFire [_tgt, _ammo, 8];
	sleep 20;
};
deleteVehicle _mortar;