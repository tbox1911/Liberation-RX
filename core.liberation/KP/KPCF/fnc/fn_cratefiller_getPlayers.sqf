
#include "..\ui\defines.hpp"
#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KP_fnc_cratefiller_getPlayers

    File: fn_cratefiller_getPlayers.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-01-21
    Last Update: 2020-02-05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Gets all players from the selected group and adds them to the listbox.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlGroups = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOGROUPS;
private _ctrlPlayers = _dialog displayCtrl KP_CRATEFILLER_IDC_COMBOPLAYERS;

// Clear the lists
lbClear _ctrlPlayers;

// Read controls
private _index = lbCurSel _ctrlGroups;

// Get the selected group from the namespace
private _group = (CCGVAR("groups", [])) select _index;

// Get all units from the group
private _players = (units _group) select {isPlayer _x};

// Cache the players
CCSVAR("players", _players, false);

// Fill the list
{
    _index = _ctrlPlayers lbAdd name _x;
} forEach _players;

true
