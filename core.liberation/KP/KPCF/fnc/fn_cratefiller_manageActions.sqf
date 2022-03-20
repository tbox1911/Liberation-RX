/*
    Killah Potatoes Cratefiller v1.2.0

    KP_fnc_cratefiller_manageActions

    File: fn_cratefiller_manageActions.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2019-09-16
    Last Update: 2019-09-16
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Adds actions to the cratefiller objects.

    Parameter(s):
        _object - defines the object to apply the action [OBJECT, defaults to objNull]

    Returns:
        Function reached the end [BOOL]
*/

params [
    ["_object", objNull, [objNull]]
];

if (KP_ace_enabled && KP_param_cratefiller_useAceActions) then {
    [_object] call KP_fnc_cratefiller_manageAceActions;
} else {
    _object addAction ["<t color='#FF8000'>" + localize "STR_KP_CRATEFILLER_ACTIONOPEN" + "</t>", {[_this] call KP_fnc_cratefiller_openDialog;}, nil, 1, false, true, "", "true", KP_param_cratefiller_interactRadius];
};

true
