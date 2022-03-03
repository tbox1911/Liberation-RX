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
_unit addWeapon "OPTRE_MA5CGL";
_unit addPrimaryWeaponItem "OPTRE_MA5C_SmartLink";
_unit addPrimaryWeaponItem "OPTRE_32Rnd_762x51_Mag_Tracer";
_unit addWeapon "OPTRE_M6G";
_unit addHandgunItem "OPTRE_M6G_Flashlight";
_unit addHandgunItem "OPTRE_M6G_Scope";
_unit addHandgunItem "OPTRE_8Rnd_127x40_Mag_Tracer";

comment "Add containers";
_unit forceAddUniform "OPTRE_UNSC_ODST_Uniform";
_unit addVest "OPTRE_UNSC_M52D_Armor_Rifleman";
_unit addBackpack "OPTRE_ILCS_Rucksack_Black_Lead";

comment "Add items to containers";
_unit addItemToUniform "OPTRE_Biofoam";
for "_i" from 1 to 2 do {_unit addItemToUniform "OPTRE_32Rnd_762x51_Mag_Tracer";};
_unit addItemToUniform "OPTRE_8Rnd_127x40_Mag_Tracer";
_unit addItemToUniform "1Rnd_HE_Grenade_shell";
for "_i" from 1 to 2 do {_unit addItemToVest "OPTRE_32Rnd_762x51_Mag_Tracer";};
for "_i" from 1 to 3 do {_unit addItemToVest "OPTRE_60Rnd_762x51_Mag_Tracer";};
for "_i" from 1 to 2 do {_unit addItemToVest "OPTRE_8Rnd_127x40_Mag_Tracer";};
for "_i" from 1 to 2 do {_unit addItemToVest "1Rnd_HE_Grenade_shell";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "OPTRE_ELB47_Strobe";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "OPTRE_M2_Smoke_Green";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "OPTRE_M2_Smoke_Purple";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "OPTRE_M2_Smoke_Red";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "OPTRE_M2_Smoke";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "OPTRE_M8_Flare";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "OPTRE_M8_Flare_Green";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "C7_Remote_Mag";};
_unit addHeadgear "OPTRE_UNSC_CH252D_Helmet";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "OPTRE_NVG";
