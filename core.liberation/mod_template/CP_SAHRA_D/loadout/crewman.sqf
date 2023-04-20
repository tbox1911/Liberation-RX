_unit = _this select 0;

removeAllWeapons _unit;
removeAllItems _unit;
removeAllAssignedItems _unit;
removeVest _unit;
removeUniform _unit;
removeBackpack _unit;
removeHeadgear _unit;
removeGoggles _unit;

comment "Add containers";
_unit forceAddUniform "CUP_U_I_RACS_Desert_2";
_unit addVest "CUP_V_B_Interceptor_Rifleman_Coyote";

_unit addWeapon "CUP_arifle_M16A2";
_unit addPrimaryWeaponItem "CUP_30Rnd_556x45_Stanag";
_unit addWeapon "CUP_hgun_Colt1911";
_unit addHandgunItem "CUP_7Rnd_45ACP_1911";

_unit addItemToUniform "FirstAidKit";
for "_i" from 1 to 5 do {_unit addItemToUniform "CUP_30Rnd_556x45_Stanag";};
_unit addItemToUniform "SmokeShellRed";
for "_i" from 1 to 2 do {_unit addItemToVest "FirstAidKit";};
for "_i" from 1 to 2 do {_unit addItemToVest "CUP_30Rnd_556x45_Stanag";};
for "_i" from 1 to 2 do {_unit addItemToVest "CUP_HandGrenade_M67";};
for "_i" from 1 to 2 do {_unit addItemToVest "CUP_7Rnd_45ACP_1911";};

_unit addHeadgear "CUP_H_LWHv2_desert";
_unit addGoggles "CUP_G_Shades_Blue";

_unit linkItem "ItemMap";
_unit linkItem "ItemCompass";
_unit linkItem "ItemRadio";
_unit linkItem "ItemWatch";
_unit linkItem "CUP_NVG_PVS7_Hide";