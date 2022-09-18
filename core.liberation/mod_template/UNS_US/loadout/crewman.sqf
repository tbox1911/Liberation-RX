_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "uns_xm177e1";
_unit addPrimaryWeaponItem "uns_20Rnd_556x45_Stanag";
_unit addWeapon "uns_m1911";
_unit addHandgunItem "uns_m1911mag";

comment "Add containers";
_unit forceAddUniform "UNS_ARMY_BDU_1stIDpv1";
_unit addVest "uns_simc_56";
_unit addBackpack "uns_simc_US_Bandoleer_556_3";

comment "Add binoculars";
_unit addWeapon "uns_binocular_navy";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 3 do {_unit addItemToUniform "uns_m1911mag";};
for "_i" from 1 to 2 do {_unit addItemToUniform "uns_m61gren";};
_unit addItemToUniform "uns_20Rnd_556x45_Stanag";
for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToVest "uns_m61gren";};
_unit addItemToVest "uns_kabar";
_unit addItemToVest "uns_m1911mag";
_unit addItemToVest "uns_m308gren";
_unit addItemToVest "uns_m14gren";
for "_i" from 1 to 2 do {_unit addItemToVest "uns_m67gren";};
_unit addItemToBackpack "FirstAidKit";
for "_i" from 1 to 4 do {_unit addItemToBackpack "uns_30Rnd_556x45_Stanag_T";};
_unit addHeadgear "uns_simc_m1_bitch_op";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";

comment "Set identity";
[_unit,"WhiteHead_06",""] call BIS_fnc_setIdentity;
