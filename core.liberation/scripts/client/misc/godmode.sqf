disableSerialization;

_array = _this select 0;
_ctrl  = _array select 0;

if (ctrlChecked _ctrl) then {
	hint "GodMode ON !";
	player forceAddUniform "B_Protagonist_VR_F";
	player allowDamage false;
	player setDamage 0;
} else {
	hint "GodMode OFF !";
	player forceAddUniform "B_Soldier_F";
	player allowDamage true;
};
sleep 5;
