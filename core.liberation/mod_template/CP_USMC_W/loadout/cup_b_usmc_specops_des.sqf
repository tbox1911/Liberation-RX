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
_unit addWeapon "CUP_arifle_M4A3_black";
_unit addPrimaryWeaponItem "CUP_muzzle_snds_M16";
_unit addPrimaryWeaponItem "CUP_acc_ANPEQ_15_Black";
_unit addPrimaryWeaponItem "CUP_optic_AIMM_COMPM4_BLK";
_unit addPrimaryWeaponItem "CUP_30Rnd_556x45_Stanag";
_unit addWeapon "CUP_hgun_M9A1";
_unit addHandgunItem "CUP_muzzle_snds_M9";
_unit addHandgunItem "CUP_acc_MLPLS_Laser";
_unit addHandgunItem "CUP_15Rnd_9x19_M9";

//  "Add containers";
_unit forceAddUniform "CUP_I_B_PMC_Unit_24";
_unit addVest "CUP_V_PMC_IOTV_Black_TL";

//  "Add binoculars";
_unit addMagazine "Laserbatteries";
_unit addWeapon "CUP_SOFLAM";

//  "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 3 do {_unit addItemToUniform "CUP_15Rnd_9x19_M9";};
for "_i" from 1 to 2 do {_unit addItemToUniform "CUP_HandGrenade_M67";};
_unit addItemToUniform "SmokeShell";
for "_i" from 1 to 8 do {_unit addItemToVest "CUP_30Rnd_556x45_Stanag_L85_Tracer_Green";};
_unit addItemToVest "SmokeShellRed";
_unit addItemToVest "SmokeShellGreen";
_unit addHeadgear "CUP_H_USArmy_Helmet_ECH1_Black";
_unit addGoggles "CUP_G_PMC_Facewrap_Black_Glasses_Dark_Headset";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "CUP_NVG_PVS15_black";