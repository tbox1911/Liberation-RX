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

//  "Add weapons";
_unit addWeapon "rhs_weap_makarov_pm";
_unit addHandgunItem "rhs_mag_9x18_8_57N181S";

//  "Add containers";
_unit forceAddUniform "rhs_uniform_vkpo_alt";
_unit addVest "rhs_vest_pistol_holster";

//  "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "SmokeShell";};
for "_i" from 1 to 2 do {_unit addItemToUniform "rhs_mag_9x18_8_57N181S";};
for "_i" from 1 to 2 do {_unit addItemToVest "rhs_mag_9x18_8_57N181S";};
_unit addHeadgear "rhs_vkpo_cap";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";

// "Set identity";
//[_unit,"GreekHead_A3_02","male01eng"] call BIS_fnc_setIdentity;
