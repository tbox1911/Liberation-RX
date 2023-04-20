params ["_target"];

openMap true;
hintSilent "Select the Destination.";
_target onMapSingleClick {
	if (surfaceIsWater _pos) then {	hintSilent "Sorry, Taxi cannot Land on this place."	};
	if (vehicle player == _this) then {
		_marker = createMarkerLocal ["taxi_dz", _pos];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal "mil_flag";
		_marker setMarkerTextlocal "Taxi DZ";
	};
	onMapSingleClick "";
	openMap false;
	true;
};
