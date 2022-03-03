scriptName _fnc_scriptName;
if (!isServer or !canSuspend) exitWith {};

private _veh = param [0,objNull,[objNull]];
private _pylonMagazines = param [1,[],[[]]];
private _pylonPaths = param [2,[],[[]]];
private _cfgComponent = configFile >> "CfgVehicles" >> typeOf _veh >> "Components" >> "TransportPylonsComponent";

if (!isClass _cfgComponent) exitWith {};

private _allTurrets = [[-1]] + allTurrets _veh;

// Clear weapons
{[_veh,_x] remoteExecCall ["DALE_fnc_clearPylonLoadout",_veh turretOwner _x];} forEach _allTurrets;

waitUntil {getPylonMagazines _veh findIf {_x != ""} < 0};

private _pylonTurrets = _pylonPaths apply {[_x,[-1]] select (_x isEqualTo [])};

// Add weapons
private _loadout = [];
{_loadout pushBack [1+_forEachIndex,_x,true,_pylonPaths select _forEachIndex];} forEach _pylonMagazines;
{[_veh,_x,_loadout] remoteExecCall ["DALE_fnc_addPylonLoadout",_veh turretOwner _x];} forEach _allTurrets;

// Save variables to vehicle
_veh setVariable ["DALE_var_loadoutTurrets",_pylonPaths,true];

// Rearm
[_veh, true] call DALE_fnc_pylonRearm;