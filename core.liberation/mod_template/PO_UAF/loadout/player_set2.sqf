_unit = _this select 0;

//  "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "rhs_weap_ak74m";
_unit addPrimaryWeaponItem "rhs_acc_dtk";
_unit addPrimaryWeaponItem "rhs_acc_perst1ik";
_unit addPrimaryWeaponItem "rhs_30Rnd_545x39_7N10_AK";
_unit addWeapon "rhs_weap_rpg26";
_unit addSecondaryWeaponItem "rhs_rpg26_mag";
_unit addWeapon "rhs_weap_6p53";
_unit addHandgunItem "rhs_18rnd_9x21mm_7N28";

comment "Add containers";
_unit forceAddUniform "LOP_U_UKR_Fatigue_IzlomTTsKO";
_unit addVest "LOP_V_6B23_6Sh92_TTKO_OLV";
_unit addBackpack "LOP_B_FP_MG42_tub";

comment "Add binoculars";
_unit addWeapon "Binocular";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
_unit addItemToUniform "rhs_18rnd_9x21mm_7N28";
for "_i" from 1 to 2 do {_unit addItemToUniform "rhs_mag_rgd5";};
for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
for "_i" from 1 to 5 do {_unit addItemToVest "rhs_30Rnd_545x39_7N10_AK";};
_unit addItemToVest "rhs_mag_rgn";
for "_i" from 1 to 2 do {_unit addItemToVest "rhs_18rnd_9x21mm_7N28";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShellRed";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 3 do {_unit addItemToBackpack "rhs_30Rnd_545x39_7N10_AK";};
_unit addItemToBackpack "DemoCharge_Remote_Mag";
for "_i" from 1 to 2 do {_unit addItemToBackpack "SmokeShellRed";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "rhs_mag_rgd5";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "rhs_mag_an_m14_th3";};
_unit addHeadgear "PO_H_SSh68Helmet_wz93";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "rhs_radio_R169P1";
_unit linkItem "ItemGPS";
_unit linkItem "rhs_1PN138";

