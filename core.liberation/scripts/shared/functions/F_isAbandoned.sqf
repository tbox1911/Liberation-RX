// check if vehicle is abandoned
params ["_vehicle"];
if (!(_vehicle isKindOf "Ship") && (getPosASL _vehicle select 2) <= -15) exitWith { true };
(_vehicle getVariable ["GRLIB_vehicle_owner", ""] == "" && {alive _x} count (crew _vehicle) == 0);
