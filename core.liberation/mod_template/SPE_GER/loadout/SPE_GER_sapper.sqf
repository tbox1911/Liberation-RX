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


_unit addWeapon "SPE_K98_Late";
_unit addPrimaryWeaponItem "SPE_5Rnd_792x57";
_unit addPrimaryWeaponItem "SPE_5rnd_MUZZLE_FAKEMAG";

_unit forceAddUniform "U_SPE_GER_Soldier_Gaiters";
_unit addVest "V_SPE_GER_PioneerVest";
_unit addBackpack "B_SPE_GER_SapperBackpack2";

_unit addItemToUniform "SPE_GER_FirstAidKit";
_unit addItemToUniform "SPE_ToolKit";
for "_i" from 1 to 8 do {_unit addItemToUniform "SPE_5Rnd_792x57";};
for "_i" from 1 to 3 do {_unit addItemToVest "SPE_5Rnd_792x57";};
for "_i" from 1 to 2 do {_unit addItemToVest "SPE_Shg24";};
_unit addItemToBackpack "ToolKit";
for "_i" from 1 to 2 do {_unit addItemToBackpack "SPE_Ladung_Small_MINE_mag";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "SPE_Ladung_Big_MINE_mag";};
_unit addItemToBackpack "SPE_SMI_35_1_MINE_mag";
_unit addHeadgear "H_SPE_GER_Helmet";

_unit linkItem "ItemMap";
_unit linkItem "SPE_GER_ItemCompass_deg";
_unit linkItem "SPE_GER_ItemWatch";

