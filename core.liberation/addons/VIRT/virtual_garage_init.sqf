waitUntil {!(isNull (findDisplay 46))};

waitUntil {
    sleep 1;
    GRLIB_virtual_garage = player getVariable format ["GRLIB_virtual_garage_%1", PAR_Grp_ID];
    !(isNil "GRLIB_virtual_garage")
};

systemChat "-------- Virtual Garage Initialized --------";