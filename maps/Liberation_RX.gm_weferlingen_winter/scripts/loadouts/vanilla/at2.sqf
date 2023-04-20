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
_unit addVest "gm_pl_army_vest_80_at_gry";
for "_i" from 1 to 8 do {_unit addItemToVest "gm_30rnd_9x19mm_b_dm51_mp5_blk";};

_unit addBackpack "gm_gc_army_backpack_80_at_str";
for "_i" from 1 to 4 do {_unit addItemToBackpack "gm_1rnd_40mm_heat_pg7v_rpg7";};

_unit addHeadgear "gm_ge_headgear_hat_80_gry";
_unit addWeapon "gm_mp5a3_blk";
_unit addWeapon "gm_rpg7_prp";
_unit linkItem "ItemMap";
_unit linkItem "gm_ge_army_conat2";