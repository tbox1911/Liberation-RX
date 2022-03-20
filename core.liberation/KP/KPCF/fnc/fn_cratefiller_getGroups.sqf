#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KP_fnc_cratefiller_getGroups

    File: fn_cratefiller_getGroups.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-01-21
    Last Update: 2020-02-05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Gets all player groups and adds them to the listbox.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlGroups = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOGROUPS;

// Clear the lists
lbClear _ctrlGroups;

// Get all player groups
private _groups = [];
{
    _groups pushBackUnique group _x;
} forEach (allPlayers - (entities "HeadlessClient_F"));
_groups = _groups - [grpNull];
_groups sort true;

// Cache the groups
CCSVAR("groups", _groups, false);

// Fill the list
{
    _index = _ctrlGroups lbAdd groupId _x;
} forEach _groups;

true
