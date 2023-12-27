// Heli Taxi Script
if (GRLIB_player_fobdistance < (2 * GRLIB_fob_range) || GRLIB_player_near_lhd) exitWith {hintSilent localize "STR_TAXI_TOO_CLOSE"};
private _taxi = player getVariable ["GRLIB_taxi_called", nil];
if (!isNil "_taxi") exitWith {hintSilent localize "STR_TAXI_ONLY_ONE"};

//check dest place
buildtype = 9;
build_unit = [taxi_helipad_type,[],1,[],[],[],[]];
dobuild = 1;

waitUntil { sleep 0.5; dobuild == 0};
if (build_confirmed == 3) exitWith {};

GRLIB_taxi_helipad = build_vehicle;
GRLIB_taxi_helipad_created = true;

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

// Create Taxi
private _spawn_sector = ([sectors_airspawn, [_dest], {(markerpos _x) distance2D _input0}, "ASCEND"] call BIS_fnc_sortBy) select 0;
private _spawn_pos = markerPos _spawn_sector;
private _vehicle = createVehicle [_taxi_type, _spawn_pos, [], 0, "FLY"];
if (isNil "_vehicle") exitWith { diag_log format ["--- LRX Error: Taxi %1 create failed!", _taxi_type]};
hintSilent format [localize "STR_TAXI_CALLED", getText(configFile >> "cfgVehicles" >> _taxi_type >> "DisplayName")];
[_vehicle] call F_fixModVehicle;

_vehicle flyInHeight 70;
_vehicle setVariable ["GRLIB_vehicle_owner", "server", true];
_vehicle setVariable ["R3F_LOG_disabled", true, true];
_vehicle allowDamage false;
_vehicle allowCrewInImmobile [true, false];
_vehicle setUnloadInCombat [true, false];
_vehicle setVehicleLock "LOCKED";
_vehicle lockCargo true;
_vehicle lockDriver true;
_vehicle lockTurret [[0], true];
_vehicle lockTurret [[0,0], true];

private _air_grp = GRLIB_side_civilian createVehicleCrew _vehicle;
sleep 0.2;
if (count (crew _vehicle) == 0) exitWith { diag_log format ["--- LRX Error: Taxi %1 create crew failed!", _taxi_type]};
(crew _vehicle) joinSilent _air_grp;
{
	_x allowDamage false;
	_x allowFleeing 0;
 } foreach (units _air_grp);
_vehicle setVariable ["GRLIB_vehicle_group", _air_grp];

_air_grp setBehaviour "CARELESS";
_air_grp setCombatMode "GREEN";
_air_grp setSpeedMode "FULL";

// Actions
GRLIB_taxi_cooldown = 0;
private _idact_dest = _vehicle addAction [format ["<t color='#8000FF'>%1</t>", localize "STR_TAXI_ACTION1"], "addons\TAXI\taxi_pickdest.sqf","",999,false,true,"","vehicle _this == _target && (getPosATL _target) distance2D GRLIB_taxi_helipad > 300"];
private _idact_cancel = _vehicle addAction [format ["<t color='#FF0080'>%1</t>", localize "STR_TAXI_ACTION2"], "addons\TAXI\taxi_cancel.sqf","",998,false,true,"","vehicle _this == _target && !(isNil {player getVariable ['GRLIB_taxi_called', nil]})"];
private _idact_eject = _vehicle addAction [format ["<t color='#FF0080'>%1</t>", localize "STR_TAXI_ACTION3"], "addons\TAXI\taxi_eject.sqf","",997,false,true,"","vehicle _this == _target && !GRLIB_taxi_eject && (getPos _target select 2) > 50 && (getPosATL _target) distance2D GRLIB_taxi_helipad > 300"];
player setVariable ["GRLIB_taxi_called", _vehicle, true];

// Pickup Marker
_marker = createMarkerLocal ["taxi_lz", _dest];
_marker setMarkerShapeLocal "ICON";
_marker setMarkerTypeLocal "mil_pickup";
_marker setMarkerTextlocal "Taxi PickUp";

// Goto Pickup Point
[_vehicle, _dest, "STR_TAXI_MOVE"] call taxi_dest;
[_vehicle] call taxi_land;
deleteVehicle GRLIB_taxi_helipad;
_vehicle setVehicleLock "UNLOCKED";
_vehicle lockCargo false;

private _stop = time + (5 * 60); // wait 5min max
waitUntil {
	hintSilent format [localize "STR_TAXI_ARRIVED", round (_stop - time)];
	sleep 1;
	(objectparent player == _vehicle || time > _stop)
};
hintSilent "";

if (time < _stop) then {
	_stop = time + (5 * 60); // wait 5min max
	waitUntil {
		sleep 0.5;
		( (markerPos "taxi_dz") distance2D zeropos > 100 || isNil {player getVariable ["GRLIB_taxi_called", nil]} || time > _stop )
	};

	_vehicle removeAction _idact_cancel;
	deleteMarkerLocal "taxi_lz";

	if ( (markerPos "taxi_dz") distance2D zeropos > 100 ) then {
		titleText ["", "PLAIN"];
		sleep 1;
		for "_i" from 3 to 0 step -1 do {
			titleText [format ["Taxi take off in %1 seconds", _i], "PLAIN"];
			sleep 1;
		};
		titleText ["Ok, let's go...", "PLAIN"];
		hintSilent "Ok, let's go...";
		_vehicle setVehicleLock "LOCKED";
		_vehicle lockCargo true;
		_cargo = [_vehicle] call taxi_cargo;
		{ _x allowDamage false } forEach _cargo;

		_dest = markerPos "taxi_dz";
		[_vehicle, _dest, "STR_TAXI_PROGRESS"] call taxi_dest;
		_vehicle removeAction _idact_dest;
		_vehicle removeAction _idact_eject;

		// Board Out
		[_vehicle] call taxi_land;
		[_vehicle] call taxi_outboard;
		sleep 2;
		{ _x allowDamage true } forEach _cargo;
	};
};

_vehicle setVehicleLock "LOCKED";
_vehicle lockCargo true;
sleep 1;

// Eject cargo
[_vehicle] execVM "addons\TAXI\taxi_eject.sqf";
sleep 1;

// Go back
deleteMarkerLocal "taxi_lz";
deleteMarkerLocal "taxi_dz";
if (GRLIB_taxi_helipad_created) then { deleteVehicle GRLIB_taxi_helipad };
GRLIB_taxi_eject = nil;
GRLIB_taxi_helipad = nil;
hintSilent localize "STR_TAXI_RETURN";
[_vehicle, _spawn_pos, ""] call taxi_dest;

// Cleanup
{deletevehicle _x} forEach (crew _vehicle);
deleteVehicle _vehicle;
deleteGroup _air_grp;
player setVariable ["GRLIB_taxi_called", nil, true];
