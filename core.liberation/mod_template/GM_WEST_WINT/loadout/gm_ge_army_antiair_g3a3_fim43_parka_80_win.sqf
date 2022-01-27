removeAllWeapons this;
removeAllItems this;
removeAllAssignedItems this;
removeUniform this;
removeVest this;
removeBackpack this;
removeHeadgear this;
removeGoggles this;


this addWeapon "gm_g3a3_oli";
this addPrimaryWeaponItem "gm_20Rnd_762x51mm_B_DM41_g3_blk";
this addWeapon "launch_I_Titan_F";
this addSecondaryWeaponItem "Titan_AA";


this forceAddUniform "gm_ge_army_uniform_soldier_parka_80_win";
this addVest "gm_ge_army_vest_80_rifleman";
this addBackpack "gm_pl_army_backpack_at_80_gry";


this addItemToUniform "gm_ge_army_gauzeBandage";
this addItemToUniform "gm_ge_army_burnBandage";
this addItemToUniform "gm_ge_facewear_m65";
this addItemToUniform "gm_ge_headgear_hat_80_m62_oli";
for "_i" from 1 to 7 do {this addItemToVest "gm_20Rnd_762x51mm_B_DM41_g3_blk";};
for "_i" from 1 to 2 do {this addItemToBackpack "Titan_AA";};
this addHeadgear "gm_ge_headgear_m62_cover_win";


this linkItem "ItemMap";
this linkItem "gm_ge_army_conat2";
this linkItem "ItemWatch";
this linkItem "ItemRadio";