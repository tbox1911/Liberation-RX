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

_unit addWeapon "arifle_SDAR_F";
_unit addPrimaryWeaponItem "20Rnd_556x45_UW_mag";

_unit forceAddUniform "U_B_Wetsuit";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 7 do {_unit addItemToUniform "20Rnd_556x45_UW_mag";};

_unit addVest "V_RebreatherB";
_unit addGoggles "G_B_Diving";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
