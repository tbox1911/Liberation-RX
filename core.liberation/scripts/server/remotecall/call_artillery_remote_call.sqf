if (!isServer && hasInterface) exitWith {};
params ["_unit", "_position"];

_targetsector = [300, _position ] call F_getNearestSector;
_msg = format ["Commander <t color='#00008f'>%1</t>, ask for<br/><br/>
<t color='#0000F0'>Artillery</t> <t color='#F00000'>Destruction</t><br/><br/>
on Sector: <t color='#008000'>%2</t><br/>
<t size='0.7'>Lucky Bastards !!</t>",name _unit, markerText _targetsector];
[_msg, 0, 0, 10, 0, 0, 90] remoteExec ["BIS_fnc_dynamicText", 0];
sleep 2;

private _ammo_list = [
	"Sh_155mm_AMOS",
	"Sh_155mm_AMOS",
	"Sh_155mm_AMOS",
	"Sh_155mm_AMOS",
	"Sh_120mm_HE",
	"Sh_120mm_HE",
	"Sh_120mm_HE",
	"Sh_120mm_HE",		
	"Sh_155mm_AMOS_guided",
	"Sh_155mm_AMOS_guided",
	"Cluster_155mm_AMOS",
	"Bomb_03_F",
	"Bomb_04_F",
	"BombCluster_01_Ammo_F",
	"BombCluster_02_Ammo_F",
	"BombCluster_03_Ammo_F"
];

for "_i" from 1 to 6 do {
	_ammo = selectRandom _ammo_list;
	_max = 4;
	if (_ammo find "Bomb" > -1) then { _max = 1 };
	for "_j" from 1 to _max do {
		_round = _ammo createVehicle (_position getPos [50 + (round(random 100) -50), random 360]);
		[_round, -90, 0] call BIS_fnc_setPitchBank;
		_round setVelocity [0,0,-100];
		sleep 1;
	};
	sleep 5;
};
