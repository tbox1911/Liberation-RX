disableSerialization;

private _array = _this select 0;
private _ctrl_chkd = (_array select 2 == 1);

if (_ctrl_chkd) then {
	hintSilent localize "STR_HINT_GODMODE_ON";
	player forceAddUniform "U_B_Protagonist_VR";
	player allowDamage false;
	player setDamage 0;
	do_admin = 1;
} else {
	hintSilent localize "STR_HINT_GODMODE_OFF";
	player forceAddUniform "U_B_CombatUniform_mcam";
	player allowDamage true;
	player setDamage 0;	
	do_admin = 0;
};
