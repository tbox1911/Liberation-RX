disableSerialization;

_array = _this select 0;
_ctrl  = _array select 0;

if (ctrlChecked _ctrl) then {
	hint "GodMode ON !";
	// player forceAddUniform "U_B_Protagonist_VR";
	player allowDamage false;
	player setDamage 0;
} else {
	hint "GodMode OFF !";
	// player forceAddUniform "U_B_CombatUniform_mcam";
	player allowDamage true;
};
sleep 5;
