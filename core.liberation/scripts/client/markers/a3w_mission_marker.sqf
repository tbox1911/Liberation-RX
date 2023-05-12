waitUntil {sleep 1; !isNil "GRLIB_init_server"};

while { true } do {
	if (!isnil "GRLIB_A3W_Mission_SD") then {
		if (!isNil "GRLIB_A3W_Mission_Marker") then {
			deleteMarker "nikos_1";
			_marker = createMarkerLocal ["nikos_1", getPos GRLIB_A3W_Mission_Marker];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "mil_pickup";
			_marker setMarkerColorLocal "ColorPink";
			_marker setMarkerTextlocal (name GRLIB_A3W_Mission_Marker);
		} else {
			deleteMarker "nikos_1";
		};
	} else {
		deleteMarker "nikos_1";
	};
	sleep 5;
};
