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
for "_i" from 1 to 2 do {_unit addItemToUniform "SmokeShell";};
_unit addVest "V_TacVest_oli";

for "_i" from 1 to 8 do {_unit addItemToVest "30Rnd_65x39_caseless_green";};
for "_i" from 1 to 3 do {_unit addItemToVest "16Rnd_9x21_Mag";};
_unit addBackpack "B_AssaultPack_rgr";
_unit addHeadgear "H_Cap_oli_hs";
_unit addGoggles "G_Bandanna_oli";
_unit addWeapon "arifle_Katiba_ARCO_F";
_unit addPrimaryWeaponItem "optic_MRCO";
_unit addWeapon "hgun_P07_F";
_unit addWeapon "Rangefinder";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemGPS";
_unit linkItem "NVGoggles_INDEP";