disableSerialization;

_array = _this select 0;
_ctrl  = _array select 0;

if (ctrlChecked _ctrl) then {
	hint "GodMode ON !";
	player setVariable ["godmode", 1, true];
} else {
	hint "GodMode OFF !";
	player setVariable ["godmode", 0, true];
	player allowDamage true;
};
sleep 5;
