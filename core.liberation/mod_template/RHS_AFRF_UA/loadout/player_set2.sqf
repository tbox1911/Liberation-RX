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
_unit addWeapon "arifle_MSBS65_Mark_black_F";
_unit addPrimaryWeaponItem "optic_AMS";
_unit addPrimaryWeaponItem "30Rnd_65x39_caseless_msbs_mag";

//  "Add containers";
_unit forceAddUniform "U_B_CTRG_Soldier_urb_1_F";
_unit addVest "V_PlateCarrierSpec_blk";
_unit addBackpack "B_AssaultPack_blk_DiverExp";

//  "Add binoculars";
_unit addWeapon "Rangefinder";

//  "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "11Rnd_45ACP_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "HandGrenade";};
for "_i" from 1 to 5 do {_unit addItemToVest "30Rnd_65x39_caseless_msbs_mag";};
_unit addItemToBackpack "Medikit";
_unit addHeadgear "H_HelmetLeaderO_oucamo";
_unit addGoggles "g_airpurifyingrespirator_02_black_f";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "O_NVGoggles_urb_F";

// "Set identity";
//[_unit,"GreekHead_A3_02","male01eng"] call BIS_fnc_setIdentity;
