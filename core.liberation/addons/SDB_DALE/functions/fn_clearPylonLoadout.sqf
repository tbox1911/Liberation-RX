scriptName _fnc_scriptName;

private _veh = param [0,objNull,[objNull]];
private _turret = param [1,[-1],[[]]];

if (!(_veh turretLocal _turret)) exitWith {};

private _path = [_turret,[]] select (_turret isEqualTo [-1]);

// Remove pylon weapons
private _cfgTurret = configFile >> "CfgVehicles" >> typeOf _veh;
{_cfgTurret = (_cfgTurret >> "turrets") select _x;} forEach _path;
{_veh removeWeaponTurret [_x,_turret];} forEach ((_veh weaponsTurret _turret) - getArray (_cfgTurret >> "weapons"));

// Remove pylon magazines
{_veh setPylonLoadout [_x,"",true];} forEach ([_veh,_path] call DALE_fnc_getTurretPylons);