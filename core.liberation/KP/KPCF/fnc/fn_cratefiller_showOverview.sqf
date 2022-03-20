#include "..\ui\defines.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KP_fnc_cratefiller_showOverview

    File: fn_cratefiller_showOverview.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2020-01-21
    Last Update: 2020-02-05
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Shows or hides the cratefiller overview display.

    Parameter(s):
        NONE

    Returns:
        Function reached the end [BOOL]
*/

// Dialog controls
private _dialog = findDisplay KP_CRATEFILLER_IDC_DIALOG;
private _ctrlOverviewGroup = _dialog displayCtrl KP_CRATEFILLER_IDC_GROUPOVERVIEW;

_ctrlOverviewGroup ctrlShow ([true, false] select (ctrlShown _ctrlOverviewGroup));

[] call KP_fnc_cratefiller_getGroups;

true
