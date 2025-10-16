if (!isServer && hasInterface) exitWith {};
params ["_unit", "_position"];

if (isNil "_unit") exitWith {};
if (isNull _unit) exitWith {};

_targetsector = [300, _position ] call F_getNearestSector;
_msg = format ["Commander <t color='#00008f'>%1</t>, ask for<br/><br/>
<t color='#0000F0'>Artillery</t> <t color='#F00000'>Destruction</t><br/><br/>
on Sector: <t color='#008000'>%2</t><br/>
<t size='0.7'>Lucky Bastards !!</t>",name _unit, markerText _targetsector];
[_msg, 0, 0, 10, 0, 0, 90] remoteExec ["BIS_fnc_dynamicText", 0];
sleep 2;
private _ammo_name = [
	["Bomb_03_F","565lb, high-explosive, laser-guided bomb"],
	["Bomb_04_F","500lb, high-explosive, laser-guided bomb"],
	["BombCluster_01_Ammo_F","750lb, laser-guided cluster bomb"],
	["BombCluster_02_Ammo_F","1100lb, laser-guided cluster bomb"],
	["BombCluster_03_Ammo_F","580lb, laser-guided cluster bomb"],
	["Sh_120mm_HE","120mm, HEAT-MP-T"],
	["Sh_155mm_AMOS","155mm, HE Shells"],
	["Sh_155mm_AMOS_guided","155mm, guided HE Shells"],
	["Cluster_155mm_AMOS","155mm, Howitzer cluster bomb"],
	["",""]
];

private _ammo_list = [
	"Sh_120mm_HE",
	"Sh_120mm_HE",
	"Sh_120mm_HE",
	"Sh_155mm_AMOS",
	"Sh_155mm_AMOS",
	"Cluster_155mm_AMOS",
	"Cluster_155mm_AMOS",
	"Bomb_03_F",
	"Bomb_03_F",
	"Bomb_04_F",
	"Bomb_04_F",
	"BombCluster_01_Ammo_F",
	"BombCluster_01_Ammo_F",
	"BombCluster_02_Ammo_F",
	"BombCluster_03_Ammo_F",
	"BombCluster_03_Ammo_F"
];

for "_i" from 1 to 6 do {
	_ammo = selectRandom _ammo_list;
	_max = 4;
	if (_ammo find "Bomb" > -1) then { _max = 1 };
	_name = {if (_x select 0 == _ammo) exitWith {_x select 1}} forEach _ammo_name;
	_msg = format ["Artillery fire %1 x %2.", _max, _name];
	[gamelogic, _msg] remoteExec ["globalChat", 0];
	for "_j" from 1 to _max do {
		_round = _ammo createVehicle (_position getPos [50 + (round(random 100) -50), random 360]);
		[_round, -90, 0] call BIS_fnc_setPitchBank;
		_round setVelocity [0,0,-100];
		sleep 1;
	};
	sleep 5;
};
[gamelogic, "Artillery fires end."] remoteExec ["globalChat", 0];
