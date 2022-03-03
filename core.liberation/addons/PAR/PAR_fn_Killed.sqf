params ["_unit"];
_unit connectTerminalToUAV objNull;
removeAllWeapons _unit;
hidebody _unit;

if (_unit == player) then {
	_pos = getPosATL _unit;
	if ( isNull objectParent player && _pos distance2D lhd >= 1000 && _pos distance2D ([] call F_getNearestFob) >= GRLIB_sector_size && round(_pos select 2) == 0 && !(surfaceIsWater _pos)) then {
		_unit setPos zeropos;
		_grave = createVehicle [(selectRandom GRLIB_player_grave), _pos, [], 0, "CAN_COLLIDE"];
		_grave setvariable ["GRLIB_grave_message", format ["%1 - R.I.P -", name player], true];
	};
};

sleep 10;
deleteVehicle _unit;