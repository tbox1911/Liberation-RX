_unit = _this select 0;

private _militia_uniforms = [ 
    "U_BG_Guerilla1_1",
    "U_BG_Guerilla2_1",
    "U_BG_Guerilla2_2",
    "U_BG_Guerilla2_3",
    "U_BG_Guerilla3_1",
    "U_BG_Guerilla3_2"
];

_unit forceAddUniform (selectRandom _militia_uniforms);
_unit addHeadgear "H_Booniehat_oli";
_unit addGoggles "G_Balaclava_lowprofile";

_unit removeWeapon "launch_I_Titan_short_F";
_unit addWeapon "launch_MRAWS_green_F";
_unit addSecondaryWeaponItem "MRAWS_HEAT_F";

clearAllItemsFromBackpack _unit;
for "_i" from 1 to 2 do {_unit addItemToBackpack "MRAWS_HEAT_F";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "MRAWS_HE_F";};