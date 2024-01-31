// check if vehicle is public
params ["_vehicle"];
(_vehicle getVariable ["GRLIB_vehicle_owner", ""] == "public");
