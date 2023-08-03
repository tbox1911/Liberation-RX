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
_unit addWeapon "SPE_K98";
_unit addPrimaryWeaponItem "SPE_5Rnd_792x57";
_unit addPrimaryWeaponItem "SPE_5rnd_MUZZLE_FAKEMAG";

//comment "Add containers";
_unit forceAddUniform "U_SPE_GER_Soldier_Gaiters";
_unit addVest "V_SPE_GER_SniperBelt";

//comment "Add items to containers";
_unit addItemToUniform "SPE_GER_FirstAidKit";
_unit addItemToUniform "SPE_ACC_K98_Bayo";
for "_i" from 1 to 10 do {_unit addItemToUniform "SPE_5Rnd_792x57";};
_unit addItemToVest "SPE_5Rnd_792x57";
_unit addHeadgear "H_SPE_GER_Cap";

//comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "SPE_GER_ItemCompass_deg";
_unit linkItem "SPE_GER_ItemWatch";

