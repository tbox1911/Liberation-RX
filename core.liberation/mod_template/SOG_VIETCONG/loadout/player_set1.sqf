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
_unit addWeapon "vn_vz61_p";
_unit addHandgunItem "vn_vz61_mag";

//  "Add containers";
_unit forceAddUniform "vn_o_uniform_nva_army_06_04";
_unit addVest "vn_o_vest_04";
//  "Add binoculars";
_unit addWeapon "vn_m19_binocs_grn";

//  "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "vn_o_item_firstaidkit";};
for "_i" from 1 to 4 do {_unit addItemToUniform "vn_vz61_t_mag";};
_unit addItemToUniform "vn_rdg2_mag";
_unit addItemToVest "vn_chicom_grenade_mag";
_unit addHeadgear "vn_o_boonie_nva_02_01";
_unit addGoggles "vn_o_poncho_01_01";


//  "Add items";
_unit linkItem "vn_o_item_map";
_unit linkItem "vn_b_item_compass";
_unit linkItem "vn_b_item_watch";
_unit linkItem "vn_o_item_radio_m252";
