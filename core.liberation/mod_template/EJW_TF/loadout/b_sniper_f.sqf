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

_unit addWeapon "ej_m103d";
_unit addPrimaryWeaponItem "MRT_optic_M3A";
_unit addPrimaryWeaponItem "ej_PEQ15";
_unit addPrimaryWeaponItem "Barret_mag";

_unit forceAddUniform "U_B_GhillieSuit";
_unit addItemToUniform "FirstAidKit";
_unit addItemToUniform "HandGrenade";
_unit addItemToUniform "SmokeShell";

_unit addVest "V_PlateCarrierL_McamUS";
for "_i" from 1 to 5 do {_unit addItemToVest "Barret_mag";};

_unit addGoggles "ej_Oakleys";
_unit addWeapon "Binocular";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemWatch";
_unit linkItem "ItemRadio";
_unit linkItem "ItemGPS";
_unit linkItem "ej_PVS15D";