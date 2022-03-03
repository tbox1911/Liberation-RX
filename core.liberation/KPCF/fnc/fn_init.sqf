/*
    Killah Potatoes Cratefiller v1.1.0

    Author: Dubjunk - https://github.com/KillahPotatoes

    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    This will initialize the KP cratefiller functionalities.

    Dependencies:
        * KPGUI
*/

// Only run, when we've a real player
if (hasInterface) then {

    // Read the config file
    [] call compile preprocessFileLineNumbers "KPCF_config.sqf";

    // Read the variables
    [] call compile preprocessFileLineNumbers "KPCF\variables.sqf";

    // Check for ACE
    KPCF_ace = isClass (configfile >> "CfgPatches" >> "ace_common");

    // Add CBA event handler to the base objects
    {
        [_x, "init", {[_this select 0] call KPCF_fnc_manageActions;}, nil, nil, true] call CBA_fnc_addClassEventHandler;
    } forEach KPCF_cratefillerBase;

    // Generate the lists if enabled
    if (KPCF_generateLists) then {
        [] call KPCF_fnc_getItems;
    };

    // Sort the item lists
    KPCF_sortedCrates = [KPCF_crates] call KPCF_fnc_sortList;
    KPCF_sortedWeapons = [KPCF_weapons] call KPCF_fnc_sortList;
    KPCF_sortedGrenades = [KPCF_grenades] call KPCF_fnc_sortList;
    KPCF_sortedExplosives = [KPCF_explosives] call KPCF_fnc_sortList;
    KPCF_sortedItems = [KPCF_items] call KPCF_fnc_sortList;
    KPCF_sortedBackpacks = [KPCF_backpacks] call KPCF_fnc_sortList;

};
