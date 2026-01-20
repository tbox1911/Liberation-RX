_unit = _this select 0;

removeAllWeapons _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

_unit forceAddUniform "U_OG_Guerilla2_1";
_unit addVest "V_TacVest_camo";
_unit addHeadgear "H_Cap_headphones";
_unit addGoggles "G_Balaclava_combat";

_unit addWeapon "hgun_PDW2000_F";
_unit addPrimaryWeaponItem "30Rnd_9x21_Mag";
_unit addWeapon "hgun_P07_F";
_unit addHandgunItem "16Rnd_9x21_Mag";

for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 3 do { _unit addItemToUniform "16Rnd_9x21_Mag";};

for "_i" from 1 to 3 do { _unit addItemToVest "30Rnd_9x21_Mag";};
for "_i" from 1 to 2 do { _unit addItemToVest "MiniGrenade";};
for "_i" from 1 to 2 do { _unit addItemToVest "SmokeShell";};
