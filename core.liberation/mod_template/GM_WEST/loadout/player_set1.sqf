_unit = _this select 0;

//  "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

//  "Add weapons";
_unit addWeapon "gm_p1_blk";
_unit addHandgunItem "gm_8Rnd_9x19mm_B_DM51_p1_blk";

//  "Add containers";
_unit forceAddUniform "gm_ge_army_uniform_soldier_80_ols";
_unit addVest "gm_ge_army_vest_80_officer";

_unit addWeapon "gm_ferod16_oli";

//  "Add items to containers";
for "_i" from 1 to 4 do {_unit addItemToUniform "gm_ge_army_burnBandage";};
for "_i" from 1 to 4 do {_unit addItemToUniform "gm_8Rnd_9x19mm_B_DM51_p1_blk";};
_unit addItemToUniform "gm_handgrenade_frag_dm51";
_unit addItemToUniform "gm_smokeshell_wht_gc";
_unit addHeadgear "gm_ge_headgear_hat_80_oli";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "gm_ge_army_conat2";
_unit linkItem "gm_watch_kosei_80";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";

// "Set identity";
[_unit,"GreekHead_A3_02","male03eng"] call BIS_fnc_setIdentity;

