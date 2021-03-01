params ["_target"];

openMap true;
hintSilent localize "STR_TAXI_SELECT";
_target onMapSingleClick {
	_freepos = _pos findEmptyPosition [1,30, "B_Heli_Transport_01_F"];
	if (surfaceIsWater _pos || count _freepos == 0) exitWith { hintSilent localize "STR_TAXI_WRONG_PLACE" };
	if (vehicle player == _this) then {
		_marker = createMarkerLocal ["taxi_dz", _freepos];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal "mil_flag";
		_marker setMarkerTextlocal "Taxi DZ";
	};
	onMapSingleClick "";
	openMap false;
	true;
};
