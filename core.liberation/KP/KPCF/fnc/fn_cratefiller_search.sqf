#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KP_fnc_cratefiller_search

    File: fn_cratefiller_search.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-02-05
    Last Update: 2020-02-10
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Search for a weapon with the name entered in the search bar.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlWeapon = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOWEAPONS;
private _ctrlSearch = _dialog displayCtrl KP_CRATEFILLER_IDC_SEARCHBAR;

// Clear the listBox
lbClear _ctrlWeapon;
_ctrlWeapon lbSetCurSel -1;

// Get the editBox Data
private _search = toLower (ctrlText _ctrlSearch);

// Get the available weapons
private _weapons = CGVAR("weapons", []);

// Variables
private _foundWeapons = [];
private _index = 0;
private _config = "";

// Cross search the weapons array
{
    if !(((toLower (_x select 0)) find _search) isEqualTo -1) then {
        _foundWeapons pushBack _x;
    };
} forEach _weapons;

// Apply the found weapons to the dialog
{
    _index = _ctrlWeapon lbAdd (_x select 0);
    _ctrlWeapon lbSetData [_index , _x select 1];
    _config = [_x select 1] call KP_fnc_cratefiller_getConfigPath;
    _ctrlWeapon lbSetPicture [_index, getText (_config >> "picture")];
} forEach _foundWeapons;

true
