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
_unit addVest "V_BandollierB_oli";
for "_i" from 1 to 8 do {_unit addItemToVest "20Rnd_762x51_Mag";};
_unit addHeadgear "H_Booniehat_oli";
_unit addGoggles "G_Balaclava_lowprofile";
_unit addWeapon "srifle_DMR_03_woodland_F";
_unit addPrimaryWeaponItem "optic_Hamr";
_unit addPrimaryWeaponItem "bipod_03_F_oli";
_unit addWeapon "hgun_P07_F";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";