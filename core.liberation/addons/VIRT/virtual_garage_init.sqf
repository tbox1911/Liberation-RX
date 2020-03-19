
waitUntil {sleep 1; !isNil "GRLIB_garage"};
waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- Virtual Garage Initialized --------";