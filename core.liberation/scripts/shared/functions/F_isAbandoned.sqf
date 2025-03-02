// check if vehicle is abandoned
params ["_vehicle"];
if ((getPosASL _vehicle select 2) <= -15) exitWith { true };
(_vehicle getVariable ["GRLIB_vehicle_owner", ""] == "" && {(alive _x && side group _x == GRLIB_side_friendly)} count (crew _vehicle) == 0);
