#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KP_fnc_cratefiller_deleteCrate

    File: fn_cratefiller_deleteCrate.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-02-05
    Last Update: 2020-02-10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Deletes the selected crate.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Get the active storage
private _storage = [] call KP_fnc_cratefiller_getStorage;

// Check for empty variable
if (isNull _storage) exitWith {
    [localize "STR_KP_CRATEFILLER_HINTSELECTION"] call CBA_fnc_notify;
};

// Check if the active storage is a pre defined crate
if ((typeOf _storage) in CGVAR("crates", [])) exitWith {
    [localize "STR_KP_CRATEFILLER_HINTNONDELETEABLE"] call CBA_fnc_notify;
};

// Delete crate
deleteVehicle _storage;

private _config = [typeOf _storage] call KP_fnc_cratefiller_getConfigPath;
private _name = (getText (_config >> "displayName"));

_storage = objNull;

[] remoteExecCall ["KP_fnc_cratefiller_getInventory", (allPlayers - entities "HeadlessClient_F")];
[{[] remoteExecCall ["KP_fnc_cratefiller_getNearStorages", (allPlayers - entities "HeadlessClient_F")];}, [], 1] call CBA_fnc_waitAndExecute;

[format [localize "STR_KP_CRATEFILLER_HINTDELETE", _name]] call CBA_fnc_notify;

true
