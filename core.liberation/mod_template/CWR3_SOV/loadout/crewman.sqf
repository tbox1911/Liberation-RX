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
_unit addWeapon "CUP_arifle_AKS74";
_unit addPrimaryWeaponItem "CUP_30Rnd_545x39_AK_M";

comment "Add containers";
_unit forceAddUniform "cwr3_o_uniform_m1969";
_unit addVest "cwr3_o_vest_harness_ak74";

comment "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_unit addItemToUniform "CUP_30Rnd_545x39_AK_M";};
_unit addHeadgear "cwr3_o_headgear_sidecap_m1973_field";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
