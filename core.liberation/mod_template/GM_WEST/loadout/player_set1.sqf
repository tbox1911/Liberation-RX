_unit = _this select 0;

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "gm_p1_blk";
_unit addHandgunItem "gm_8Rnd_9x19mm_B_DM11_p1_blk";

comment "Add containers";
_unit forceAddUniform "gm_ge_army_uniform_soldier_80_oli";
_unit addVest "gm_ge_army_vest_80_officer";

comment "Add binoculars";
_unit addWeapon "gm_ferod16_oli";

comment "Add items to containers";
_unit addItemToUniform "gm_ge_army_gauzeBandage";
_unit addItemToUniform "gm_ge_army_burnBandage";
_unit addItemToUniform "gm_ge_facewear_m65";
_unit addItemToUniform "gm_ge_headgear_hat_80_m62_oli";
_unit addItemToUniform "gm_8Rnd_9x19mm_B_DM11_p1_blk";
_unit addHeadgear "gm_ge_headgear_m62_net";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "gm_ge_army_conat2";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
