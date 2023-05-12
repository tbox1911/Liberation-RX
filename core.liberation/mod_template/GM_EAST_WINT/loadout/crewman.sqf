_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit addWeapon "gm_pm63_blk";
_unit addPrimaryWeaponItem "gm_15Rnd_9x18mm_B_pst_pm63_blk";

_unit forceAddUniform "gm_pl_army_uniform_soldier_80_moro";
_unit addVest "gm_pl_army_vest_80_crew_gry";

_unit addWeapon "gm_df7x40_blk";

_unit addItemToUniform "gm_gc_army_gauzeBandage";
_unit addItemToUniform "gm_gc_army_medkit";
_unit addItemToUniform "gm_pl_army_headgear_cap_80_moro";
_unit addItemToUniform "gm_gc_army_facewear_schm41m";
for "_i" from 1 to 5 do {_unit addItemToUniform "gm_15Rnd_9x18mm_B_pst_pm63_blk";};
for "_i" from 1 to 2 do {_unit addItemToVest "gm_handgrenade_frag_rgd5";};
_unit addHeadgear "gm_gc_army_headgear_crewhat_80_blk";

_unit linkItem "ItemMap";
_unit linkItem "gm_gc_compass_f73";
_unit linkItem "ItemRadio";