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
_unit addWeapon "ffaa_armas_hkg36e";
_unit addPrimaryWeaponItem "ffaa_acc_puntero_ir";
_unit addPrimaryWeaponItem "ffaa_optic_g36_holo";
_unit addPrimaryWeaponItem "ffaa_556x45_g36";
_unit addWeapon "launch_I_Titan_F";
_unit addSecondaryWeaponItem "Titan_AA";

//  "Add containers";
_unit forceAddUniform "ffaa_brilat_CombatUniform_item_b";
_unit addVest "ffaa_brilat_chaleco_01_bs";
_unit addBackpack "ffaa_brilat_mochila_boscoso_municion";

//  "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_unit addItemToUniform "ffaa_556x45_g36";};
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellGreen";
for "_i" from 1 to 2 do {_unit addItemToVest "Chemlight_green";};
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellRed";
for "_i" from 1 to 2 do {_unit addItemToBackpack "Titan_AA";};
_unit addHeadgear "ffaa_brilat_casco_b";
_unit addGoggles "ffaa_glasses";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
