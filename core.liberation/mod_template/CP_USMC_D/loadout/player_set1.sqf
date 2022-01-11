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
_unit addWeapon "CUP_hgun_M9A1";
_unit addHandgunItem "CUP_acc_MLPLS_Laser";
_unit addHandgunItem "CUP_15Rnd_9x19_M9";

//  "Add containers";
_unit forceAddUniform "CUP_U_B_USMC_MCCUU_des_gloves";
_unit addVest "V_BandollierB_cbr";

//  "Add binoculars";
_unit addWeapon "Binocular";

//  "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 4 do {_unit addItemToUniform "CUP_15Rnd_9x19_M9";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShellRed";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShellGreen";};
for "_i" from 1 to 2 do {_unit addItemToVest "CUP_HandGrenade_M67";};
_unit addHeadgear "CUP_H_USMC_BOONIE_PRR_DES";
_unit addGoggles "CUP_G_Oakleys_Embr";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
