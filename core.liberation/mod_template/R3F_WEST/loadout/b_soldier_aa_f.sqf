_unit = _this select 0;

removeUniform _unit;
_unit addGoggles "R3F_lunettes_X800";
_unit removeWeapon "launch_I_Titan_short_F";
_unit addWeapon "R3F_STINGER";
_unit addSecondaryWeaponItem "R3F_STINGER_mag";

clearAllItemsFromBackpack _unit;
for "_i" from 1 to 2 do {_unit addItemToBackpack "R3F_STINGER_mag";};
//_unit addWeapon "Rangefinder";
