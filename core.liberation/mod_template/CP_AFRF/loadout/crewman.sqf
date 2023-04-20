_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeVest _unit;
removeUniform _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "CUP_U_O_RUS_Flora_1";
_unit addVest "CUP_V_RUS_6B3_1";

_unit addWeapon "CUP_arifle_AK74M";
_unit addPrimaryWeaponItem "CUP_30Rnd_545x39_AK74M_M";
_unit addWeapon "CUP_hgun_TT";
_unit addHandgunItem "CUP_8Rnd_762x25_TT";

for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 3 do { _unit addItemToUniform  "CUP_30Rnd_545x39_AK74M_M";};
_unit addItemToVest "SmokeShell";
for "_i" from 1 to 2 do {_unit  addItemToVest "CUP_8Rnd_762x25_TT";};
for "_i" from 1 to 2 do { _unit addItemToVest "MiniGrenade";};
for "_i" from 1 to 2 do { _unit addItemToVest "SmokeShell";};

_unit  addHeadgear "CUP_H_RUS_6B27";
_unit  addGoggles "CUP_RUS_Balaclava_blk_v2";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemRadio";