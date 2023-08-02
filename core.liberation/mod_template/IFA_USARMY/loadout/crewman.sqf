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
_unit addWeapon "LIB_M1_Carbine";
_unit addPrimaryWeaponItem "LIB_15Rnd_762x33";

comment "Add containers";
_unit forceAddUniform "U_LIB_US_Private";
_unit addVest "V_LIB_US_Vest_Carbine";

comment "Add binoculars";
_unit addWeapon "LIB_Binocular_US";

comment "Add items to containers";
_unit addItemToUniform "LIB_ACC_M1_Bayo";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "LIB_15Rnd_762x33";};
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 5 do {_unit addItemToVest "LIB_15Rnd_762x33";};
for "_i" from 1 to 2 do {_unit addItemToVest "LIB_F1";};
_unit addHeadgear "H_LIB_US_Helmet";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";

comment "Set identity";
[_unit,"LIB_WhiteHead_02_Dirt","male03eng"] call BIS_fnc_setIdentity;
