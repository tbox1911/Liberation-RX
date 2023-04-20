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
_unit addWeapon "CUP_hgun_TT";
_unit addHandgunItem "CUP_8Rnd_762x25_TT";

//  "Add containers";
_unit forceAddUniform "CUP_U_O_RUS_EMR_2";
_unit addVest "CUP_V_B_ALICE";

//  "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "SmokeShell";};
for "_i" from 1 to 2 do {_unit addItemToUniform "CUP_8Rnd_762x25_TT";};
for "_i" from 1 to 2 do {_unit addItemToVest "CUP_8Rnd_762x25_TT";};
_unit addHeadgear "CUP_H_CZ_Hat02";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
