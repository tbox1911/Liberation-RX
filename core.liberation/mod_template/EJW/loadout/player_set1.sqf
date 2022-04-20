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
_unit addWeapon "Ej_glockMHSMcam";
_unit addHandgunItem "SF45T_ej";
_unit addHandgunItem "GlockCLjhpplus_Mag";

//  "Add containers";
_unit forceAddUniform "U_Multicam_ej";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "HandGrenade";
_unit addItemToUniform "SmokeShell";
for "_i" from 1 to 3 do {_unit addItemToUniform "GlockCLjhpplus_Mag";};

_unit addHeadgear "H_Booniehat_mcamo";

//  "Add items";
_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "ej_PVS15D";