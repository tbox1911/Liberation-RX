/*
    Killah Potatoes Cratefiller v1.1.0

    Author: Dubjunk - https://github.com/KillahPotatoes
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Spawns the selected crate.

    Parameter(s):
    NONE

    Returns:
    NONE
*/

// Dialog controls
private _dialog = findDisplay 758067;
private _ctrlCrate = _dialog displayCtrl 75801;

// Read the controls
private _crateIndex = lbCurSel _ctrlCrate;

// Check for empty selection
if (_crateIndex == -1) exitWith {
    hint localize "STR_KPCF_HINTSELECTION";
    [{hintSilent "";}, [], 3] call CBA_fnc_waitAndExecute;
};

// Crate selection
private _crateType = _ctrlCrate lbData _crateIndex;

private _checkSpawn = false;

// Check if spawnpoint is clear
if (KPCF_activeSpawn != KPCF_activeBase) then {
    _checkSpawn = true;
};

if ((!(((getPos KPCF_activeSpawn) nearEntities 5) isEqualTo [])) && _checkSpawn) exitWith {
    hint localize "STR_KPCF_HINTZONE";
    [{hintSilent "";}, [], 3] call CBA_fnc_waitAndExecute;
};

// Spawn crate
private _crate = createVehicle [_crateType, ((getPos KPCF_activeSpawn) findEmptyPosition [0, 10, _crateType]), [], 0, "NONE"];

// Clear the storage
clearWeaponCargoGlobal _crate;
clearMagazineCargoGlobal _crate;
clearItemCargoGlobal _crate;
clearBackpackCargoGlobal _crate;

private _config = [_crateType] call KPCF_fnc_getConfigPath;
private _name = (getText (configFile >> _config >> _crateType >> "displayName"));
hint format [localize "STR_KPCF_HINTSPAWN", _name];
[{hintSilent "";}, [], 3] call CBA_fnc_waitAndExecute;

[] call KPCF_fnc_getNearStorages
