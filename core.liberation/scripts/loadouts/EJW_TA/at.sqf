_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

sleep 0.5;

_unit addUniform "gm_ge_uniform_soldier_90_flk";
for "_i" from 1 to 2 do {_unit addItemToUniform "gm_gc_army_gauzeBandage";};
for "_i" from 1 to 2 do {_unit addItemToUniform "gm_handgrenade_frag_dm51";};
for "_i" from 1 to 3 do {_unit addItemToUniform "gm_30rnd_9x19mm_b_dm51_mp5_blk";};

_unit addVest "gm_pl_army_vest_80_at_gry";
for "_i" from 1 to 5 do {_unit addItemToVest "gm_30rnd_9x19mm_b_dm51_mp5_blk";};
for "_i" from 1 to 5 do {_unit addItemToVest "gm_1Rnd_66mm_heat_m72a3";};

_unit addHeadgear "gm_ge_headgear_hat_80_m62_oli";
_unit addWeapon "gm_mp5sd2_blk";
_unit addWeapon "gm_m72a3_oli";
_unit linkItem "ItemMap";
_unit linkItem "gm_ge_army_conat2";