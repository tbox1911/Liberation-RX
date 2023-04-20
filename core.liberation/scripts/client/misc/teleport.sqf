disableSerialization;

_array = _this select 0;
_ctrl_chkd = (_array select 2 == 1);

if (_ctrl_chkd) then {
	hint "Teleport ON !";
	player onMapSingleClick "if (_alt) then {player setPosATL _pos}";
    do_teleport = 1;
} else {
	hint "Teleport OFF !";
	player onMapSingleClick "";
    do_teleport = 0;
};
