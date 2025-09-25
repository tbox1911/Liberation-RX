params ["_pos"];

(nearestObjects [_pos, [Radio_tower], 20]) select { (alive _x) && (_x getVariable ['GRLIB_Radio_Tower', false]) } select 0;