_unit = _this select 0;

private _militia_uniforms = [ 
    "U_OG_Guerilla1_1",
    "U_OG_Guerilla2_1",
    "U_OG_Guerilla2_2",
    "U_OG_Guerilla2_3",
    "U_OG_Guerilla3_1"
];

_unit forceAddUniform (selectRandom _militia_uniforms);
_unit addHeadgear "H_Booniehat_oli";
_unit addGoggles "G_Balaclava_lowprofile";

_unit removeWeapon "launch_O_Titan_short_F";
_unit addWeapon "launch_MRAWS_green_F";
_unit addSecondaryWeaponItem "MRAWS_HEAT_F";

clearAllItemsFromBackpack _unit;
for "_i" from 1 to 2 do {_unit addItemToBackpack "MRAWS_HEAT_F";};
for "_i" from 1 to 2 do {_unit addItemToBackpack "MRAWS_HE_F";};