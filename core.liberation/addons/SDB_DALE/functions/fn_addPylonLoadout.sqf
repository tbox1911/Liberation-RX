scriptName _fnc_scriptName;

private _veh = param [0,objNull,[objNull]];
private _turret = param [1,[-1],[[]]];
private _loadout = param [2,[],[[]]];

if (!(_veh turretLocal _turret)) exitWith {};

private _path = [_turret,[]] select (_turret isEqualTo [-1]);

{
	_veh setPylonLoadout _x;
	_veh setAmmoOnPylon [_x select 0,0];
} forEach (_loadout select {_path isEqualTo (_x select 3)});