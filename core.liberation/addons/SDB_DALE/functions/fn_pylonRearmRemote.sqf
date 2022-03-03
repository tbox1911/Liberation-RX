// Rearm each turret's standard weapons and pylons

scriptName _fnc_scriptName;

private _veh = param [0,objNull,[objNull]];
private _fill = param [1,true,[false]];
private _turret = param [2,[-1],[[]]];
private _path = [_turret,[]] select (_turret isEqualTo [-1]);

private _turretMagazines = ((magazinesAllTurrets _veh) select {(_x select 1) isEqualTo _turret}) apply {_x select 0};
private _pylonMagazines = getPylonMagazines _veh;

// Dearm
{_veh removeMagazineTurret [_x,_turret];} forEach (_turretMagazines - _pylonMagazines);
{_veh setAmmoOnPylon [_x,0];} forEach ([_veh,_path] call DALE_fnc_getTurretPylons);

// Rearm
if (_fill) then {
	// Normal
	private _cfgTurret = configFile >> "CfgVehicles" >> typeOf _veh;
	{_cfgTurret = (_cfgTurret >> "turrets") select _x;} forEach _path;
	{_veh addMagazineTurret [_x,_turret];} forEach getArray (_cfgTurret >> "magazines");
	
	// Pylon
	private _cfgMagazines = configFile >> "CfgMagazines";
	{_veh setAmmoOnPylon [_x,getNumber (_cfgMagazines >> (_pylonMagazines select (_x-1)) >> "count")];} forEach ([_veh,_path] call DALE_fnc_getTurretPylons);
};