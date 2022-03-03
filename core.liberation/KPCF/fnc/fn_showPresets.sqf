/*
    Killah Potatoes Cratefiller v1.1.0

    Author: Dubjunk - https://github.com/KillahPotatoes
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Reads all saved presets and lists them.

    Parameter(s):
    NONE

    Returns:
    NONE
*/

// Dialog controls
private _dialog = findDisplay 758067;
private _ctrlImport = _dialog displayCtrl 75821;

// Reset variables
lbClear _ctrlImport;

// Read the presets from profileNamespace
private _import = profileNamespace getVariable ["KPCF_preset", []];

// Fill controls
{
    _ctrlImport lbAdd (_x select 0);
} forEach _import;
