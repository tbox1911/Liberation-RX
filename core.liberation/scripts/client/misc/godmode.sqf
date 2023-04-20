disableSerialization;

_array = _this select 0;
_ctrl_chkd = (_array select 2 == 1);

if (_ctrl_chkd) then {
	hint "GodMode ON !";
	player forceAddUniform "U_B_Protagonist_VR";
	player allowDamage false;
	player setDamage 0;
	do_admin = 1;
} else {
	hint "GodMode OFF !";
	player forceAddUniform "U_B_CombatUniform_mcam";
	player allowDamage true;
	do_admin = 0;
};
