// Heli Taxi Script
private _taxi = player getVariable ["GRLIB_taxi_called", nil];
if (!isNil "_taxi") exitWith {hintSilent localize "STR_TAXI_ONLY_ONE"};

_taxi_back = false;

//check dest place
buildtype = 9;
build_unit = [taxi_helipad_type,[],1,[],[]];
dobuild = 1;

waitUntil { sleep 1; dobuild == 0};
private _helipad = nearestObjects [player, [taxi_helipad_type], 50] select 0;
private _degree = aCos ([0,0,1] vectorCos (surfaceNormal getPos _helipad));
private _dest = getPosATL _helipad;
if (surfaceIsWater _dest || _degree > 8) exitWith {deleteVehicle _helipad; hintSilent localize "STR_TAXI_WRONG_PLACE"};

// Pay
_cost = 30;
if (!([_cost] call F_pay)) exitWith {deleteVehicle _helipad};

private _nb_unit = count (units player);
private _taxi_type = "";

if (_nb_unit <= 2) then {_taxi_type = selectRandom taxi_type_2};
if (_nb_unit > 2 && _nb_unit <= 6) then {_taxi_type = selectRandom taxi_type_6};
if (_nb_unit > 6 && _nb_unit <= 8) then {_taxi_type = selectRandom taxi_type_8};
if (_nb_unit > 8) then {_taxi_type = selectRandom taxi_type_14};

hintSilent format [localize "STR_TAXI_CALLED", getText(configFile >> "cfgVehicles" >> _taxi_type >> "DisplayName")];

// Create Taxi
private _air_grp = createGroup [GRLIB_side_friendly, true]; // GRLIB_side_civilian
private _air_spawnpos = [] call F_getNearestFob;
if (isNil "GRLIB_all_fobs" || count GRLIB_all_fobs == 0) then {
	_air_spawnpos = getPos lhd;
};

_air_spawnpos = [(((_air_spawnpos select 0) + 500) - floor(random 1000)),(((_air_spawnpos select 1) + 500) - floor(random 1000)), 120];
_vehicle = createVehicle [_taxi_type, _air_spawnpos, [], 0, "FLY"];

/*
[_vehicle, true] call ace_arsenal_fnc_initBox;
private _can = createVehicle [canisterFuel, [0, 0, 0], [], 0, "NONE"];
[_can, _vehicle, true] call ace_cargo_fnc_loadItem;
*/

_vehicle flyInHeight 150;
_vehicle setVariable ["GRLIB_vehicle_owner", "server", true];
_vehicle setVariable ["GRLIB_counter_TTL", round(time + 1800), true];  // 30 minutes TTL
_vehicle setVariable ["R3F_LOG_disabled", true, true];

// _vehicle allowDamage false;

_vehicle allowCrewInImmobile true;
_vehicle setUnloadInCombat [true, false];
_vehicle addAction [format ["<t color='#8000FF'>%1</t>", localize "STR_TAXI_ACTION1"], "addons\TAXI\taxi_pickdest.sqf","",999,true,true,"","vehicle _this == _target"];
_vehicle addAction [format ["<t color='#FF0080'>%1</t>", localize "STR_TAXI_ACTION2"], {player setVariable ["GRLIB_taxi_called", nil, true]},"",998,true,true,"","vehicle _this == _target"];
player setVariable ["GRLIB_taxi_called", _vehicle, true];

createVehicleCrew _vehicle;
sleep 1;
private _pilots = crew _vehicle;
{
    [_x] orderGetIn true;
	// _x allowDamage false;
	_x allowFleeing 0;
	_x setVariable ["GRLIB_counter_TTL", round(time + 1800), true];  // 30 minutes TTL
 } foreach _pilots;
_pilots joinSilent _air_grp;

// Pickup Marker
_marker = createMarkerLocal ["taxi_lz", _dest];
_marker setMarkerShapeLocal "ICON";
_marker setMarkerTypeLocal "mil_pickup";
_marker setMarkerTextlocal "Taxi PickUp";

// Goto Pickup Point
[_air_grp, _dest] call taxi_dest;
private _stop = time + (5 * 60); // wait 5min max
waitUntil {
  sleep 5;
  hintSilent format [localize "STR_TAXI_MOVE", round (_vehicle distance2D _dest)];
  (_vehicle distance2D _dest < 150 || time > _stop)
};

if (time < _stop) then {
	[_vehicle] call taxi_land;
	private _stop = time + (5 * 60); // wait 5min max
	waitUntil {
		hintSilent format [localize "STR_TAXI_ARRIVED", round (_stop - time)];
		sleep 1;
		((count ([_vehicle, _pilots] call taxi_cargo) > 0) || time > _stop)
	};
	hintSilent "";

	if (time < _stop) then {

		private _stop = time + (5 * 60); // wait 5min max
		waitUntil {
			sleep 0.5;
			( (markerPos "taxi_dz") distance2D zeropos > 100 || isNil {player getVariable ["GRLIB_taxi_called", nil]} || time > _stop )
		};

		// removeAllActions _vehicle;
		deleteMarkerLocal "taxi_lz";

		if ( (markerPos "taxi_dz") distance2D zeropos > 100 ) then {
			hintSilent "Ok, let's go...";
			// _vehicle lock 2;
			// { _x allowDamage false } forEach ([_vehicle, _pilots] call taxi_cargo);

			_dest = markerPos "taxi_dz";
			_helipad = taxi_helipad_type createVehicle _dest;
			[_air_grp, _dest] call taxi_dest;
			(driver _vehicle) doMove _dest;
			sleep 30;

			private _stop = time + (5 * 60); // wait 5min max
			waitUntil {
				hintSilent format [localize "STR_TAXI_PROGRESS", round (_vehicle distance2D _dest)];
				sleep 5;
				if (round (speed _vehicle) == 0) then {
					_vehicle setpos (getPos _vehicle vectorAdd [0, 0, 2]);
				};
				(_vehicle distance2D _dest < 150 || time > _stop)
			};

			[_vehicle] call taxi_land;
			// { _x allowDamage true } forEach ([_vehicle, _pilots] call taxi_cargo);

			deleteVehicle _helipad;
			deleteMarkerLocal "taxi_dz";
		};

		// Board Out
		// _vehicle lock 3;
		waitUntil {[_vehicle] call taxi_outboard};
		sleep 5;

		// Go back
		hintSilent localize "STR_TAXI_RETURN";
		[_air_grp, zeropos] call taxi_dest;
		(driver _vehicle) doMove zeropos;
		_taxi_back = true;
		sleep 30;

		private _stop = time + (2 * 60); // wait 2min max
		waitUntil {
			sleep 5;
			_speed = round (speed _vehicle);
			if (_speed == 0) then {
				_vehicle setpos (getPos _vehicle vectorAdd [0, 0, 2]);
			};
			(_speed >= 10 || time > _stop)
		};
	};
};


// Cleanup
hintSilent "";
deleteMarkerLocal "taxi_lz";
deleteMarkerLocal "taxi_dz";
deleteVehicle _helipad;

// Go back if not boarded
if(_taxi_back == false) then {
	hintSilent localize "STR_TAXI_RETURN";
	[_air_grp, zeropos] call taxi_dest;
	(driver _vehicle) doMove zeropos;
	_taxi_back = true;
	sleep 30;

	private _stop = time + (2 * 60); // wait 2min max
	waitUntil {
		sleep 5;
		_speed = round (speed _vehicle);
		if (_speed == 0) then {
			_vehicle setpos (getPos _vehicle vectorAdd [0, 0, 2]);
		};
		(_speed >= 10 || time > _stop)
	};
};

sleep 60;
{deletevehicle _x} forEach _pilots;
deleteVehicle _vehicle;
player setVariable ["GRLIB_taxi_called", nil, true];
