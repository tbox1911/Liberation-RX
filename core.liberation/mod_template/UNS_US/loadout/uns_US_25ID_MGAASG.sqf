// uns_US_25ID_MGAASG - AASoldier

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
_unit addWeapon "uns_m14";
_unit addPrimaryWeaponItem "uns_m14mag_T";
_unit addWeapon "uns_sa7";
_unit addSecondaryWeaponItem "uns_sa7mag";
_unit addWeapon "uns_MX991_m1911_base";
_unit addHandgunItem "uns_m1911mag";

comment "Add containers";
_unit forceAddUniform "UNS_ARMY_BDU_1stIDpv2";
_unit addVest "uns_simc_56_60";
_unit addBackpack "UNS_Alice_4";

comment "Add items to containers";
for "_i" from 1 to 5 do {_unit addItemToUniform "uns_m14mag_T";};
for "_i" from 1 to 3 do {_unit addItemToUniform "uns_m1911mag";};
for "_i" from 1 to 4 do {_unit addItemToVest "FirstAidKit";};
_unit addItemToVest "uns_m18red";
_unit addItemToVest "uns_m18Green";
for "_i" from 1 to 2 do {_unit addItemToVest "uns_m61gren";};
_unit addItemToVest "uns_kabar";
for "_i" from 1 to 2 do {_unit addItemToVest "uns_m308gren";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "FirstAidKit";};
_unit addItemToBackpack "uns_sa7mag";
_unit addHeadgear "uns_simc_m1_bitch_low_op";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";

comment "Set identity";
[_unit,"WhiteHead_14",""] call BIS_fnc_setIdentity;
