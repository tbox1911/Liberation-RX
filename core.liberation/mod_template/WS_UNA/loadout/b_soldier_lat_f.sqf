_unit = _this select 0;

removeUniform _unit;
removeGoggles _unit;
_unit forceAddUniform "U_lxWS_UN_Camo3";
_unit addVest "V_lxWS_UN_Vest_F";
_unit addHeadgear "lxWS_H_PASGT_goggles_UN_F";

_unit removeWeapon "launch_NLAW_F";
_unit addWeapon "launch_MRAWS_green_F";
_unit addSecondaryWeaponItem "MRAWS_HEAT_F";

clearAllItemsFromBackpack _unit;
for "_i" from 1 to 2 do {_unit addItemToBackpack "MRAWS_HEAT_F";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "MRAWS_HE_F";};