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

comment "Add weapons";
_unit addWeapon "UK3CB_BAF_L85A2";
_unit addPrimaryWeaponItem "UK3CB_BAF_SFFH";
_unit addPrimaryWeaponItem "optic_ERCO_blk_F";
_unit addPrimaryWeaponItem "UK3CB_BAF_556_30Rnd";
_unit addWeapon "UK3CB_BAF_L131A1";
_unit addHandgunItem "UK3CB_BAF_9_17Rnd";

comment "Add containers";
_unit forceAddUniform "UK3CB_BAF_U_CombatUniform_DDPM_RM";
_unit addVest "UK3CB_BAF_V_Osprey_DDPM2";
_unit addBackpack "UK3CB_BAF_B_Bergen_DDPM_Rifleman_A";

comment "Add binoculars";
_unit addWeapon "Binocular";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "rhs_mag_m18_red";};
for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToVest "30Rnd_9x21_Mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "rhs_mag_m67";};
for "_i" from 1 to 8 do {_unit addItemToVest "rhs_mag_30Rnd_556x45_M855_Stanag";};
_unit addItemToVest "DemoCharge_Remote_Mag";
for "_i" from 1 to 4 do {_unit addItemToBackpack "rhs_mag_30Rnd_556x45_M855_Stanag";};
_unit addHeadgear "UK3CB_BAF_H_Mk6_DDPM_A";
_unit addGoggles "rhs_googles_yellow";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "UK3CB_BAF_HMNVS";
