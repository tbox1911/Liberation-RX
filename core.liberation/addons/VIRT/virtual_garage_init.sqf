waitUntil {!(isNull (findDisplay 46))};

waitUntil {
    sleep 1;
    GRLIB_virtual_garage = player getVariable "GRLIB_virtual_garage";
    !(isNil "GRLIB_virtual_garage")
};

systemChat "-------- Virtual Garage Initialized --------";