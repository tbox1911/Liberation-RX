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

comment "Add containers";
_unit forceAddUniform "U_LIB_GER_Soldier_camo5";
_unit addVest "V_LIB_GER_VestKar98";
_unit addBackpack "B_LIB_GER_A_frame";

comment "Add items to containers";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "LIB_ACC_K98_Bayo";
for "_i" from 1 to 4 do {_unit addItemToUniform "LIB_5Rnd_792x57";};
for "_i" from 1 to 12 do {_unit addItemToVest "LIB_5Rnd_792x57";};
for "_i" from 1 to 2 do {_unit addItemToVest "LIB_Shg24";};
_unit addItemToVest "LIB_M39";
_unit addHeadgear "H_LIB_GER_HelmetCamo";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "LIB_GER_ItemCompass_deg";
_unit linkItem "LIB_GER_ItemWatch";

comment "Set identity";
[_unit,"WhiteHead_06","male02ger"] call BIS_fnc_setIdentity;
