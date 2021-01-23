scriptName _fnc_scriptName;

private _veh = param [0,objNull,[objNull]];
private _turret = param [1,[-1],[[]]];
private _type = typeName param [2,0,[0,"",configNull]];
private _cfgComponent = configFile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent";
private _pylons = [];

if (!isClass _cfgComponent) exitWith {_pylons;};

private _path = [_turret,[]] select (_turret isEqualTo [-1]);
private _cfgPylons = "isClass _x" configClasses (_cfgComponent >> "Pylons");

{
	if (_path isEqualTo ([_veh,_x] call DALE_fnc_getPylonTurret)) then {
		switch _type do {
			case (typeName 0):			{_pylons pushBack (1+_forEachIndex);};
			case (typeName ""):			{_pylons pushBack configName _x;};
			case (typeName configNull):	{_pylons pushBack _x;};
		};
	};
} forEach _cfgPylons;

_pylons;