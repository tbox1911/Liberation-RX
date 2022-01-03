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

//  "Add weapons";
_unit addWeapon "ffaa_armas_hkg36e";
_unit addPrimaryWeaponItem "ffaa_acc_puntero_ir";
_unit addPrimaryWeaponItem "ffaa_556x45_g36_tracer_green";

//  "Add containers";
_unit forceAddUniform "ffaa_brilat_CombatUniform_item_b";
_unit addVest "ffaa_brilat_chaleco_01_bs";
_unit addBackpack "B_Parachute";

//  "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToUniform "SmokeShell";};
for "_i" from 1 to 2 do {_unit addItemToUniform "SmokeShellGreen";};
for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
for "_i" from 1 to 5 do {_unit addItemToVest "ffaa_556x45_g36_tracer_green";};
for "_i" from 1 to 3 do {_unit addItemToVest "ffaa_granada_alhambra";};
_unit addHeadgear "ffaa_brilat_casco_b";
_unit addGoggles "ffaa_glasses";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ffaa_nvgoggles";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
