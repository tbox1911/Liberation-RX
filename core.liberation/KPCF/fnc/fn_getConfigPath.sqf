/*
    Killah Potatoes Cratefiller v1.1.0

    Author: Dubjunk - https://github.com/KillahPotatoes
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
    Gets the config path for the given classname.

    Parameter(s):
    0: OBJECT - Item for the check.

    Returns:
    STRING
*/

params [
    "_item"
];

// find configclass
switch true do
{
    case (isClass(configFile >> "CfgMagazines" >> _item)): {"CfgMagazines"};
    case (isClass(configFile >> "CfgWeapons" >> _item)): {"CfgWeapons"};
    case (isClass(configFile >> "CfgVehicles" >> _item)): {"CfgVehicles"};
    case (isClass(configFile >> "CfgGlasses" >> _item)): {"CfgGlasses"};
    default {""};
};
