_unit = _this select 0;

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;


comment "Add weapons";
_unit addWeapon "LIB_PPSh41_d";
_unit addPrimaryWeaponItem "LIB_71Rnd_762x25";
_unit addWeapon "LIB_M1895";
_unit addHandgunItem "LIB_7Rnd_762x38";

comment "Add containers";
_unit forceAddUniform "U_LIB_SOV_Razvedchik_lis_w";
_unit addVest "V_LIB_SOV_IShBrVestPPShDisc";
_unit addBackpack "B_LIB_SOV_RA_Rucksack_Gas_Kit";

comment "Add binoculars";
_unit addWeapon "LIB_Binocular_SU";

comment "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "LIB_35Rnd_762x25";};
for "_i" from 1 to 3 do {_unit addItemToUniform "LIB_7Rnd_762x38";};
for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
_unit addItemToVest "LIB_35Rnd_762x25";
_unit addItemToVest "LIB_71Rnd_762x25";
_unit addItemToVest "LIB_Rpg6";
_unit addItemToVest "LIB_Rg42";
_unit addItemToBackpack "FirstAidKit";
_unit addItemToBackpack "LIB_71Rnd_762x25";
_unit addItemToBackpack "LIB_RDG";
_unit addItemToBackpack "LIB_No82";
_unit addHeadgear "H_LIB_SOV_RA_Helmet_w";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "LIB_GER_ItemCompass_deg";
_unit linkItem "LIB_GER_ItemWatch";

comment "Set identity";
[_unit,"LIB_WhiteHead_14_Dirt","male03su"] call BIS_fnc_setIdentity;


