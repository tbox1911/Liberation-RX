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
_unit addWeapon "LIB_K98_GW";
_unit addPrimaryWeaponItem "LIB_ACC_GW_SB_Empty";
_unit addPrimaryWeaponItem "LIB_5Rnd_792x57";
_unit addPrimaryWeaponItem "LIB_1Rnd_G_SPRGR_30";
_unit addWeapon "LIB_P08";
_unit addHandgunItem "LIB_8Rnd_9x19_P08";

comment "Add containers";
_unit forceAddUniform "U_LIB_GER_Soldier_camo_w";
_unit addVest "V_LIB_GER_VestKar98";
_unit addBackpack "B_LIB_GER_A_frame";

comment "Add binoculars";
_unit addWeapon "LIB_Binocular_GER";

comment "Add items to containers";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "LIB_ACC_K98_Bayo";
for "_i" from 1 to 4 do {_unit addItemToUniform "LIB_5Rnd_792x57";};
_unit addItemToUniform "LIB_8Rnd_9x19_P08";
_unit addItemToVest "FirstAidKit";
_unit addItemToVest "LIB_1Rnd_G_PZGR_30";
_unit addItemToVest "LIB_1Rnd_G_PZGR_40";
for "_i" from 1 to 5 do {_unit addItemToVest "LIB_5Rnd_792x57";};
for "_i" from 1 to 2 do {_unit addItemToVest "LIB_8Rnd_9x19_P08";};
_unit addItemToVest "LIB_Shg24";
_unit addItemToVest "LIB_US_M18";
for "_i" from 1 to 3 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 6 do {_unit addItemToBackpack "LIB_5Rnd_792x57";};
_unit addHeadgear "H_LIB_GER_HelmetCamo_w";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "LIB_GER_ItemCompass_deg";
_unit linkItem "LIB_GER_ItemWatch";

comment "Set identity";
[_unit,"WhiteHead_18","male02ger"] call BIS_fnc_setIdentity;

