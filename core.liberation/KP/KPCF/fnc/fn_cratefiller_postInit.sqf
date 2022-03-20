#include "script_component.hpp"
/*
    Killah Potatoes Cratefiller v1.2.0

    KP_fnc_cratefiller_postInit

    File: fn_cratefiller_postInit.sqf
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2019-05-09
    Last Update: 2020-10-14
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        The postInit function of a module takes care of starting/executing the modules functions or scripts.
        Basically it starts/initializes the module functionality to make all provided features usable.

    Parameter(s):
        NONE

    Returns:
        PostInit finished [BOOL]
*/

if (isServer) then {

    diag_log format ["[KP] [%1] [POST] [CRATEFILLER] Module initializing...", diag_tickTime];

    // Create cratefiller presets on startup
    [] call KP_fnc_cratefiller_presets;

};

// Player section
if (hasInterface) then {

    // Add CBA event handler to the base objects
    {
        [_x, "init", {[_this select 0] call KP_fnc_cratefiller_manageActions;}, nil, nil, true] call CBA_fnc_addClassEventHandler;
    } forEach CGVAR("buildings", []);

};

if (isServer) then {diag_log format ["[KP] [%1] [POST] [CRATEFILLER] Module initialized", diag_tickTime];};

true
