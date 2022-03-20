
#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KP_fnc_cratefiller_addEquipment

    File: fn_cratefiller_addEquipment.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-02-05
    Last Update: 2020-02-10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Adds one of the selected item to the inventory.

    Parameter(s):
        _controlId - Id of the control which is selected [NUMBER, defaults to 0]

    Returns:
        Function reached the end [BOOL]
*/

params [
    ["_controlId", 0, [0]]
];

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlActive = _dialog displayCtrl _controlId;

// Read controls
private _indexActive = lbCurSel _ctrlActive;

// Check for empty selection
if (_indexActive isEqualTo -1 || ((lnbSize _ctrlActive) select 0) isEqualTo 0) exitWith {
    [localize "STR_KP_CRATEFILLER_HINTSELECTION"] call CBA_fnc_notify;
};

// Get the storage object
private _storage = [] call KP_fnc_cratefiller_getStorage;
private _inventory = [] call KP_fnc_cratefiller_getInventory;

// Exit on missing storage
if (isNull _storage) exitWith {
	[localize "STR_KP_CRATEFILLER_HINTNOSTORAGE"] call CBA_fnc_notify;
};

// Variables
private _item = "";

if (_controlId isEqualTo KP_CRATEFILLER_IDC_INVENTORYLIST) then {
    // Item selection
    _item = (_inventory select _indexActive) select 1;
} else {
    private _cat = CCGVAR("activeCat", "");
    private _catStuff = CGVAR(_cat, []);
    _item = (_catStuff select _indexActive) select 1;
};

// Check for enough inventory capacity
if (!(_storage canAdd _item)) exitWith {
    CBA_ui_notifyQueue = [];
    [localize "STR_KP_CRATEFILLER_HINTFULL"] call CBA_fnc_notify;
};

// Add the given item
if (_item isKindOf "Bag_Base") then {
    _storage addBackpackCargoGlobal [_item, 1];
} else {
    _storage addItemCargoGlobal [_item, 1];
};

[] remoteExecCall ["KP_fnc_cratefiller_showInventory", (allPlayers - entities "HeadlessClient_F")];

private _config = [_item] call KP_fnc_cratefiller_getConfigPath;
private _name = (getText (_config >> "displayName"));
private _picture = (getText (_config >> "picture"));
CBA_ui_notifyQueue = [];
[
    [_picture, 2],
    [format [localize "STR_KP_CRATEFILLER_HINTADDED", _name, 1]]
] call CBA_fnc_notify;

true
