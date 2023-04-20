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
_unit addWeapon "CUP_arifle_L85A2_GL";
_unit addPrimaryWeaponItem "CUP_acc_LLM";
_unit addPrimaryWeaponItem "CUP_optic_Elcan_reflex";
_unit addPrimaryWeaponItem "CUP_30Rnd_556x45_Stanag_L85";
_unit addWeapon "CUP_hgun_Glock17_blk";
_unit addHandgunItem "CUP_17Rnd_9x19_glock17";

//  "Add containers";
_unit forceAddUniform "CUP_U_B_BAF_DDPM_UBACSLONG";
_unit addVest "CUP_V_B_BAF_DDPM_Osprey_Mk3_Officer";

//  "Add items to containers";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "CUP_NVG_HMNVS";
for "_i" from 1 to 2 do {_unit addItemToUniform "CUP_17Rnd_9x19_glock17";};
_unit addItemToUniform "B_IR_Grenade";
for "_i" from 1 to 7 do {_unit addItemToVest "CUP_30Rnd_556x45_Stanag_L85";};
for "_i" from 1 to 9 do {_unit addItemToVest "CUP_1Rnd_HE_M203";};
_unit addItemToVest "UGL_FlareCIR_F";
_unit addItemToVest "CUP_1Rnd_SmokeGreen_M203";
_unit addItemToVest "CUP_1Rnd_SmokeRed_M203";
for "_i" from 1 to 3 do {_unit addItemToVest "CUP_1Rnd_Smoke_M203";};
for "_i" from 1 to 2 do {_unit addItemToVest "CUP_1Rnd_StarFlare_White_M203";};
for "_i" from 1 to 2 do {_unit addItemToVest "CUP_HandGrenade_L109A2_HE";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
_unit addHeadgear "CUP_H_BAF_PARA_PRROVER_BERET";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";