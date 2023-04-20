// Heli Taxi Script
private _taxi = player getVariable ["GRLIB_taxi_called", nil];
if (!isNil "_taxi") exitWith {hintSilent "Sorry, Only one Taxi at time."};

//check dest place
buildtype = 9;
build_unit = ["Land_HelipadSquare_F",[],1,[],[]];
dobuild = 1;

waitUntil { sleep 1; dobuild == 0};
private _helipad = nearestObjects [player, ["Land_HelipadSquare_F"], 200] select 0;
private _degree = aCos ([0,0,1] vectorCos (surfaceNormal getPos _helipad));
private _dest = getPosATL _helipad;
if (surfaceIsWater _dest || _degree > 8) exitWith {deleteVehicle _helipad; hintSilent "Sorry, Taxi cannot Land on this place."};

// Taxi functions
taxi_land = {
	params ["_vehicle"];
	hintSilent "Taxi Landing...";
	waitUntil {_vehicle land "LAND"; sleep 10; isTouchingGround _vehicle};
	hintSilent "Taxi Landed.";
	deleteVehicle _helipad;
};

taxi_dest = {
	params ["_air_grp", "_dest"];
	_waypoint = _air_grp addWaypoint [ _dest, 1];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "FULL";
	_waypoint setWaypointBehaviour "AWARE";
	_waypoint setWaypointCombatMode "GREEN" ;
};

// Heli Taxi Type
_taxi_type_2 = [
	"C_Heli_light_01_blue_F",
	"C_Heli_light_01_red_F",
	"C_Heli_light_01_ion_F",
	"C_Heli_light_01_blueLine_F",
	"C_Heli_light_01_digital_F",
	"C_Heli_light_01_elliptical_F",
	"C_Heli_light_01_furious_F",
	"C_Heli_light_01_graywatcher_F",
	"C_Heli_light_01_jeans_F",
	"C_Heli_light_01_light_F",
	"C_Heli_light_01_shadow_F",
	"C_Heli_light_01_sheriff_F",
	"C_Heli_light_01_speedy_F",
	"C_Heli_light_01_sunset_F",
	"C_Heli_light_01_vrana_F",
	"C_Heli_light_01_wasp_F",
	"C_Heli_light_01_wave_F",
	"C_Heli_light_01_stripped_F",
	"C_Heli_light_01_luxe_F"
];

_taxi_type_6 = [
	"I_Heli_light_03_unarmed_F",
	"I_E_Heli_light_03_unarmed_F"
];

_taxi_type_8 = [
	"O_Heli_Light_02_unarmed_F",
	"O_Heli_Light_02_v2_F",
	"B_Heli_Transport_01_F",
	"B_Heli_Transport_01_camo_F"
];

_taxi_type_14 = [
	"B_Heli_Transport_03_unarmed_green_F",
	"B_Heli_Transport_03_black_F",
	"I_Heli_Transport_02_F"
];

private _nb_unit = count (units player);
private _taxi_type = "";

if (_nb_unit <= 2) then {_taxi_type = _taxi_type_2 call BIS_fnc_selectRandom};
if (_nb_unit > 2 && _nb_unit <= 6) then {_taxi_type = _taxi_type_6 call BIS_fnc_selectRandom};
if (_nb_unit > 6 && _nb_unit <= 8) then {_taxi_type = _taxi_type_8 call BIS_fnc_selectRandom};
if (_nb_unit > 8) then {_taxi_type = _taxi_type_14 call BIS_fnc_selectRandom};

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
_vehicle allowDamage false;
_vehicle flyInHeight (100 + (random 60));

createVehicleCrew _vehicle;
sleep 1;
_pilots = crew _vehicle;
{ _x addMPEventHandler ["MPKilled", {_this spawn kill_manager}] } foreach _pilots;
_pilots joinSilent _air_grp;
player setVariable ["GRLIB_taxi_called", _vehicle, true];
hintSilent "Air Taxi Called !";

// Goto Pickup Point
[_air_grp, _dest] call taxi_dest;
waitUntil {
  sleep 5;
  isNil{hintSilent format ["Taxi on the way!\nDistance: %1m", round (_vehicle distance2D _dest)]};
  (!alive _vehicle || _vehicle distance2D _dest < 200)
};

if (alive _vehicle && alive player) then {
	[_vehicle] call taxi_land;
	hintSilent "Taxi Landed.\nWaiting for passengers.\nYou have 5 minutes!";

	// Pickup Marker
	_marker = createMarkerLocal ["taxi_lz", getPos _vehicle];
	_marker setMarkerShapeLocal "ICON";
	_marker setMarkerTypeLocal "mil_pickup";
	_marker setMarkerTextlocal "Taxi PickUp";

	_stop = time + (5 * 60); // wait 5min max
	waitUntil {
		sleep 1;
		(!alive _vehicle || vehicle player == _vehicle || time > _stop)
	};

	if (time < _stop && alive _vehicle) then {

		_idact_dest = _vehicle addAction ["<t color='#8000FF'>-- TAXI Destination</t>","addons\TAXI\taxi_dest.sqf","",999,true,true,"","vehicle _this == _target"];
		waitUntil {
			sleep 1;
			(!alive _vehicle || !alive player || (markerPos "taxi_dz") distance2D zeropos > 100)
		};
		_vehicle removeAction _idact_dest;
		deleteMarkerLocal "taxi_lz";

		if (alive _vehicle && alive player && vehicle player == _vehicle) then {
			hintSilent "Ok, let's go...";
			_dest = markerPos "taxi_dz";
			[_air_grp, _dest] call taxi_dest;

			waitUntil {
				sleep 5;
				isNil{hintSilent format ["Taxi transport...\nDestination: %1m", round (_vehicle distance2D _dest)]};
				(!alive _vehicle || vehicle player != _vehicle || _vehicle distance2D _dest < 100)
			};

			if (alive _vehicle && vehicle player == _vehicle) then {
				[_vehicle] call taxi_land;
				_outboarded = {
					params ["_vehicle"];
					_ret = true;
					{
						if ( vehicle _x == _vehicle) then {
							unassignVehicle _x;
							commandGetOut _x;
							doGetOut _x;
							_ret = false
						};
					} forEach units player;
					_ret;
				};
				waitUntil {sleep 1; [_vehicle] call _outboarded};
				_vehicle lock 2;

				hintSilent "Return to Airbase.\nBye, bye...";
				// Go back
				[_air_grp, zeropos] call taxi_dest;
			};
		};
	};
};

// Cleanup
hintSilent "";
deleteMarkerLocal "taxi_lz";
deleteMarkerLocal "taxi_dz";
sleep 60;
{deletevehicle _x} forEach _pilots;
deleteVehicle _vehicle;
deleteVehicle _helipad;
player setVariable ["GRLIB_taxi_called", nil, true];
