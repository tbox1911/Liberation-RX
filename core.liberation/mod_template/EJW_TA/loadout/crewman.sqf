_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit addWeapon "ej_akm";
_unit addPrimaryWeaponItem "AKM_mag";

_unit forceAddUniform "U_Afghan01";
_unit addVest "V_RusVest";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do { _unit addItemToUniform "HandGrenade";};
for "_i" from 1 to 7 do { _unit addItemToVest "AKM_mag";};

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemRadio";
