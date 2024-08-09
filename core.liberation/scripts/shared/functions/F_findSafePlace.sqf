params ["_start_pos", ["_size", 5], ["_water", false], ["_max_radius", 150]];

if (count _start_pos == 0) exitWith {[]};
([_size, _start_pos, _max_radius, 50, _water] call R3F_LOG_FNCT_3D_tirer_position_degagee_sol);
