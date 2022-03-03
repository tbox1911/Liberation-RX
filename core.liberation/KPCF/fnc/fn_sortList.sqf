/*
    Killah Potatoes Cratefiller v1.1.0

    Author: Dubjunk - https://github.com/KillahPotatoes
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Sorts the displaynames of the given item array.

    Parameter(s):
    0 : ARRAY - Array of classnames

    Returns:
    0 : ARRAY - Array of sorted subarrays with displayName and classname
*/

params [
    ["_list", [], [[]]]
];

private _config = "";
private _sortedList = [];

{
    _config = [_x] call KPCF_fnc_getConfigPath;
    if ((getText (configFile >> _config >> _x >> "displayName")) isEqualTo "") then {
    } else {
        _sortedList pushBack [
            (getText (configFile >> _config >> _x >> "displayName")),
            _x
        ];
    };
} forEach _list;

_sortedList sort true;

_sortedList
