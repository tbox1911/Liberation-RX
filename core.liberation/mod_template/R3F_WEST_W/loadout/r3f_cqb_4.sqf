_unit = _this select 0;

// "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

// "Add weapons";
_unit addWeapon "R3F_HK417L";
_unit addPrimaryWeaponItem "R3F_J8";
_unit addWeapon "R3F_G17";
_unit addHandgunItem "R3F_17Rnd_9x19_G17";

// "Add containers";
_unit forceAddUniform "R3F_uniform_CQB";
_unit addVest "R3F_veste_CQB";

// "Add items to containers";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "R3F_17Rnd_9x19_G17";
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 6 do {_unit addItemToVest "R3F_20Rnd_762x51_HK417";};
_unit addHeadgear "R3F_casqueFS_noir";
_unit addGoggles "R3F_cagoule_noire";

// "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
