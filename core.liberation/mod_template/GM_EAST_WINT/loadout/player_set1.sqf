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
_unit addWeapon "gm_pm_blk";
_unit addHandgunItem "gm_8Rnd_9x18mm_B_pst_pm_blk";

//  "Add containers";
_unit forceAddUniform "gm_pl_army_uniform_soldier_80_win";
_unit addVest "gm_pl_army_vest_80_rig_gry";

_unit addWeapon "gm_ferod16_win";

//  "Add items to containers";
for "_i" from 1 to 4 do {_unit addItemToUniform "gm_gc_army_medkit";};
for "_i" from 1 to 4 do {_unit addItemToUniform "gm_8Rnd_9x18mm_B_pst_pm_blk";};
_unit addItemToUniform "gm_handgrenade_frag_rgd5";
_unit addItemToUniform "gm_smokeshell_wht_gc";
_unit addHeadgear "gm_ge_headgear_hat_80_gry";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "gm_gc_compass_f73";
_unit linkItem "gm_watch_kosei_80";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
