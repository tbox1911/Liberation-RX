/*
    Killah Potatoes Cratefiller v1.2.0

    File: script_component.hpp
    Author: Dubjunk - https://github.com/KillahPotatoes
    Date: 2019-08-07
    Last Update: 2020-01-21
    License: GNU General Public License v3.0 - https://www.gnu.org/licenses/gpl-3.0.html

    Description:
        Defines for cratefiller scripts.
*/

// Cratefiller get var
#define CGVAR(var, defVal)      (KP_cratefiller_data getVariable [var, defVal])
// Cratefiller set var
#define CSVAR(var, val)         (KP_cratefiller_data setVariable [var, val, true])

// Cratefiller cache get var
#define CCGVAR(var, defVal)     (KP_cratefiller_cache getVariable [var, defVal])
// Cratefiller cache set var
#define CCSVAR(var, val, pub)   (KP_cratefiller_cache setVariable [var, val, pub])
