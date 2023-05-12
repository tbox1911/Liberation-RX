// check if vehicle is abandoned
params ["_vehicle"];
(_vehicle getVariable ["GRLIB_vehicle_owner", ""] == "" && count (crew _vehicle) == 0);
