_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "UK3CB_BAF_U_CombatUniform_DPMW_RM";
_unit addVest "UK3CB_BAF_V_Osprey_DPMW2";

comment "Add weapons";
_unit addWeapon "UK3CB_BAF_L22A2";
_unit addPrimaryWeaponItem "UK3CB_BAF_SUSAT";
_unit addPrimaryWeaponItem "UK3CB_BAF_556_30Rnd";
_unit addWeapon "UK3CB_BAF_L131A1";
_unit addHandgunItem "UK3CB_BAF_9_17Rnd";

comment "Add binoculars";
_unit addWeapon "Binocular";

comment "Add items to containers";
for "_i" from 1 to 4 do {_unit addItemToUniform "UK3CB_BAF_556_30Rnd";};
for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
_unit addHeadgear "UK3CB_BAF_H_Mk6_DPMW_A";
_unit addGoggles "UK3CB_BAF_G_Tactical_Black";


comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";