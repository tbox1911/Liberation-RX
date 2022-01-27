_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;


_unit addWeapon "gm_akm_wud";
_unit addPrimaryWeaponItem "gm_30Rnd_762x39mm_B_M43_ak47_blk";
_unit addWeapon "launch_I_Titan_F";
_unit addSecondaryWeaponItem "Titan_AA";


_unit forceAddUniform "gm_pl_army_uniform_soldier_80_win";
_unit addVest "gm_pl_army_vest_80_rifleman_gry";
_unit addBackpack "gm_pl_army_backpack_at_80_gry";


_unit addItemToUniform "gm_gc_army_gauzeBandage";
_unit addItemToUniform "gm_gc_army_medkit";
_unit addItemToUniform "gm_pl_army_headgear_cap_80_moro";
_unit addItemToUniform "gm_gc_army_facewear_schm41m";
for "_i" from 1 to 7 do {_unit addItemToVest "gm_30Rnd_762x39mm_B_M43_ak47_blk";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "Titan_AA";};
_unit addHeadgear "gm_pl_headgear_wz67_cover_win";
_unit addGoggles "gm_gc_army_facewear_dustglasses";


_unit linkItem "ItemMap";
_unit linkItem "gm_gc_compass_f73";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";