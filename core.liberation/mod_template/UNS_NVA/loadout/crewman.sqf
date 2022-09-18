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
_unit addWeapon "uns_ak47_52";
_unit addPrimaryWeaponItem "uns_ak47mag";
_unit addWeapon "uns_p64";
_unit addHandgunItem "uns_6Rnd_czak";

comment "Add containers";
_unit forceAddUniform "UNS_NVA_G";
_unit addVest "UNS_NVA_A2";

comment "Add binoculars";
_unit addWeapon "Binocular";

comment "Add items to containers";
_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "uns_ak47mag_T";};
_unit addItemToUniform "uns_6Rnd_czak";
for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
_unit addItemToVest "uns_ak47mag";
for "_i" from 1 to 3 do {_unit addItemToVest "uns_ak47mag_T";};
_unit addItemToVest "uns_6Rnd_czak";
for "_i" from 1 to 3 do {_unit addItemToVest "uns_t67gren";};
for "_i" from 1 to 2 do {_unit addItemToVest "uns_rgd33gren";};
_unit addHeadgear "UNS_NVA_HGG";

comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";

comment "Set identity";
[_unit,"AsianHead_A3_05","male01per"] call BIS_fnc_setIdentity;

