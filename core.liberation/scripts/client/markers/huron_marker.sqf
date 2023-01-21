private [ "_huronlocal" ];

while { true } do {
	_huronlocal = ([entities huron_typename, {(_x getVariable ["GRLIB_vehicle_ishuron", false])}] call BIS_fnc_conditionalSelect) select 0;

	if ( isNil "_huronlocal" ) then {
		"huronmarker" setmarkerposlocal markers_reset;
	} else {
		"huronmarker" setmarkerposlocal (getPosATL _huronlocal);
	};
	sleep 5;
};
