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

_unit addWeapon "ej_scarshorteglm";
_unit addPrimaryWeaponItem "ej_PEQ15";
_unit addPrimaryWeaponItem "ej_acogrmrTan2d";
_unit addPrimaryWeaponItem "scarhcqc_mag";
_unit addPrimaryWeaponItem "1Rnd_HE_Grenade_shell";

_unit forceAddUniform "U_MulticamTFBlack_ej";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "HandGrenade";
_unit addItemToUniform "SmokeShell";

_unit addVest "V_PlateCarrierL_McamUS";
for "_i" from 1 to 5 do {_unit addItemToVest "scarhcqc_mag";};
for "_i" from 1 to 5 do {_unit addItemToVest "1Rnd_HE_Grenade_shell";};

_unit addHeadgear "H_HelmetB_light_TFB";
_unit addGoggles "ej_Oakleys";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "ej_PVS15D";