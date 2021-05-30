while { true } do {
	if (!isnil "GRLIB_A3W_Mission_SD") then {
		_unit = player getVariable ["GRLIB_A3W_Mission_Marker", nil];
		if (!isNil "_unit") then {
			deleteMarker "nikos_1";
			_marker = createMarkerLocal ["nikos_1", getPos _unit];
			_marker setMarkerShapeLocal "ICON";
			_marker setMarkerTypeLocal "mil_pickup";
			_marker setMarkerColorLocal "ColorPink";
			_marker setMarkerTextlocal (name _unit);
		} else {
			deleteMarker "nikos_1";
		};
	} else {
		deleteMarker "nikos_1";
	};
	sleep 5;
};
