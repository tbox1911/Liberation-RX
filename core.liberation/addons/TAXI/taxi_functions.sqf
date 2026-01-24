// Taxi functions
taxi_land = {
	params ["_vehicle"];
	private ["_alt", "_speed", "_vspeed"];
	private _stop = time + (3 * 60); // wait 2min max
	private _alt_old = 999;
	_vehicle land "LAND";
	hintSilent localize "STR_TAXI_LANDING";
	sleep 5;
	waitUntil {
		sleep 5;
		_alt = getPos _vehicle select 2;
		_speed = round (abs speed vehicle _vehicle);
		_vspeed = round (abs (_alt - _alt_old));
		_alt_old = _alt;
		if (_speed == 0 && _vspeed == 0 &&_alt > 3) then {
			_vehicle setPos (getPosATL _vehicle vectorAdd [0, 0, -2]);
			_vehicle land "LAND";
			hintSilent localize "STR_TAXI_LANDING";
			sleep 10;
		};
		(_alt <= 3 || time > _stop);
	};
	hintSilent localize "STR_TAXI_LANDED";
	doStop (driver _vehicle);
	sleep 5;
};

taxi_dest = {
	params ["_vehicle", "_dest", "_msg"];

	_vehicle setVariable ["GRLIB_taxi_destination", _dest, true];
	_vehicle setFuel 1;
	_vehicle engineOn true;

	(driver _vehicle) doMove _dest;
	sleep 30;

	private _landing_range = 150;
	private _stop = time + (5 * 60); // wait 5min max
	private _alt_old = 999;

	waitUntil {
		sleep 1;
		if (!isNil "GRLIB_taxi_helipad") then {
			if (_dest distance2D (getPosATL GRLIB_taxi_helipad) > 100) then {
				_dest = getPosATL GRLIB_taxi_helipad;
				(driver _vehicle) doMove _dest;
				sleep 5;
			};
		};

		if (count _msg > 0) then {
			hintSilent format [localize _msg, round (_vehicle distance2D _dest)];
		};

		_alt = (getPosATL _vehicle) select 2;
		_speed = round (abs speed vehicle _vehicle);
		_vspeed = round (abs (_alt - _alt_old));
		_alt_old = _alt;
		if (_speed == 0 && _vspeed == 0) then {
			[_vehicle] call F_vehicleUnflip;
			_vehicle setPos ((getPosATL _vehicle) vectorAdd [0, 0, 3]);
			(driver _vehicle) doMove _dest;
			sleep 5;
		};
		((_vehicle distance2D _dest <= _landing_range && unitReady driver _vehicle) || time >= _stop)
	};

	(time >= _stop);
};

taxi_cargo = {
	params ["_vehicle"];
	(crew _vehicle - (_vehicle getVariable ["GRLIB_taxi_crew", []]));
};

taxi_outboard = {
	params ["_vehicle", "_cargo"];
	if (count _cargo > 0) then { [player] call do_eject };
	_vehicle setVehicleLock "LOCKED";
	_vehicle lockCargo true;
};

taxi_check_dest = {
	params ["_vehicle", "_freepos"];
	if (GRLIB_taxi_helipad_created) then {
		deleteVehicle GRLIB_taxi_helipad;
		sleep 0.5;
	};
	GRLIB_taxi_helipad_created = false;
	GRLIB_taxi_helipad = selectRandom (nearestObjects [_freepos, ["Helipad_base_F"], 150]);
	if (isNil "GRLIB_taxi_helipad") then {
		{
			if (str _x find "heli" > -1) exitWith { GRLIB_taxi_helipad = _x };
		} forEach (nearestTerrainObjects [_freepos, ["Hide"], 150]);
	};
	if (isNil "GRLIB_taxi_helipad") then {
		GRLIB_taxi_helipad = taxi_helipad_type createVehicle _freepos;
		GRLIB_taxi_helipad_created = true;
		_vehicle setVariable ["GRLIB_taxi_helipad", GRLIB_taxi_helipad, true];
	};
	GRLIB_taxi_cooldown = round (time + 15);
	GRLIB_taxi_marker setMarkerPosLocal (getPosATL GRLIB_taxi_helipad);
	GRLIB_taxi_marker setMarkerTextlocal "Taxi DZ";
};