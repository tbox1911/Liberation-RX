_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit addWeapon "gm_mp2a1_blk";
_unit addPrimaryWeaponItem "gm_32Rnd_9x19mm_B_DM11_mp2_blk";

_unit forceAddUniform "gm_ge_army_uniform_crew_80_oli";
_unit addVest "gm_ge_army_vest_80_crew";

_unit addWeapon "gm_ferod16_oli";

_unit addItemToUniform "gm_ge_army_gauzeBandage";
_unit addItemToUniform "gm_ge_army_burnBandage";
_unit addItemToUniform "gm_ge_facewear_m65";
for "_i" from 1 to 3 do {_unit addItemToUniform "gm_32Rnd_9x19mm_B_DM11_mp2_blk";};
for "_i" from 1 to 2 do {_unit addItemToVest "gm_32Rnd_9x19mm_B_DM11_mp2_blk";};
for "_i" from 1 to 2 do {_unit addItemToVest "gm_handgrenade_frag_dm51a1";};
_unit addHeadgear "gm_ge_headgear_crewhat_80_blk";

_unit linkItem "ItemMap";
_unit linkItem "gm_ge_army_conat2";
_unit linkItem "ItemRadio";