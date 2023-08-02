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


//comment "Add weapons";
_unit addWeapon "SPE_M1_Carbine";
_unit addPrimaryWeaponItem "SPE_15Rnd_762x33";
_unit addPrimaryWeaponItem "SPE_32rnd_MUZZLE_FAKEMAG";

//comment "Add containers";
_unit forceAddUniform "U_SPE_US_Technician";
_unit addVest "V_SPE_US_Vest_Carbine_eng";
_unit addBackpack "B_SPE_US_Backpack_eng";

//comment "Add items to containers";
_unit addItemToUniform "SPE_US_FirstAidKit";
_unit addItemToUniform "SPE_ToolKit";
for "_i" from 1 to 5 do {_unit addItemToUniform "SPE_15Rnd_762x33";};
for "_i" from 1 to 5 do {_unit addItemToVest "SPE_15Rnd_762x33";};
_unit addItemToVest "SPE_US_TNT_4pound_mag";
for "_i" from 1 to 2 do {_unit addItemToVest "SPE_US_Mk_2";};
_unit addItemToBackpack "ToolKit";
for "_i" from 1 to 4 do {_unit addItemToBackpack "SPE_US_TNT_half_pound_mag";};
_unit addItemToBackpack "SPE_US_TNT_4pound_mag";
_unit addHeadgear "H_SPE_US_Helmet_Net";

//comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "SPE_US_ItemCompass";
_unit linkItem "SPE_US_ItemWatch";



