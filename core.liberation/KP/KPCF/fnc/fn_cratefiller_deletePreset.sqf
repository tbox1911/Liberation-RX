#include "..\ui\defines.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KP_fnc_cratefiller_deletePreset

    File: fn_cratefiller_deletePreset.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-02-05
    Last Update: 2020-02-05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Deletes the selected preset.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlImport = _dialog displayCtrl KP_CRATEFILLER_IDC_IMPORTNAME;

// Read the import name
private _index = lbCurSel _ctrlImport;
private _importName = _ctrlImport lbText _index;

// Check for empty selection
if (_index isEqualTo -1) exitWith {
    [localize "STR_KP_CRATEFILLER_HINTSELECTION"] call CBA_fnc_notify;
};

// Read the presets from profileNamespace
private _import = profileNamespace getVariable ["KP_cratefiller_preset", []];

_import deleteAt (_import findIf {(_x select 0) isEqualTo _importName});

// Save the inventory into profileNamespace
profileNamespace setVariable ["KP_cratefiller_preset", _import];
saveProfileNamespace;

[] call KP_fnc_cratefiller_showPresets;

true
