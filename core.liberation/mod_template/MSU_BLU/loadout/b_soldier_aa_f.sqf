_unit = _this select 0;

private _militia_uniforms = [ 
    "U_BG_Guerilla1_1",
    "U_BG_Guerilla2_1",
    "U_BG_Guerilla2_2",
    "U_BG_Guerilla2_3",
    "U_BG_Guerilla3_1",
    "U_BG_Guerilla3_2"
];

removeUniform _unit;
_unit forceAddUniform (selectRandom _militia_uniforms);
_unit addHeadgear "H_Booniehat_oli";
_unit addGoggles "G_Balaclava_lowprofile";
