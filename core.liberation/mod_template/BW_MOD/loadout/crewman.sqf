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
_unit addWeapon "BWA3_G36A3_tan";
_unit addPrimaryWeaponItem "BWA3_acc_VarioRay_irlaser";
_unit addPrimaryWeaponItem "BWA3_optic_ZO4x30_RSAS_brown";
_unit addPrimaryWeaponItem "BWA3_30Rnd_556x45_G36";
_unit addWeapon "BWA3_P8";
_unit addHandgunItem "BWA3_15Rnd_9x19_P8";

comment "Add containers";
_unit forceAddUniform "BWA3_Uniform_Tropen";
_unit addVest "BWA3_Vest_Rifleman_Tropen";

comment "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_unit addItemToUniform "BWA3_30Rnd_556x45_G36";};
for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
for "_i" from 1 to 4 do {_unit addItemToVest "BWA3_30Rnd_556x45_G36";};
for "_i" from 1 to 2 do {_unit addItemToVest "BWA3_15Rnd_9x19_P8";};
_unit addItemToVest "BWA3_DM51A1";
_unit addItemToVest "BWA3_DM25";
_unit addHeadgear "BWA3_OpsCore_Tropen";
_unit addGoggles "BWA3_G_Combat_orange";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "NVGoggles_OPFOR";
