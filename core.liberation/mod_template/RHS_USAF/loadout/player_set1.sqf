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
_unit addWeapon "rhsusf_weap_m9";
_unit addHandgunItem "rhsusf_mag_15Rnd_9x19_FMJ";

//  "Add containers";
_unit forceAddUniform "rhs_uniform_acu_ucp";
_unit addVest "rhsusf_iotv_ucp_Rifleman";

//  "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "SmokeShell";};
for "_i" from 1 to 2 do {_unit addItemToUniform "rhsusf_mag_15Rnd_9x19_FMJ";};
for "_i" from 1 to 2 do {_unit addItemToVest "rhsusf_mag_15Rnd_9x19_FMJ";};
_unit addHeadgear "rhsusf_patrolcap_ucp";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
