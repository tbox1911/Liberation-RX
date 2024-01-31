params ["_vehicle"];
(format ["%1kg - %2%3",(maxLoad _vehicle - loadAbs _vehicle), (1 - (load _vehicle))*100, "%"]);
