// Create AnitiAir-Specialist

_unit = _this select 0;

comment "Remove existing items";
removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "UK3CB_BAF_L85A2";
_unit addPrimaryWeaponItem "UK3CB_BAF_SUSAT";
_unit addPrimaryWeaponItem "UK3CB_BAF_556_30Rnd";
_unit addWeapon "rhs_weap_fim92";
_unit addSecondaryWeaponItem "rhs_fim92_mag";
_unit addWeapon "UK3CB_BAF_L131A1";
_unit addHandgunItem "UK3CB_BAF_9_17Rnd";

comment "Add containers";
_unit forceAddUniform "UK3CB_BAF_U_CombatUniform_DDPM_RM";
_unit addVest "UK3CB_BAF_V_Osprey_DDPM2";
_unit addBackpack "UK3CB_BAF_B_Carryall_DDPM";

comment "Add binoculars";
_unit addWeapon "Binocular";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
for "_i" from 1 to 3 do {_unit addItemToVest "UK3CB_BAF_556_30Rnd_T";};
for "_i" from 1 to 4 do {_unit addItemToVest "UK3CB_BAF_SmokeShell";};
for "_i" from 1 to 4 do {_unit addItemToVest "rhs_grenade_mkii_mag";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "FirstAidKit";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "UK3CB_BAF_556_30Rnd_T";};
_unit addItemToBackpack "rhs_fim92_mag";
_unit addHeadgear "UK3CB_BAF_H_Mk6_DDPM_A";
_unit addGoggles "G_Combat";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
