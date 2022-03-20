#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KP_fnc_cratefiller_createEquipmentList

    File: fn_cratefiller_createEquipmentList.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-02-05
    Last Update: 2020-02-05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Changes the shown equipment category.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlCat = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOEQUIPMENT;
private _ctrlWeapon = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOWEAPONS;
private _ctrlSearch = _dialog displayCtrl KP_CRATEFILLER_IDC_SEARCHBAR;
private _ctrlEquipment = _dialog displayCtrl KP_CRATEFILLER_IDC_EQUIPMENTLIST;

// Clear the lists
lbClear _ctrlWeapon;
lbClear _ctrlEquipment;

// Hide controls
_ctrlWeapon ctrlShow false;
_ctrlSearch ctrlShow false;

// Read controls
private _catIndex = lbCurSel _ctrlCat;

// Check for empty selection
if (_catIndex isEqualTo -1) exitWith {};

// Variables
private _config = "";

switch (_catIndex) do {

    // Weapons
    case 0 : {
        {
            _config = [_x select 1] call KP_fnc_cratefiller_getConfigPath;
            _ctrlEquipment lnbAddRow ["", _x select 0];
            _ctrlEquipment lnbSetPicture [[_foreachIndex, 0], getText (_config >> "picture")];
        } forEach (CGVAR("weapons", []));
        CCSVAR("activeCat", "weapons", false);
    };

    // Magazines
    case 1 : {
        _ctrlWeapon ctrlShow true;
        _ctrlSearch ctrlShow true;
        {
            _index = _ctrlWeapon lbAdd (_x select 0);
            _ctrlWeapon lbSetData [_index , _x select 1];
            _config = [_x select 1] call KP_fnc_cratefiller_getConfigPath;
            _ctrlWeapon lbSetPicture [_index, getText (_config >> "picture")];
        } forEach (CGVAR("weapons", []));
        CCSVAR("activeCat", "magazines", false);
    };

    // Attachments
    case 2 : {
        _ctrlWeapon ctrlShow true;
        _ctrlSearch ctrlShow true;
        {
            _index = _ctrlWeapon lbAdd (_x select 0);
            _ctrlWeapon lbSetData [_index , _x select 1];
            _config = [_x select 1] call KP_fnc_cratefiller_getConfigPath;
            _ctrlWeapon lbSetPicture [_index, getText (_config >> "picture")];
        } forEach (CGVAR("weapons", []));
        CCSVAR("activeCat", "attachments", false);
    };

    // Grenades
    case 3 : {
        {
            _config = [_x select 1] call KP_fnc_cratefiller_getConfigPath;
            _ctrlEquipment lnbAddRow ["", _x select 0];
            _ctrlEquipment lnbSetPicture [[_foreachIndex, 0], getText (_config >> "picture")];
        } forEach (CGVAR("grenades", []));
        CCSVAR("activeCat", "grenades", false);
    };

    // Explosives
    case 4 : {
        {
            _config = [_x select 1] call KP_fnc_cratefiller_getConfigPath;
            _ctrlEquipment lnbAddRow ["", _x select 0];
            _ctrlEquipment lnbSetPicture [[_foreachIndex, 0], getText (_config >> "picture")];
        } forEach (CGVAR("explosives", []));
        CCSVAR("activeCat", "explosives", false);
    };

    // Items
    case 5 : {
        {
            _config = [_x select 1] call KP_fnc_cratefiller_getConfigPath;
            _ctrlEquipment lnbAddRow ["", _x select 0];
            _ctrlEquipment lnbSetPicture [[_foreachIndex, 0], getText (_config >> "picture")];
        } forEach (CGVAR("items", []));
        CCSVAR("activeCat", "items", false);
    };

    // Backpacks
    case 6 : {
        {
            _config = [_x select 1] call KP_fnc_cratefiller_getConfigPath;
            _ctrlEquipment lnbAddRow ["", _x select 0];
            _ctrlEquipment lnbSetPicture [[_foreachIndex, 0], getText (_config >> "picture")];
        } forEach (CGVAR("backpacks", []));
        CCSVAR("activeCat", "backpacks", false);
    };

};

true
