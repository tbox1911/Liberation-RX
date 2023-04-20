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
_unit forceAddUniform "LOP_U_SLA_Fatigue_01";
_unit addVest "LOP_V_6Sh92_OLV";

comment "Add weapons";
_unit addWeapon "rhs_weap_akm";
_unit addPrimaryWeaponItem "rhs_acc_dtkakm";
_unit addPrimaryWeaponItem "rhs_30Rnd_762x39mm";


comment "Add items to containers";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "rhs_30Rnd_762x39mm";
_unit addItemToUniform "rhs_mag_rgo";
_unit addItemToVest "FirstAidKit";
for "_i" from 1 to 3 do {_unit addItemToVest "rhs_30Rnd_762x39mm";};
_unit addItemToVest "rhs_mag_rdg2_white";
_unit addItemToVest "rhs_mag_rgd5";
_unit addItemToVest "rhs_mag_m7a3_cs";
_unit addHeadgear "LOP_H_SSh68Helmet_OLV";


comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
