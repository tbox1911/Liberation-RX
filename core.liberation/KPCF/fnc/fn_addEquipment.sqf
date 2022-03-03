/*
    Killah Potatoes Cratefiller v1.1.0

    Author: Dubjunk - https://github.com/KillahPotatoes
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Adds the given amount of the selected item to the crate.

    Parameter(s):
    0 : SCALAR - Amount of the added item.

    Returns:
    NONE
*/

params [
    "_amount"
];

// Dialog controls
private _dialog = findDisplay 758067;
private _ctrlEquipment = _dialog displayCtrl 75812;

// Read controls
private _index = lbCurSel _ctrlEquipment;

// Check for empty variable
if (isNull KPCF_activeStorage) exitWith {
    hint localize "STR_KPCF_HINTSELECTION";
    [{hintSilent "";}, [], 3] call CBA_fnc_waitAndExecute;
};

// Check for empty selection
if (_index == -1) exitWith {
    hint localize "STR_KPCF_HINTSELECTION";
    [{hintSilent "";}, [], 3] call CBA_fnc_waitAndExecute;
};

// Check if the storage is in range
if ((KPCF_activeStorage distance2D KPCF_activeSpawn) > KPCF_spawnRadius) exitWith {
    hint localize "STR_KPCF_HINTRANGE";
    [{hintSilent "";}, [], 3] call CBA_fnc_waitAndExecute;
    [] remoteExecCall ["KPCF_fnc_getNearStorages", (allPlayers - entities "HeadlessClient_F")];
};

// Item selection
private _item = _ctrlEquipment lbData _index;

// Check for enough inventory capacity
if (!(KPCF_activeStorage canAdd [_item, _amount])) exitWith {
    hint format [localize "STR_KPCF_HINTFULL"];
    [{hintSilent "";}, [], 3] call CBA_fnc_waitAndExecute;
};

// Add the given item
if (_item isKindOf "Bag_Base") then {
    KPCF_activeStorage addBackpackCargoGlobal [_item, _amount];
} else {
    KPCF_activeStorage addItemCargoGlobal [_item, _amount];
};

[] remoteExecCall ["KPCF_fnc_getInventory", (allPlayers - entities "HeadlessClient_F")];

private _config = [_item] call KPCF_fnc_getConfigPath;
private _name = (getText (configFile >> _config >> _item >> "displayName"));
hint format [localize "STR_KPCF_HINTADDED", _name, _amount];
[{hintSilent "";}, [], 3] call CBA_fnc_waitAndExecute;
