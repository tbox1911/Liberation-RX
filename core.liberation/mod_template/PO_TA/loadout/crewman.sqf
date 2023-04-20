_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeVest _unit;
removeUniform _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "LOP_U_TKA_Fatigue_02";
_unit addVest "LOP_V_6Sh92_WDL";


_unit addWeapon "rhs_weap_akms";
_unit addPrimaryWeaponItem "rhs_acc_dtkakm";
_unit addPrimaryWeaponItem "rhs_30Rnd_762x39mm";
_unit addWeapon "rhs_weap_6p53";
_unit addHandgunItem "rhs_18rnd_9x21mm_7N28";

_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "rhs_30Rnd_762x39mm";
for "_i" from 1 to 2 do {_unit addItemToUniform "rhs_18rnd_9x21mm_7N28";};
for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
for "_i" from 1 to 3 do {_unit addItemToVest "rhs_30Rnd_762x39mm";};
_unit addItemToVest "rhs_mag_rdg2_white";
_unit addItemToVest "rhs_mag_rgd5";
_unit addItemToVest "rhs_18rnd_9x21mm_7N28";
_unit addItemToVest "rhs_mag_rgo";
_unit addHeadgear "rhs_tsh4";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemRadio";
_unit linkItem "ItemWatch";
_unit linkItem "ItemGPS";