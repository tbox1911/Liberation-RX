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
_unit addWeapon "CUP_arifle_M16A4_Base";
_unit addPrimaryWeaponItem "CUP_acc_ANPEQ_15_Black";
_unit addPrimaryWeaponItem "CUP_optic_CompM2_low";
_unit addPrimaryWeaponItem "CUP_30Rnd_556x45_Stanag";
_unit addWeapon "launch_B_Titan_F";
_unit addSecondaryWeaponItem "Titan_AA";

//  "Add containers";
_unit forceAddUniform "CUP_U_B_USMC_MCCUU_des_gloves";
_unit addVest "CUP_V_B_Eagle_SPC_AT";
_unit addBackpack "CUP_B_AssaultPack_Coyote";

//  "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_unit addItemToUniform "CUP_30Rnd_556x45_Stanag";};
for "_i" from 1 to 2 do {_unit addItemToVest "CUP_HandGrenade_M67";};
_unit addItemToBackpack "Titan_AA";
_unit addHeadgear "CUP_H_LWHv2_MARPAT_des_comms_cov_fr";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "CUP_NVG_PVS7_Hide";