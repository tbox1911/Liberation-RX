_unit = _this select 0;

_unit addWeapon "launch_MRAWS_green_F";
_unit addSecondaryWeaponItem "MRAWS_HEAT_F";
_unit addBackpack "B_AssaultPack_blk";
for "_i" from 1 to 2 do {_unit addItemToBackpack "MRAWS_HEAT_F";};
