// Create AnitiAir-Specialist

_unit = _this select 0;


private _militia_uniforms = [ 
    "U_BG_Guerilla1_1",
    "U_BG_Guerilla2_1",
    "U_BG_Guerilla2_2",
    "U_BG_Guerilla2_3",
    "U_BG_Guerilla3_1",
    "U_BG_Guerilla3_2"
];

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
_unit forceAddUniform "UK3CB_BAF_U_CombatUniform_DPMW_RM";
_unit addVest "UK3CB_BAF_V_Osprey_DPMW2";
_unit addBackpack "UK3CB_BAF_B_Carryall_OLI";

comment "Add binoculars";
_unit addWeapon "Binocular";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "UK3CB_BAF_556_30Rnd_T";};
for "_i" from 1 to 4 do {_unit addItemToVest "UK3CB_BAF_556_30Rnd_T";};
for "_i" from 1 to 4 do {_unit addItemToVest "UK3CB_BAF_SmokeShell";};
for "_i" from 1 to 4 do {_unit addItemToVest "rhs_grenade_mkii_mag";};
for "_i" from 1 to 2 do {_unit addItemToVest "rhs_mag_an_m14_th3";};
for "_i" from 1 to 4 do {_unit addItemToBackpack "FirstAidKit";};
_unit addItemToBackpack "rhs_fim92_mag";
for "_i" from 1 to 2 do {_unit addItemToBackpack "UK3CB_BAF_556_30Rnd_T";};
_unit addItemToBackpack "rhsusf_m112_mag";
_unit addHeadgear "UK3CB_BAF_H_Mk6_DPMW_A";
_unit addGoggles "UK3CB_BAF_G_Tactical_Yellow";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
