#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KP_fnc_cratefiller_spawnCrate

    File: fn_cratefiller_spawnCrate.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-02-05
    Last Update: 2020-02-10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Spawns the selected crate.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlCrate = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOCRATE;

// Read the controls
private _crateIndex = lbCurSel _ctrlCrate;

// Check for empty selection
if (_crateIndex == -1) exitWith {
    [localize "STR_KP_CRATEFILLER_HINTSELECTION"] call CBA_fnc_notify;
};

// Crate selection
private _crateType = _ctrlCrate lbData _crateIndex;

private _object = CCGVAR("object", objNull);

private _checkSpawn = false;

if (!((((getPos _object) nearEntities 5) select {!(typeOf _x in CGVAR("buildings", []))}) isEqualTo [])) exitWith {
    [localize "STR_KP_CRATEFILLER_HINTZONE"] call CBA_fnc_notify;
};

// Spawn crate
private _crate = createVehicle [_crateType, ((getPos _object) findEmptyPosition [0, KP_param_cratefiller_usageRadius, _crateType]), [], 0, "NONE"];

// Clear the storage
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

private _config = [_crateType] call KP_fnc_cratefiller_getConfigPath;
private _name = (getText (_config >> "displayName"));
[format [localize "STR_KP_CRATEFILLER_HINTSPAWN", _name]] call CBA_fnc_notify;

[] call KP_fnc_cratefiller_getNearStorages;

true
