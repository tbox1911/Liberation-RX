// The Robust Air Taxi - v2.25
// by pSiko

// Taxi functions
call compile preprocessFile "addons\TAXI\taxi_functions.sqf";

// Heli Taxi Type
call compile preprocessFile "addons\TAXI\taxi_classname.sqf";

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- Air TAXI Initialized --------";