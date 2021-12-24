_unit = _this select 0;

//  "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

//  "Add weapons";
_unit addWeapon "R3F_Famas_surb_DES";
_unit addPrimaryWeaponItem "R3F_30Rnd_556x45_FAMAS";
_unit addWeapon "R3F_HKUSP";
_unit addHandgunItem "R3F_LAMPE_SURB";
_unit addHandgunItem "R3F_15Rnd_9x19_HKUSP";

//  "Add containers";
_unit forceAddUniform "R3F_uniform_f1";
_unit addVest "R3F_veste_off";

//  "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 3 do {_unit addItemToVest "R3F_30Rnd_556x45_FAMAS";};
for "_i" from 1 to 2 do {_unit addItemToVest "R3F_15Rnd_9x19_HKUSP";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShellGreen";};
_unit addHeadgear "R3F_casque_equipage";
_unit addGoggles "R3F_lunettes_ESS";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";