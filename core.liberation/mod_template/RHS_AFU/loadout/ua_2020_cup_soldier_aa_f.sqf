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
_unit addWeapon "Ltf_EFT_uk_1_rvg_74s_fh";
_unit addPrimaryWeaponItem "rhs_acc_1p87";
_unit addPrimaryWeaponItem "DTKWORN_F";
_unit addPrimaryWeaponItem "30Rnd_545x39_Mag_F";

_unit addWeapon "rhs_weap_igla";
_unit addSecondaryWeaponItem "rhs_mag_9k38_rocket";

_unit addWeapon "B_Patrol_Soldier_Pistol_F";
_unit addHandgunItem "muzzle_snds_acp";
_unit addHandgunItem "optic_MRD";
_unit addHandgunItem "11Rnd_45ACP_Mag";

//  "Add containers";
_unit forceAddUniform "Inf02";
_unit addVest "Vest02r";
_unit addBackpack "BackPack01";

//  "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
_unit addItemToUniform "SmokeShell";
_unit addItemToUniform "SmokeShellGreen";

for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 6 do {_unit addItemToVest "30Rnd_545x39_Mag_F";};
_unit addItemToVest "SmokeShellRed";


_unit addItemToBackpack "MineDetector";
for "_i" from 1 to 3 do {_unit addItemToUniform "rhs_mag_m67";};
for "_i" from 1 to 2 do {_unit addItemToVest "rhs_mag_9k38_rocket";};

_unit addHeadgear "H2";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";

// "Set identity";
//[_unit,"GreekHead_A3_02","male01eng"] call BIS_fnc_setIdentity;
