_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

sleep 0.5;

_unit addUniform "gm_ge_uniform_soldier_rolled_90_flk";
for "_i" from 1 to 2 do {_unit addItemToUniform "gm_gc_army_gauzeBandage";};
for "_i" from 1 to 2 do {_unit addItemToUniform "gm_handgrenade_frag_dm51";};
for "_i" from 1 to 3 do {_unit addItemToUniform "gm_8rnd_9x18mm_b_pst_pm_blk";};
_unit addVest "gm_ge_army_vest_80_rifleman";
for "_i" from 1 to 8 do {_unit addItemToVest "gm_30rnd_762x39mm_b_m43_ak47_blk";};

_unit addHeadgear "gm_ge_headgear_hat_80_gry";
_unit addWeapon "gm_akm_wud";
_unit addWeapon "gm_pm_blk";
_unit linkItem "ItemMap";
_unit linkItem "gm_ge_army_conat2";