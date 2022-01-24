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
_unit addWeapon "vn_m3a1";
_unit addPrimaryWeaponItem "vn_m3a1_t_mag";
_unit addWeapon "vn_m10";
_unit addHandgunItem "vn_m10_mag";

//  "Add containers";
_unit forceAddUniform "vn_b_uniform_macv_01_01";
_unit addVest "vn_b_vest_usarmy_13";

//  "Add binoculars";
_unit addWeapon "vn_m19_binocs_grey";

//  "Add items to containers";
_unit addItemToUniform "vn_o_item_firstaidkit";
_unit addItemToUniform "vn_b_item_firstaidkit";
for "_i" from 1 to 2 do {_unit addItemToUniform "vn_m61_grenade_mag";};
_unit addItemToUniform "vn_m10_mag";
for "_i" from 1 to 3 do {_unit addItemToUniform "vn_m3a1_t_mag";};
_unit addHeadgear "vn_b_helmet_t56_02_03";
_unit addGoggles "vn_b_aviator";

//  "Add items";
_unit linkItem "vn_b_item_map";
_unit linkItem "vn_b_item_compass";
_unit linkItem "vn_b_item_watch";
_unit linkItem "vn_b_item_radio_urc10";