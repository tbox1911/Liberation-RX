// Heli Taxi Script
private _taxi = player getVariable ["GRLIB_taxi_called", nil];
if (!isNil "_taxi") exitWith {hintSilent localize "STR_TAXI_ONLY_ONE"};

//check dest place
buildtype = 9;
build_unit = [taxi_helipad_type,[],1,[],[],[]];
dobuild = 1;

waitUntil { sleep 1; dobuild == 0};
if (build_confirmed == 3) exitWith {};

GRLIB_taxi_helipad = nearestObjects [player, [taxi_helipad_type], 20] select 0;
private _degree = aCos ([0,0,1] vectorCos (surfaceNormal getPos GRLIB_taxi_helipad));
private _dest = getPosATL GRLIB_taxi_helipad;
if (surfaceIsWater _dest || _degree > 8) exitWith {deleteVehicle GRLIB_taxi_helipad; hintSilent localize "STR_TAXI_WRONG_PLACE"};

// Pay
if (!([GRLIB_AirDrop_Taxi_cost] call F_pay)) exitWith {deleteVehicle GRLIB_taxi_helipad};

deleteMarkerLocal "taxi_lz";
deleteMarkerLocal "taxi_dz";

private _nb_unit = count (units group player);
private _taxi_type = "";
private _cargo = [];

if (_nb_unit <= 2) then {_taxi_type = selectRandom taxi_type_2};
if (_nb_unit > 2 && _nb_unit <= 6) then {_taxi_type = selectRandom taxi_type_6};
if (_nb_unit > 6 && _nb_unit <= 8) then {_taxi_type = selectRandom taxi_type_8};
if (_nb_unit > 8) then {_taxi_type = selectRandom taxi_type_14};

hintSilent format [localize "STR_TAXI_CALLED", getText(configFile >> "cfgVehicles" >> _taxi_type >> "DisplayName")];

// Create Taxi
private _air_grp = createGroup [GRLIB_side_civilian, true];
private _air_spawnpos = [] call F_getNearestFob;
if (isNil "GRLIB_all_fobs" || count GRLIB_all_fobs == 0) then {
	_air_spawnpos = getPos lhd;
};

_air_spawnpos = [(((_air_spawnpos select 0) + 125) - floor(random 250)),(((_air_spawnpos select 1) + 125) - floor(random 250)), 120];
_vehicle = createVehicle [_taxi_type, _air_spawnpos, [], 0, "FLY"];
if (_taxi_type isKindOf "Heli_Light_01_civil_base_F") then {
	[_vehicle, false, ["AddDoors",1,"AddBackseats",1,"AddTread",1,"AddTread_Short",0]] call BIS_fnc_initVehicle;
};
_vehicle flyInHeight 70;
_vehicle setVariable ["GRLIB_vehicle_owner", "server", true];
_vehicle setVariable ["R3F_LOG_disabled", true, true];
_vehicle allowDamage false;
_vehicle allowCrewInImmobile [true, false];
_vehicle setUnloadInCombat [true, false];

GRLIB_taxi_cooldown = 0;
private _idact_dest = _vehicle addAction [format ["<t color='#8000FF'>%1</t>", localize "STR_TAXI_ACTION1"], "addons\TAXI\taxi_pickdest.sqf","",999,true,true,"","vehicle _this == _target && (getPosATL _target) distance2D GRLIB_taxi_helipad > 300"];
private _idact_cancel = _vehicle addAction [format ["<t color='#FF0080'>%1</t>", localize "STR_TAXI_ACTION2"], {player setVariable ["GRLIB_taxi_called", nil, true]},"",998,true,true,"","vehicle _this == _target"];
player setVariable ["GRLIB_taxi_called", _vehicle, true];

createVehicleCrew _vehicle;
sleep 1;
private _pilots = crew _vehicle;
{
    [_x] orderGetIn true;
	_x allowDamage false;
	_x allowFleeing 0;
 } foreach _pilots;
_pilots joinSilent _air_grp;

_air_grp setBehaviour "CARELESS";
_air_grp setCombatMode "GREEN";
_air_grp setSpeedMode "FULL";

// Pickup Marker
_marker = createMarkerLocal ["taxi_lz", _dest];
_marker setMarkerShapeLocal "ICON";
_marker setMarkerTypeLocal "mil_pickup";
_marker setMarkerTextlocal "Taxi PickUp";

// Goto Pickup Point
[_vehicle, _air_grp, _dest, "STR_TAXI_MOVE"] call taxi_dest;
[_vehicle] call taxi_land;

private _stop = time + (5 * 60); // wait 5min max
waitUntil {
	hintSilent format [localize "STR_TAXI_ARRIVED", round (_stop - time)];
	sleep 1;
	(objectparent player == _vehicle || time > _stop)
};
hintSilent "";

if (time < _stop) then {
	_stop = time + (5 * 60); // wait 5min max
	gamelogic globalChat "Taxi auto return to base in 5 min.";
	waitUntil {
		sleep 0.5;
		( (markerPos "taxi_dz") distance2D zeropos > 100 || isNil {player getVariable ["GRLIB_taxi_called", nil]} || time > _stop )
	};

	_vehicle removeAction _idact_cancel;
	deleteMarkerLocal "taxi_lz";

	if ( (markerPos "taxi_dz") distance2D zeropos > 100 ) then {
		hintSilent "Ok, let's go...";
		_vehicle lock 2;
		_cargo = [_vehicle, _pilots] call taxi_cargo;
		{ _x allowDamage false } forEach (_cargo);

		_dest = markerPos "taxi_dz";
		[_vehicle, _air_grp, _dest, "STR_TAXI_PROGRESS"] call taxi_dest;
		_vehicle removeAction _idact_dest;
		[_vehicle] call taxi_land;
	};
};

// Board Out
_cargo = [_vehicle, _pilots] call taxi_cargo;
_vehicle lock 3;
[_cargo] call taxi_outboard;
{ _x allowDamage true } forEach (_cargo);
sleep 5;

// Go back
deleteMarkerLocal "taxi_lz";
deleteMarkerLocal "taxi_dz";
[_vehicle, _air_grp, zeropos, "STR_TAXI_RETURN"] call taxi_dest;

// Cleanup
hintSilent "";
{deletevehicle _x} forEach _pilots;
deleteVehicle _vehicle;
player setVariable ["GRLIB_taxi_called", nil, true];
