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
_unit addWeapon "vn_pps43";
_unit addPrimaryWeaponItem "vn_pps_t_mag";

//  "Add containers";
_unit forceAddUniform "vn_o_uniform_nva_army_05_04";
_unit addVest "vn_o_vest_06";

//  "Add items to containers";
_unit addItemToUniform "vn_o_item_firstaidkit";
for "_i" from 1 to 3 do {_unit addItemToUniform "vn_pps_t_mag";};
_unit addItemToUniform "vn_rdg2_mag";
_unit addItemToUniform "vn_t67_grenade_mag";
_unit addItemToVest "vn_t67_grenade_mag";
_unit addHeadgear "vn_o_helmet_tsh3_01";
_unit addGoggles "vn_o_acc_goggles_01";

//  "Add items";
_unit linkItem "vn_o_item_map";
_unit linkItem "vn_b_item_compass";
_unit linkItem "vn_b_item_watch";
_unit linkItem "vn_o_item_radio_m252";