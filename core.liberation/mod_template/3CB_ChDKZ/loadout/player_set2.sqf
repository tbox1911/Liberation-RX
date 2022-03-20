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
_unit addWeapon "rhs_weap_ak74n";
_unit addPrimaryWeaponItem "rhs_acc_dtk1983";
_unit addPrimaryWeaponItem "rhs_30Rnd_545x39_7N6_AK";

comment "Add containers";
_unit forceAddUniform "UK3CB_CHD_O_U_CombatUniform_01";
_unit addVest "rhsgref_chicom_m88";
_unit addBackpack "UK3CB_CHD_O_B_Sidor_RIF_FLORA";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "rhs_mag_m18_yellow";};
for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
for "_i" from 1 to 6 do {_unit addItemToVest "rhs_30Rnd_545x39_7N6M_AK";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "FirstAidKit";};
_unit addItemToBackpack "rhsusf_m112_mag";
for "_i" from 1 to 2 do {_unit addItemToBackpack "rhs_mag_m18_red";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "rhs_mag_an_m14_th3";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "rhs_mag_rgd5";};
_unit addHeadgear "UK3CB_H_Beanie_02_Camo";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";