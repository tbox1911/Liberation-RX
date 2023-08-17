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
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addHandgunItem "11Rnd_45ACP_Mag";
_unit addWeapon "Ltf_EFT_alpha_5_rvg_zen2_dtk";
_unit addPrimaryWeaponItem "rhs_acc_1p87";
_unit addPrimaryWeaponItem "dtkworn_f";
_unit addPrimaryWeaponItem "30Rnd_545x39_Mag_F";

//  "Add containers";
_unit forceAddUniform "Inf01";
_unit addVest "Vest01r";
_unit addBackpack "B_AssaultPack_blk_DiverExp";

//  "Add binoculars";
_unit addWeapon "Rangefinder";

//  "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 5 do {_unit addItemToVest "30Rnd_545x39_Mag_F";};
_unit addItemToBackpack "Medikit";
_unit addHeadgear "H6";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "O_NVGoggles_urb_F";

// "Set identity";
//[_unit,"GreekHead_A3_02","male01eng"] call BIS_fnc_setIdentity;
