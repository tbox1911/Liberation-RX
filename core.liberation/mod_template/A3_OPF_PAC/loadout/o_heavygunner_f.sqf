_unit = _this select 0;

_unit addHeadgear "H_HelmetLeaderO_ghex_F";
_unit forceAddUniform "U_O_T_Soldier_F";
_unit addVest "V_HarnessO_ghex_F";
for "_i" from 1 to 2 do {_unit addItemToVest "150Rnd_93x64_Mag";};
