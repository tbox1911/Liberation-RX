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
_unit addWeapon "SPE_P08";
_unit addHandgunItem "SPE_8Rnd_9x19_P08";

//comment "Add containers";
_unit forceAddUniform "U_SPE_GER_Soldier_Boots";
_unit addVest "V_SPE_GER_VestKar98";
_unit addBackpack "B_SPE_GER_Belt_bag_K98k_MG";

//comment "Add items to containers";
_unit addItemToUniform "SPE_GER_FirstAidKit";
_unit addItemToUniform "SPE_ACC_K98_Bayo";
for "_i" from 1 to 2 do {_unit addItemToUniform "SPE_8Rnd_9x19_P08";};
for "_i" from 1 to 2 do {_unit addItemToVest "SPE_GER_FirstAidKit";};
_unit addItemToVest "SPE_Shg24";
_unit addItemToVest "SPE_8Rnd_9x19_P08";
_unit addItemToBackpack "SPE_50Rnd_792x57";
_unit addHeadgear "H_SPE_GER_Helmet";

//comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "SPE_GER_ItemCompass_deg";
_unit linkItem "SPE_GER_ItemWatch";

