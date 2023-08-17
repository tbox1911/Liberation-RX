_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit forceAddUniform "Soldier04";
_unit addVest "Vest01r";

_unit addWeapon "CUP_arifle_AKS74U";
_unit addPrimaryWeaponItem "CUP_30Rnd_545x39_AK_M";
_unit addWeapon "hgun_Pistol_heavy_01_F";
_unit addHandgunItem "11Rnd_45ACP_Mag";

for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 3 do { _unit addItemToUniform  "16Rnd_9x21_Mag";};
for "_i" from 1 to 3 do { _unit addItemToVest "CUP_30Rnd_545x39_AK_M";};
for "_i" from 1 to 2 do { _unit addItemToVest "MiniGrenade";};
for "_i" from 1 to 2 do { _unit addItemToVest "SmokeShell";};

_unit addHeadgear "CUP_H_SLA_TankerHelmet";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemRadio";