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

_unit addWeapon "ej_hk41610spmd_d";
_unit addPrimaryWeaponItem "SFLMGTMini_ej";
_unit addPrimaryWeaponItem "SFPEQ_laser";
_unit addPrimaryWeaponItem "EOTech3xIbex_Down";
_unit addPrimaryWeaponItem "41630mk262_mag";

_unit forceAddUniform "U_MulticamTFBlack_ej";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "HandGrenade";
_unit addItemToUniform "SmokeShell";

_unit addVest "V_PlateCarrierL_McamUS";

_unit addBackpack "TFBlack_Medic_Bag";
_backpack = unitBackpack _unit;
clearItemCargo _backpack;
clearWeaponCargo _backpack;
clearMagazineCargo _backpack;
clearItemCargo _backpack;

_unit addItemToBackpack "Medikit";

_unit addHeadgear "H_HelmetB_light_TFB";
_unit addGoggles "ej_Oakleys";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "ej_PVS15D";