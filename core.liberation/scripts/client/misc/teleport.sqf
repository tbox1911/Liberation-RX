disableSerialization;

private _array = _this select 0;
private _ctrl_chkd = (_array select 2 == 1);

if (_ctrl_chkd) then {
	hintSilent localize "STR_HINT_TELEPORT_ON";
	player onMapSingleClick {
		if (_alt) then {
			if (surfaceIsWater _pos) then {
				player setPosASL _pos
			} else {
				player setPosATL _pos
			};
		};
		do_teleport = 1;
	};
} else {
	player onMapSingleClick "";
    do_teleport = 0;
};
