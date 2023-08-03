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
_unit addWeapon "LIB_K98";
_unit addPrimaryWeaponItem "LIB_5Rnd_792x57";
_unit addPrimaryWeaponItem "LIB_5rnd_MUZZLE_FAKEMAG";
_unit addWeapon "LIB_P08";
_unit addHandgunItem "LIB_8Rnd_9x19_P08";

comment "Add containers";
_unit forceAddUniform "U_LIB_GER_Recruit_w";
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
for "_i" from 1 to 5 do {_unit addItemToVest "LIB_5Rnd_792x57";};
for "_i" from 1 to 2 do {_unit addItemToVest "LIB_8Rnd_9x19_P08";};
_unit addItemToVest "LIB_Shg24";
_unit addItemToVest "LIB_US_M18";
_unit addHeadgear "H_LIB_GER_Cap_w";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "LIB_GER_ItemCompass_deg";
_unit linkItem "LIB_GER_ItemWatch";

comment "Set identity";
[_unit,"LIB_WhiteHead_05_Dirt","male01ger"] call BIS_fnc_setIdentity;
