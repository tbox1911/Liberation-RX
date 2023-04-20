_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

sleep 0.5;

_unit addUniform "gm_gc_civ_uniform_man_04_80_blu";
for "_i" from 1 to 2 do {_unit addItemToUniform "gm_gc_army_gauzeBandage";};
for "_i" from 1 to 2 do {_unit addItemToUniform "gm_handgrenade_frag_dm51";};
for "_i" from 1 to 3 do {_unit addItemToUniform "gm_8rnd_9x18mm_b_pst_pm_blk";};
for "_i" from 1 to 2 do {_unit addItemToUniform "SmokeShell";};
_unit addItemToUniform "gm_100rnd_762x54mm_b_t_t46_pk_grn";

_unit addVest "gm_ge_army_vest_80_machinegunner";
for "_i" from 1 to 2 do {_unit addItemToVest "gm_100rnd_762x54mm_b_t_t46_pk_grn";};

_unit addHeadgear "gm_ge_headgear_hat_80_gry";
_unit addWeapon "gm_hmgpkm_prp";
_unit addWeapon "gm_pm_blk";
_unit linkItem "ItemMap";
_unit linkItem "gm_ge_army_conat2";