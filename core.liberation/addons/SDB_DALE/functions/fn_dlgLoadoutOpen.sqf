disableSerialization;

scriptName _fnc_scriptName;
if (!hasInterface) exitWith {};

private _veh = param [0,objNull,[objNull]];
private _cfgVeh = configFile >> "CfgVehicles" >> typeOf _veh;
private _cfgComponent = _cfgVeh >> "Components" >> "TransportPylonsComponent";

if (!isClass _cfgComponent) exitWith {};

_veh engineOn false;

private _display = [_veh] call DALE_fnc_dlgLoadoutCreate;
[_display] call DALE_fnc_dlgLoadoutPylonCreate;