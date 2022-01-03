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
_unit addWeapon "ffaa_armas_p226";
_unit addHandgunItem "ffaa_9x19_pistola";

//  "Add containers";
_unit forceAddUniform "ffaa_brilat_CombatUniform_item_b";
_unit addVest "V_Rangemaster_belt";

// "Add binocilars";
_unit addWeapon "Binocular";

//  "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 3 do {_unit addItemToUniform "ffaa_9x19_pistola";};
for "_i" from 1 to 2 do {_unit addItemToVest "ffaa_granada_alhambra";};
_unit addItemToVest "SmokeShell";
_unit addItemToVest "SmokeShellRed";
_unit addItemToVest "SmokeShellGreen";
_unit addHeadgear "ffaa_fgne_boina";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";

