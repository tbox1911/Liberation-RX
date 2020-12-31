// Heli Taxi Script
private _taxi = player getVariable ["GRLIB_taxi_called", nil];
if (!isNil "_taxi") exitWith {hintSilent localize "STR_TAXI_ONLY_ONE"};

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
_cost = 100;
if (!([_cost] call F_pay)) exitWith {deleteVehicle _helipad};

private _nb_unit = count (units player);
private _taxi_type = "";

if (_nb_unit <= 2) then {_taxi_type = taxi_type_2 call BIS_fnc_selectRandom};
if (_nb_unit > 2 && _nb_unit <= 6) then {_taxi_type = taxi_type_6 call BIS_fnc_selectRandom};
if (_nb_unit > 6 && _nb_unit <= 8) then {_taxi_type = taxi_type_8 call BIS_fnc_selectRandom};
if (_nb_unit > 8) then {_taxi_type = taxi_type_14 call BIS_fnc_selectRandom};

hintSilent format [localize "STR_TAXI_CALLED", getText(configFile >> "cfgVehicles" >> _taxi_type >> "DisplayName")];
player setVariable ["GRLIB_taxi_called", _vehicle, true];

// Create Taxi
_air_grp = createGroup [GRLIB_side_civilian, true];
_air_spawnpos = [] call F_getNearestFob;
if (isNil "GRLIB_all_fobs" || count GRLIB_all_fobs == 0) then {
	_air_spawnpos = markerPos "base_chimera";
};

_air_spawnpos = [(((_air_spawnpos select 0) + 500) - random 1000),(((_air_spawnpos select 1) + 500) - random 1000), 120];
_vehicle = createVehicle [_taxi_type, _air_spawnpos, [], 0, "FLY"];
_vehicle setVariable ["GRLIB_vehicle_owner", "server"];
_vehicle setVariable ["R3F_LOG_disabled", true];
[_vehicle] spawn protect_static;
_vehicle flyInHeight (100 + (random 60));

createVehicleCrew _vehicle;
sleep 1;
_pilots = crew _vehicle;
{
	_x allowDamage false;
	_x  allowFleeing 0;
 } foreach _pilots;
_pilots joinSilent _air_grp;

// Goto Pickup Point
[_air_grp, _dest] call taxi_dest;
waitUntil {
  sleep 5;
  isNil{hintSilent format [localize "STR_TAXI_MOVE", round (_vehicle distance2D _dest)]};
  (!alive _vehicle || _vehicle distance2D _dest < 200)
};

if (alive _vehicle && alive player) then {
	[_vehicle] call taxi_land;

	// Pickup Marker
	_marker = createMarkerLocal ["taxi_lz", getPos _vehicle];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal "mil_pickup";
	_marker setMarkerTextlocal "Taxi PickUp";

	_stop = time + (5 * 60); // wait 5min max
	waitUntil {
		hintSilent format [localize "STR_TAXI_ARRIVED", round (_stop - time)];
		sleep 1;
		(!alive _vehicle || vehicle player == _vehicle || time > _stop)
	};
	hintSilent "";

	if (alive _vehicle && vehicle player == _vehicle) then {
		_idact_dest = _vehicle addAction ["<t color='#8000FF'>-- TAXI Destination</t>","addons\TAXI\taxi_pickdest.sqf","",999,true,true,"","vehicle _this == _target"];
		waitUntil {
			sleep 1;
			(!alive _vehicle || !alive player || (markerPos "taxi_dz") distance2D zeropos > 100)
		};
		_vehicle removeAction _idact_dest;
		deleteMarkerLocal "taxi_lz";

		if (alive _vehicle && count ([_vehicle, _pilots] call taxi_cargo) > 0) then {
			hintSilent "Ok, let's go...";
			_dest = markerPos "taxi_dz";
			_helipad = taxi_helipad_type createVehicle _dest;
			[_air_grp, _dest] call taxi_dest;
			(driver _vehicle) doMove _dest;
			sleep 15;
			waitUntil {
				hintSilent format [localize "STR_TAXI_PROGRESS", round (_vehicle distance2D _dest)];
				sleep 5;
				if (round (speed _vehicle) == 0) then {
					{ _x allowDamage false } forEach ([_vehicle, _pilots] call taxi_cargo);
					_vehicle setpos (getPos _vehicle vectorAdd [0, 0, 2]);
					sleep 3;
					{ _x allowDamage true } forEach ([_vehicle, _pilots] call taxi_cargo);
				};
				(!alive _vehicle || count ([_vehicle, _pilots] call taxi_cargo) == 0 || _vehicle distance2D _dest < 150)
			};

			if (alive _vehicle && count ([_vehicle, _pilots] call taxi_cargo) > 0) then {
				[_vehicle] call taxi_land;
				sleep 1;
				deleteVehicle _helipad;
				deleteMarkerLocal "taxi_dz";
				waitUntil {[_vehicle] call taxi_outboard};
				_vehicle lock 2;

				// Go back
				sleep 5;
				hintSilent localize "STR_TAXI_RETURN";
				[_air_grp, zeropos] call taxi_dest;
				(driver _vehicle) doMove zeropos;
				sleep 10;
				waitUntil {
					sleep 3;
					_speed = round (speed _vehicle);
					if (_speed == 0) then {
						_vehicle setpos (getPos _vehicle vectorAdd [0, 0, 2]);
					};
					_speed >= 10
				};
			};
		};
	};
};

// Cleanup
hintSilent "";
deleteMarkerLocal "taxi_lz";
deleteMarkerLocal "taxi_dz";
deleteVehicle _helipad;
sleep 60;
{deletevehicle _x} forEach _pilots;
deleteVehicle _vehicle;
player setVariable ["GRLIB_taxi_called", nil, true];
