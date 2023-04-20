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
for "_i" from 1 to 2 do {_unit addItemToUniform "SmokeShell";};
for "_i" from 1 to 3 do {_unit addItemToUniform "16Rnd_9x21_Mag";};
_unit addVest "V_I_G_ResistanceLeader_F";
for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToVest "SmokeShell";};
_unit addItemToVest "75rnd_762x39_AK12_Lush_Mag_F";
_unit addBackpack "B_TacticalPack_oli";
for "_i" from 1 to 4 do {_unit addItemToBackpack "75rnd_762x39_AK12_Lush_Mag_F";};
_unit addHeadgear "H_Watchcap_khk";
_unit addGoggles "G_Balaclava_lowprofile";
_unit addWeapon "arifle_RPK12_lush_arco_pointer_F";
_unit addWeapon "hgun_P07_F";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";