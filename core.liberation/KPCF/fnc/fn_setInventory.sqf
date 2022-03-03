/*
    Killah Potatoes Cratefiller v1.1.0

    Author: Dubjunk - https://github.com/KillahPotatoes
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Adds the items to the active crate.

    Parameter(s):
    NONE

    Returns:
    NONE
*/

// Check if the storage is in range
if ((KPCF_activeStorage distance2D KPCF_activeSpawn) > KPCF_spawnRadius) exitWith {
    hint localize "STR_KPCF_HINTRANGE";
    [{hintSilent "";}, [], 3] call CBA_fnc_waitAndExecute;
    [] remoteExecCall ["KPCF_fnc_getNearStorages", (allPlayers - entities "HeadlessClient_F")];
};

// Check if the storage will be empty
if (count KPCF_inventory == 0) exitWith {
    clearWeaponCargoGlobal KPCF_activeStorage;
    clearMagazineCargoGlobal KPCF_activeStorage;
    clearItemCargoGlobal KPCF_activeStorage;
    clearBackpackCargoGlobal KPCF_activeStorage;
    [] remoteExecCall ["KPCF_fnc_getInventory", (allPlayers - entities "HeadlessClient_F")];
};

// Clear the storage
clearWeaponCargoGlobal KPCF_activeStorage;
clearMagazineCargoGlobal KPCF_activeStorage;
clearItemCargoGlobal KPCF_activeStorage;
clearBackpackCargoGlobal KPCF_activeStorage;

// Count the variable index
private _count = count KPCF_inventory;
private _abort = false;
private _item = "";
private _amount = 0;

// Adapt the cargo into KPCF variable
for "_i" from 0 to (_count-1) do {
    _item = (KPCF_inventory select _i) select 1;
    _amount = (KPCF_inventory select _i) select 2;
    if (!(KPCF_activeStorage canAdd [_item, _amount])) exitWith {
        _abort = true;
    };
    if (((KPCF_inventory select _i) select 1) isKindOf "Bag_Base") then {
        KPCF_activeStorage addBackpackCargoGlobal [_item, _amount];
    } else {
        KPCF_activeStorage addItemCargoGlobal [_item, _amount];
    };
};

// Check for enough inventory capacity
if (_abort) exitWith {
    [] remoteExecCall ["KPCF_fnc_getInventory", (allPlayers - entities "HeadlessClient_F")];
    hint format [localize "STR_KPCF_HINTFULL"];
    [{hintSilent "";}, [], 3] call CBA_fnc_waitAndExecute;
};

[] remoteExecCall ["KPCF_fnc_getInventory", (allPlayers - entities "HeadlessClient_F")];
