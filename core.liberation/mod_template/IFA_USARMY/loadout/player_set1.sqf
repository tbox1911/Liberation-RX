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
_unit addWeapon "LIB_Colt_M1911";
_unit addHandgunItem "LIB_7Rnd_45ACP";

comment "Add containers";
_unit forceAddUniform "U_LIB_US_Private_1st";
_unit addVest "V_LIB_US_Vest_Carbine";
_unit addBackpack "B_LIB_US_Backpack";

comment "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "LIB_7Rnd_45ACP";};
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToVest "LIB_US_Mk_2";};
_unit addItemToVest "LIB_7Rnd_45ACP";
_unit addItemToVest "LIB_F1";
_unit addHeadgear "H_LIB_US_Helmet";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";

comment "Set identity";
[_unit,"LIB_WhiteHead_13_Dirt","male07eng"] call BIS_fnc_setIdentity;
