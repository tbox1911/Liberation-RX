params ["_start_pos", ["_size", 3], ["_water", false]];

if (count _start_pos == 0) exitWith {[]};
([_size, _start_pos, 200, 50, _water] call R3F_LOG_FNCT_3D_tirer_position_degagee_sol);
