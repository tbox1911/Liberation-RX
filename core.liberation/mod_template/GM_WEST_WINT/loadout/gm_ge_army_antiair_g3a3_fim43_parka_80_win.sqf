_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;


_unit addWeapon "gm_g3a3_oli";
_unit addPrimaryWeaponItem "gm_20Rnd_762x51mm_B_DM41_g3_blk";
_unit addWeapon "launch_I_Titan_F";
_unit addSecondaryWeaponItem "Titan_AA";


_unit forceAddUniform "gm_ge_army_uniform_soldier_parka_80_win";
_unit addVest "gm_ge_army_vest_80_rifleman";
_unit addBackpack "gm_pl_army_backpack_at_80_gry";


_unit addItemToUniform "gm_ge_army_gauzeBandage";
_unit addItemToUniform "gm_ge_army_burnBandage";
_unit addItemToUniform "gm_ge_facewear_m65";
_unit addItemToUniform "gm_ge_headgear_hat_80_m62_oli";
for "_i" from 1 to 7 do {_unit addItemToVest "gm_20Rnd_762x51mm_B_DM41_g3_blk";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "Titan_AA";};
_unit addHeadgear "gm_ge_headgear_m62_cover_win";


_unit linkItem "ItemMap";
_unit linkItem "gm_ge_army_conat2";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";