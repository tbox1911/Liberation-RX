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
_unit addWeapon "R3F_HKUSP";
_unit addHandgunItem "R3F_LAMPE_SURB";
_unit addHandgunItem "R3F_15Rnd_9x19_HKUSP";

//  "Add containers";
_unit forceAddUniform "R3F_uniform_f1_DA";
_unit addVest "V_Rangemaster_belt";

//  "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 3 do {_unit addItemToVest "R3F_15Rnd_9x19_HKUSP";};
for "_i" from 1 to 2 do {_unit addItemToVest "R3F_Grenade_df_mag";};
_unit addHeadgear "R3F_casquette_off_DA";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
