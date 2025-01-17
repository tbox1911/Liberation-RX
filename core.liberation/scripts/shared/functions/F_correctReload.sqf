params [ "_unit" ];

// try to fix A3 Reload bug 
_unit reload [];
sleep 2;
private _magType = getArray (configFile >> "CfgWeapons" >> (currentWeapon _unit) >> "magazines") select 0;
_unit addMagazine [_magType, 1];
