params ["_unit"];

removeUniform _unit
removeVest _unit;
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

sleep 0.5;
_unit addUniform "U_B_CombatUniform_mcam";
_unit addHeadgear "H_Cap_blk";
_unit addGoggles "G_Balaclava_oli";

for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "MiniGrenade";};
for "_i" from 1 to 3 do {_unit addItemToUniform "16Rnd_9x21_Mag";};

_unit addVest "V_Chestrig_oli";
for "_i" from 1 to 8 do {_unit addItemToVest "20Rnd_762x51_Mag";};

_unit addBackpack "B_Carryall_oli";
for "_i" from 1 to 3 do {_unit addItemToBackpack "RPG32_F";};

_unit addWeapon "hgun_P07_F";
_unit addHandgunItem "muzzle_snds_L";

_unit addWeapon "srifle_DMR_06_camo_F";
_unit addPrimaryWeaponItem "optic_ACO_grn";

_unit addWeapon "launch_RPG32_F";
//_unit addSecondaryWeaponItem "muzzle_snds_L";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";