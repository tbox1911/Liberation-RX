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
_unit addVest "gm_dk_army_vest_54_crew";
for "_i" from 1 to 8 do {_unit addItemToVest "gm_30rnd_9x19mm_b_dm51_mp5_blk";};

_unit addBackpack "gm_gc_army_backpack_80_at_str";
clearAllItemsFromBackpack _unit;
for "_i" from 1 to 2 do {_unit addItemToBackpack "gm_1Rnd_72mm_he_9m32m";};

_unit addHeadgear "gm_ge_headgear_hat_80_oli";
_unit addWeapon "gm_mp5sd3_blk";
_unit addWeapon "gm_9k32m_oli";
_unit addItemToBackpack "gm_1Rnd_72mm_he_9m32m";
_unit linkItem "ItemMap";
_unit linkItem "gm_ge_army_conat2";