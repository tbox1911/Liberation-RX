_unit = _this select 0;

// "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

// "Add weapons";
_unit addWeapon "CUP_smg_M3A1";
_unit addPrimaryWeaponItem "CUP_30Rnd_45ACP_M3A1_M";

// "Add containers";
_unit forceAddUniform "cwr3_b_uniform_m81_woodland_early";
_unit addVest "cwr3_b_vest_alice_crew";

// "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "CUP_30Rnd_45ACP_M3A1_M";};
_unit addItemToVest "CUP_30Rnd_45ACP_M3A1_M";
_unit addHeadgear "cwr3_b_headgear_cap_m81_woodland_early";

// "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
