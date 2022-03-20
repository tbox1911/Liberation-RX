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
_unit addWeapon "BWA3_P8";
_unit addHandgunItem "BWA3_15Rnd_9x19_P8";

comment "Add containers";
_unit forceAddUniform "BWA3_Uniform_Tropen";
_unit addVest "BWA3_Vest_Rifleman_Tropen";

comment "Add items to containers";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "BWA3_15Rnd_9x19_P8";
for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToVest "BWA3_15Rnd_9x19_P8";};
_unit addItemToVest "BWA3_DM51A1";
_unit addItemToVest "BWA3_DM25";
_unit addHeadgear "BWA3_OpsCore_Tropen";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "BWA3_ItemNaviPad";
