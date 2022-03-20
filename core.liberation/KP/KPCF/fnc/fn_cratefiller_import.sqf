#include "..\ui\defines.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KP_fnc_cratefiller_import

    File: fn_cratefiller_import.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-02-05
    Last Update: 2020-02-05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Imports the selected inventory.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlImport = _dialog displayCtrl KP_CRATEFILLER_IDC_IMPORTNAME;

// Get the storage object
private _storage = [] call KP_fnc_cratefiller_getStorage;

// Check if there's an active storage
if (isNull _storage) exitWith {
    [localize "STR_KP_CRATEFILLER_HINTNOSTORAGE"] call CBA_fnc_notify;
};

// Read the import name
private _index = lbCurSel _ctrlImport;
private _importName = _ctrlImport lbText _index;

// Check for empty selection
if (_index isEqualTo -1) exitWith {
    [localize "STR_KP_CRATEFILLER_HINTSELECTION"] call CBA_fnc_notify;
};

// Get the storage inventory
private _inventory = [] call KP_fnc_cratefiller_getInventory;

// Read the presets from profileNamespace
private _import = profileNamespace getVariable ["KP_cratefiller_preset", []];
private _index = _import findIf {(_x select 0) isEqualTo _importName};
_inventory append ((_import select _index) select 1);

[_inventory] call KP_fnc_cratefiller_setInventory;

true
