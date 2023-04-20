scriptName _fnc_scriptName;

private _veh = param [0,objNull,[objNull]];
private _pylon = param [1,0,[0,"",configNull]];
private _cfgComponent = configFile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent";

if (!isClass _cfgComponent) exitWith {[];};

private _cfgPylons = "isClass _x" configClasses (_cfgComponent >> "Pylons");
private _index = switch (typeName _pylon) do {
	case (typeName 0):			{_pylon-1};
	case (typeName ""):			{_cfgPylons find (_cfgComponent >> "Pylons" >> _pylon)};
	case (typeName configNull):	{_cfgPylons find _pylon};
	default {-1};
};

if (_index < 0) exitWith {[];};

private _pylonTurrets = _veh getVariable "DALE_var_LoadoutTurrets";
private _turret = if (isNil "_pylonTurrets") then {getArray ((_cfgPylons select _index) >> "turret")} else {_pylonTurrets param [_index,[],[[]]]};

_turret;