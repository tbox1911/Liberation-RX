
params ["_unit"];
if ( isServer ) then {
	_unit connectTerminalToUAV objNull;
	removeAllWeapons _unit;
	hidebody _unit;

	if (isPlayer _unit) then {
		_pos = getPosATL _unit;
		if ( vehicle _unit == _unit && _pos distance2D lhd >= 1000 && _pos distance2D ([] call F_getNearestFob) >= GRLIB_sector_size ) then {
			_unit setPos zeropos;
			_grave = createVehicle [(selectRandom GRLIB_player_grave), _pos, [], 0, "CAN_COLLIDE"];
			_grave setvariable ["GRLIB_grave_message", format ["%1 - R.I.P -", name _unit], true];
		};
	};

	sleep 60;
	deleteVehicle _unit;
};