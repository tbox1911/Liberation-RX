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
_unit addWeapon "CUP_arifle_M4A1";
_unit addPrimaryWeaponItem "CUP_30Rnd_556x45_Stanag";
_unit addWeapon "CUP_hgun_Colt1911";
_unit addHandgunItem "CUP_7Rnd_45ACP_1911";

//  "Add containers";
_unit forceAddUniform "CUP_U_B_USMC_MCCUU_des_gloves";
_unit addVest "CUP_V_B_Eagle_SPC_Crew";

//  "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 3 do {_unit addItemToUniform "CUP_30Rnd_556x45_Stanag";};
for "_i" from 1 to 2 do {_unit addItemToVest "CUP_7Rnd_45ACP_1911";};
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellRed";
_unit addHeadgear "CUP_H_CVC";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "CUP_NVG_PVS7_Hide";