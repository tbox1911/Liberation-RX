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
	_vehicle setFuel 1;
	_vehicle engineOn true;

	(driver _vehicle) doMove _dest;

	private _landing_range = 150;
	private _stop = time + (5 * 60); // wait 5min max
	private _alt_old = 999;

	waitUntil { sleep 1; speed _vehicle > 5 };
	waitUntil {
		sleep 1;
		if (!isNil "GRLIB_taxi_helipad") then {
			if (_dest distance2D (getPosATL GRLIB_taxi_helipad) > 100) then {
				_dest = getPosATL GRLIB_taxi_helipad;
				(driver _vehicle) doMove _dest;
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
			sleep 1;
		};
		(((_vehicle distance2D _dest <= _landing_range || time > _stop) && unitReady (driver _vehicle)) || !(isNil "GRLIB_taxi_eject"))
	};
};

taxi_cargo = {
	params ["_vehicle"];
	(crew _vehicle - (_vehicle getVariable ["GRLIB_taxi_crew", []]));
};

taxi_outboard = {
	params ["_vehicle"];
	private _cargo = [_vehicle] call taxi_cargo;
	_vehicle setVehicleLock "UNLOCKED";
	_vehicle lockCargo false;
	waitUntil {
		_bailout = true;
		{
			if !(isNull objectParent _x) then {
				_bailout = false;
				unassignVehicle _x;
				moveOut _x;
				sleep 0.3;
			};
		} forEach _cargo;
		sleep 1;
		(_bailout);
	};
	_vehicle setVehicleLock "LOCKED";
	_vehicle lockCargo true;
};
