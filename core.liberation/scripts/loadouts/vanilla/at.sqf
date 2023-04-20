_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

sleep 0.5;

for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "MiniGrenade";};
for "_i" from 1 to 2 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
_unit addVest "V_Chestrig_rgr";
for "_i" from 1 to 5 do {_unit addItemToVest "30Rnd_556x45_Stanag_Tracer_Green";};
_unit addBackpack "B_Carryall_oli";
for "_i" from 1 to 3 do {_unit addItemToBackpack "RPG32_F";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "RPG32_HE_F";};
_unit addHeadgear "H_Cap_grn";
_unit addGoggles "G_Bandanna_aviator";
_unit addWeapon "arifle_TRG20_F";
_unit addPrimaryWeaponItem "optic_ACO_grn";
_unit addWeapon "launch_RPG32_F";
_unit addItemToBackpack "RPG32_F";
_unit addWeapon "hgun_P07_F";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";