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
_unit addWeapon "SPE_M1911";
_unit addHandgunItem "SPE_7Rnd_45ACP_1911";

//comment "Add containers";
_unit forceAddUniform "U_SPE_US_Private";
_unit addVest "V_SPE_US_Vest_Garand";
_unit addBackpack "B_SPE_US_Backpack_Bandoleer_Rifleman";

//comment "Add items to containers";
_unit addItemToUniform "SPE_ACC_M1_Bayo";
_unit addItemToUniform "SPE_US_FirstAidKit";
for "_i" from 1 to 3 do {_unit addItemToUniform "SPE_7Rnd_45ACP_1911";};
for "_i" from 1 to 2 do {_unit addItemToVest "SPE_US_FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToVest "SPE_US_Mk_2";};
_unit addHeadgear "H_SPE_US_Helmet_ns";

//comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "SPE_US_ItemCompass";
_unit linkItem "SPE_US_ItemWatch";

