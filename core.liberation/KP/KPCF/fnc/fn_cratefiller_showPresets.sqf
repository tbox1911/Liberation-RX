
#include "..\ui\defines.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KP_fnc_cratefiller_showPresets

    File: fn_cratefiller_showPresets.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-02-05
    Last Update: 2020-02-05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Reads all saved presets and lists them.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlImport = _dialog displayCtrl KP_CRATEFILLER_IDC_IMPORTNAME;

// Reset variables
lbClear _ctrlImport;

// Read the presets from profileNamespace
private _import = profileNamespace getVariable ["KP_cratefiller_preset", []];

// Fill controls
{
    _ctrlImport lbAdd (_x select 0);
} forEach _import;

true
