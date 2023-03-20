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
_unit addWeapon "BWA3_G36A3_tan";
_unit addPrimaryWeaponItem "BWA3_acc_VarioRay_irlaser";
_unit addPrimaryWeaponItem "BWA3_optic_ZO4x30_RSAS_brown";
_unit addPrimaryWeaponItem "BWA3_30Rnd_556x45_G36";
_unit addWeapon "BWA3_P8";
_unit addHandgunItem "BWA3_15Rnd_9x19_P8";

// "Add containers";
_unit forceAddUniform "BWA3_Uniform_Tropen";
_unit addVest "BWA3_Vest_Rifleman_Tropen";

// "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_unit addItemToUniform "BWA3_30Rnd_556x45_G36";};
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 4 do {_unit addItemToVest "BWA3_30Rnd_556x45_G36";};
for "_i" from 1 to 2 do {_unit addItemToVest "BWA3_15Rnd_9x19_P8";};
_unit addItemToVest "BWA3_DM51A1";
_unit addItemToVest "BWA3_DM25";
_unit addHeadgear "BWA3_OpsCore_Tropen";

// "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "BWA3_ItemNaviPad";
_unit linkItem "NVGoggles_OPFOR";

// "Set identity";
[_unit,"GreekHead_A3_02","male03eng"] call BIS_fnc_setIdentity;
