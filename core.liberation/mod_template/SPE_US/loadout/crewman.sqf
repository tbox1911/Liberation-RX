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


//comment "Add weapons";
_unit addWeapon "SPE_M3_GreaseGun";
_unit addPrimaryWeaponItem "SPE_30Rnd_M3_GreaseGun_45ACP";
_unit addPrimaryWeaponItem "SPE_30rnd_MUZZLE_FAKEMAG";

//comment "Add containers";
_unit forceAddUniform "U_SPE_US_Tank_Crew";

//comment "Add binoculars";
_unit addWeapon "SPE_Binocular_US";

//comment "Add items to containers";
_unit addItemToUniform "SPE_US_FirstAidKit";
for "_i" from 1 to 2 do {_unit addItemToUniform "SPE_30Rnd_M3_GreaseGun_45ACP";};
_unit addItemToUniform "SPE_US_M18";
_unit addHeadgear "H_SPE_US_Helmet_Tank_NG";

//comment "Add items";
_unit linkItem "ItemMap";
_unit linkItem "SPE_US_ItemCompass";
_unit linkItem "SPE_US_ItemWatch";
_unit linkItem "ItemRadio";

//comment "Set identity";
[_unit,"WhiteHead_12","male07eng"] call BIS_fnc_setIdentity;
