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
_unit addWeapon "hgun_Pistol_heavy_01_green_F";
_unit addHandgunItem "optic_MRD_black";
_unit addHandgunItem "11Rnd_45ACP_Mag";

//  "Add containers";
_unit forceAddUniform "U_O_CombatUniform_ocamo";
_unit addVest "V_Rangemaster_belt";

//  "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "SmokeShell";};
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "11Rnd_45ACP_Mag";};
_unit addHeadgear "H_Booniehat_khk";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
