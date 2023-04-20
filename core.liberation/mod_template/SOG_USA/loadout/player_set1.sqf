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
_unit addWeapon "vn_mc10";
_unit addPrimaryWeaponItem "vn_mc10_t_mag";

//  "Add containers";
_unit forceAddUniform "vn_b_uniform_macv_04_01";
_unit addVest "vn_b_vest_usarmy_04";
//  "Add binoculars";
_unit addWeapon "vn_m19_binocs_grn";

//  "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "vn_b_item_firstaidkit";};
for "_i" from 1 to 4 do {_unit addItemToUniform "vn_mc10_t_mag";};
for "_i" from 1 to 2 do {_unit addItemToUniform "vn_m61_grenade_mag";};
_unit addItemToVest "vn_m18_white_mag";
_unit addItemToVest "vn_m18_red_mag";
_unit addItemToVest "vn_m18_green_mag";
_unit addHeadgear "vn_b_boonie_04_04";
_unit addGoggles "vn_b_aviator";


//  "Add items";
_unit linkItem "vn_b_item_map";
_unit linkItem "vn_b_item_compass";
_unit linkItem "vn_b_item_watch";
_unit linkItem "vn_b_item_radio_urc10";
