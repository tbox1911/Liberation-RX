_unit = __unit select 0;

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
_unit addWeapon "ffaa_armas_hkmp510a3";
_unit addPrimaryWeaponItem "acc_flashlight";
_unit addPrimaryWeaponItem "ffaa_optic_holografico";
_unit addPrimaryWeaponItem "ffaa_9x19_mp5";
_unit addWeapon "launch_B_Titan_olive_F";
_unit addSecondaryWeaponItem "Titan_AA";
_unit addWeapon "ffaa_armas_usp";
_unit addHandgunItem "muzzle_snds_L";
_unit addHandgunItem "ffaa_9x19_pistola";

//  "Add containers";
_unit forceAddUniform "ffaa_brilat_CombatUniform_item_bk";
_unit addVest "ffaa_brilat_chaleco_06_bk";

//   "Add binoculars";
_unit addWeapon "Binocular";

//   "Add items to containers";
_unit addItemToUniform "ffaa_nvgoggles";
_unit addItemToUniform "ffaa_9x19_mp5";
_unit addItemToUniform "SmokeShell";
for "_i" from 1 to 4 do {_unit addItemToVest "ffaa_9x19_mp5";};
_unit addItemToVest "ffaa_9x19_pistola";
for "_i" from 1 to 2 do {_unit addItemToVest "ffaa_granada_alhambra";};
_unit addItemToVest "SmokeShell";
_unit addHeadgear "ffaa_moe_casco_02_3_bk";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";