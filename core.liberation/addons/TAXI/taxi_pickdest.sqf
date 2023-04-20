params ["_target"];
//add limit ?
if (time < GRLIB_taxi_cooldown) exitWith { hintSilent "Please wait..." };

openMap true;
hintSilent localize "STR_TAXI_SELECT";
_target onMapSingleClick {
	_freepos = _pos findEmptyPosition [0,30, "B_Heli_Transport_01_F"];
	if (surfaceIsWater _pos || count _freepos == 0) exitWith { hintSilent localize "STR_TAXI_WRONG_PLACE" };
	if (vehicle player == _this) then {
		deleteMarkerLocal "taxi_dz";
		if (!isNil "GRLIB_taxi_helipad") then {
			if (GRLIB_taxi_helipad_created) then { deleteVehicle GRLIB_taxi_helipad };
		};

		_marker = createMarkerLocal ["taxi_dz", _freepos];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal "mil_flag";
		_marker setMarkerTextlocal "Taxi DZ";

		GRLIB_taxi_helipad_created = false;
		GRLIB_taxi_helipad = selectRandom (nearestObjects [_freepos, ["Helipad_base_F"], 30]);
		if (isNil "GRLIB_taxi_helipad") then {
			GRLIB_taxi_helipad = taxi_helipad_type createVehicle _freepos;
			GRLIB_taxi_helipad_created = true;	
		};
		GRLIB_taxi_cooldown = round (time + 30);
	};
	onMapSingleClick "";
	openMap false;
	true;
};
