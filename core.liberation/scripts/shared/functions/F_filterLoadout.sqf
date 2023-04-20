params [ "_unit" ];

{
    if (_x in ([primaryWeapon _unit])) then {_unit removeWeapon _x};
    if (_x in ([secondaryWeapon _unit])) then {_unit removeWeapon _x};
    if (_x in ([uniform _unit])) then {removeUniform _unit};
    if (_x in ([headgear _unit])) then {removeHeadgear _unit};
    if (_x in ([backpack _unit])) then {removeBackpack _unit};
    if (_x in ([hmd _unit])) then {_unit unassignItem _x; _unit removeItem  _x};
    if (_x in (primaryWeaponItems _unit)) then {_unit removePrimaryWeaponItem _x};
    if (_x in ((vestItems _unit)+(uniformItems _unit)+(backpackItems _unit)+(items _unit))) then {_unit removeItems _x};
} forEach GRLIB_blacklisted_from_arsenal;

[_unit] call F_correctLaserBatteries;
[_unit] call F_correctHEGL;