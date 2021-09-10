_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit addWeapon "gm_pm63_blk";
_unit addPrimaryWeaponItem "gm_25Rnd_9x18mm_b_pst_pm63_blk";
_unit addWeapon "gm_pm_blk";
_unit addHandgunItem "gm_8rnd_9x18mm_b_pst_pm_blk";

_unit forceAddUniform "gm_gc_civ_uniform_man_04_80_blu";
for "_i" from 1 to 2 do {_unit addItemToUniform "gm_gc_army_gauzeBandage";};
for "_i" from 1 to 2 do {_unit addItemToUniform "gm_handgrenade_frag_dm51";};
for "_i" from 1 to 3 do {_unit addItemToUniform "gm_8rnd_9x18mm_b_pst_pm_blk";};

_unit addVest "gm_dk_army_vest_54_crew";
for "_i" from 1 to 8 do {_unit addItemToVest "gm_25Rnd_9x18mm_b_pst_pm63_blk";};

_unit addHeadgear "gm_gc_army_headgear_crewhat_80_blk";
_unit linkItem "ItemMap";
_unit linkItem "gm_ge_army_conat2";