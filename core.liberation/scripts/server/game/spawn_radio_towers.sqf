waitUntil {sleep 1; !isNil "sectors_tower" };
waitUntil {sleep 1; !isNil "blufor_sectors" };

{
	_nextower = Radio_tower createVehicle (markerPos _x);
	_nextower setpos (markerpos _x);
	_nextower setVectorUp [0,0,1];
	_nextower setVariable ["GRLIB_Radio_Tower", true, true];
	if (GRLIB_TFR_enabled) then {
		if (_x in blufor_sectors) then {
			[_nextower, GRLIB_TFR_radius] call TFAR_antennas_fnc_initRadioTower;
		} else {
			_nextower call TFAR_antennas_fnc_deleteRadioTower;
		};
	};
} foreach sectors_tower;