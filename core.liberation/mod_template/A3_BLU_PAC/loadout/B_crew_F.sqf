_unit = _this select 0;

//comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

//comment "Add weapons";
_unit addWeapon "hgun_PDW2000_F";
_unit addPrimaryWeaponItem "optic_Aco_smg";
_unit addPrimaryWeaponItem "30Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_khk_F";
_unit addHandgunItem "16Rnd_9x21_Mag";

//comment "Add containers";
_unit forceAddUniform "U_B_T_Soldier_F";
_unit addVest "V_PlateCarrier1_tna_F";

//comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
_unit addItemToUniform "Chemlight_green";
_unit addItemToUniform "16Rnd_9x21_Mag";
_unit addItemToUniform "30Rnd_9x21_Mag";
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
_unit addItemToVest "SmokeShellGreen";
for "_i" from 1 to 6 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 2 do {_unit addItemToVest "16Rnd_9x21_Mag";};
for "_i" from 1 to 4 do {_unit addItemToVest "30Rnd_9x21_Mag";};
_unit addHeadgear "H_HelmetB_tna_F";

//comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
