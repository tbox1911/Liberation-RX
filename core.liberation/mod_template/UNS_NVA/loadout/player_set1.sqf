_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeUniform _unit;
removeVest _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add weapons";
_unit addWeapon "uns_makarov";
_unit addHandgunItem "uns_makarovmag";

comment "Add containers";
_unit forceAddUniform "UNS_NVA_KS";
_unit addVest "UNS_NVA_S2";
_unit addBackpack "uns_men_NVA_recon_65_MED_Bag";

comment "Add items to containers";
for "_i" from 1 to 2 do {_unit addItemToUniform "FirstAidKit";};
for "_i" from 1 to 3 do {_unit addItemToUniform "uns_makarovmag";};
for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToVest "uns_t67gren";};
_unit addHeadgear "UNS_Boonie_VC";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";

comment "Set identity";
[_unit,"AsianHead_A3_01_cfaces_vccamo02","male03per"] call BIS_fnc_setIdentity;
