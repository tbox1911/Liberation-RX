waitUntil {sleep 1; !isNil "sectors_tower" };
{
	_nextower = Radio_tower createVehicle (markerPos _x);
	_nextower setpos (markerpos _x);
	_nextower setVectorUp [0,0,1];
	_nextower setVariable ["GRLIB_Radio_Tower", true, true];
	if (GRLIB_TFR_enabled) then {
		[_nextower, 0] call TFAR_antennas_fnc_initRadioTower;
	};
} foreach sectors_tower;