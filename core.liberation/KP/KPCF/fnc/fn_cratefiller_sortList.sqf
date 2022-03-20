#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KP_fnc_cratefiller_sortList

    File: fn_cratefiller_sortList.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-01-21
    Last Update: 2020-01-21
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Sorts the displaynames of the given item array.

    Parameter(s):
        _list - Array of elements which should be sorted [ARRAY, defaults to []]

    Returns:
        Alphabetical sorted list [ARRAY]
*/

params [
    ["_list", [], [[]]]
];

// Variables
private _config = "";
private _sortedList = [];

{
    _config = [_x] call KP_fnc_cratefiller_getConfigPath;
    if ((getText (_config >> "displayName")) isEqualTo "") then {
    } else {
        _sortedList pushBack [
            (getText (_config >> "displayName")),
            _x
        ];
    };
} forEach _list;

_sortedList sort true;

_sortedList
