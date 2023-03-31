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
_unit addWeapon "cwr3_hgun_aps";
_unit addHandgunItem "cwr3_20rnd_9x18_aps_m";

// "Add containers";
_unit forceAddUniform "cwr3_b_uniform_m81_woodland_early";
_unit addVest "cwr3_b_vest_alice";

// "Add items to containers";
_unit addItemToUniform "ItemRadio";
_unit addItemToUniform "ItemWatch";
_unit addItemToUniform "ItemMap";
_unit addItemToUniform "ItemCompass";
for "_i" from 1 to 2 do {_unit addItemToUniform "cwr3_20rnd_9x18_aps_m";};
for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToVest "CUP_HandGrenade_M67";};
_unit addItemToVest "cwr3_20rnd_9x18_aps_m";
_unit addHeadgear "cwr3_b_headgear_m1_woodland_army_early";

// "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";

// "Set identity";
[_unit,"GreekHead_A3_02","male01eng"] call BIS_fnc_setIdentity;
