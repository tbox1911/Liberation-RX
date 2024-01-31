waitUntil {sleep 1; !isNil "GRLIB_init_server"};

while { true } do {
	waitUntil {sleep 1; GRLIB_MapOpen };
	if ( isNil "GRLIB_vehicle_huron" ) then {
		"huronmarker" setmarkerposlocal markers_reset;
	} else {
		"huronmarker" setmarkerposlocal (getPosATL GRLIB_vehicle_huron);
	};
	sleep 3;
};
