params ["_targetpos", "_side", "_count"];

if (_count == 0) exitWith {};

sleep 5;
private _planeType = opfor_air;
if (_side == GRLIB_side_friendly) then { _planeType = blufor_air };

if (_side == GRLIB_side_enemy) then {
	private _pilots = (units GRLIB_side_friendly) select { (objectParent _x) isKindOf "Air" && (driver vehicle _x) == _x };
	if (count _pilots == 0) then {
		_planeType = opfor_air select { _x isKindOf "Helicopter_Base_F" };
		if (count _planeType == 0) then { _planeType = opfor_air };
	};
};
if (count _planeType == 0) exitWith { diag_log format ["--- LRX Error: Cannot find Air classname in template %1", _side]; };

private _grp = createGroup [_side, true];
private _vehicle = [_targetpos, selectRandom _planeType, 0, _side] call F_libSpawnVehicle;
[_vehicle, 1800] call F_setUnitTTL;
(crew _vehicle) joinSilent _grp;

private _spawnpos = getPosATL _vehicle;
private _radius = 600;
if (_vehicle isKindOf "Plane") then { _radius = 1200 };

[_grp] call F_deleteWaypoints;
private _waypoint = _grp addWaypoint [ _targetpos, _radius];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "COMBAT";
_waypoint setWaypointCombatMode "RED";
_waypoint = _grp addWaypoint [_targetpos, _radius];
_waypoint setWaypointType "MOVE";
_waypoint = _grp addWaypoint [_targetpos, _radius];
_waypoint setWaypointType "MOVE";
_waypoint = _grp addWaypoint [_targetpos, _radius];
_waypoint setWaypointType "MOVE";
_wp0 = waypointPosition [_grp, 0];
_waypoint = _grp addWaypoint [_wp0, 0];
_waypoint setWaypointType "CYCLE";
{_x doFollow leader _grp} foreach units _grp;

_count = _count - 1;
if (_count >= 1) then {	[_targetpos, _side, _count] spawn spawn_air };

if (_side == GRLIB_side_friendly) exitWith {
	sleep 600;
	if ({alive _x} count (units _grp) == 0) exitWith {};
	// Cleanup
	[_grp] call F_deleteWaypoints;
	private _waypoint = _grp addWaypoint [_spawnpos, 0];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "FULL";
	_waypoint setWaypointBehaviour "CARELESS";
	_waypoint setWaypointCombatMode "BLUE";
	_waypoint setWaypointCompletionRadius 300;
	_waypoint setWaypointStatements ["true", "[vehicle this, true, true] spawn F_vehicleClean"];
	{_x doFollow (leader _grp)} foreach units _grp;
	sleep 60;
	if (!alive _vehicle) exitWith {};
	[_vehicle, true, true] spawn F_vehicleClean;
};

private _hc = [] call F_lessLoadedHC;
if (isDedicated && !isNull _hc) then {
	_grp setGroupOwner (owner _hc);
};

diag_log format ["Spawn Air Squad %1 objective %2 at %3", typeOf _vehicle, _targetpos, time];
sleep 60;

private _bombs = ["Bomb_03_F","Bomb_04_F","Bo_GBU12_LGB","Bo_GBU12_LGB_MI10","Bo_Mk82","Bo_Mk82_MI08"];
private _timer = time + 600;
while { alive _vehicle && ({alive _x} count (units _grp) > 0) && (GRLIB_endgame == 0) && time <= _timer } do {
	if (_vehicle isKindOf "Plane" && (GRLIB_SOG_enabled || GRLIB_SPE_enabled)) then {
		// Bombers AI (for slow aircraft)
		private _plane_dir = getDir _vehicle;
		private _spot = _vehicle getPos [1000, _plane_dir];
		if ([_spot, 80, GRLIB_side_friendly] call F_getUnitsCount > 0) then {
			_vehicle action ["useWeapon", _vehicle, driver _vehicle, selectRandom [10, 11]];
			_bomb = createVehicle [(selectRandom _bombs), ((getPos _vehicle) vectorAdd [0, 0, -40]), [], 5, "FLY"];
			_bomb setDir _plane_dir;
			_bomb setVelocity (velocity _vehicle);
			sleep 0.5;
			_vehicle action ["useWeapon", _vehicle, driver _vehicle, selectRandom [10, 11]];
			_bomb = createVehicle [(selectRandom _bombs), ((getPos _vehicle) vectorAdd [0, 0, -40]), [], 5, "FLY"];
			_bomb setDir _plane_dir;
			_bomb setVelocity (velocity _vehicle);
			sleep 0.5;
			_vehicle action ["useWeapon", _vehicle, driver _vehicle, selectRandom [10, 11]];
			_bomb = createVehicle [(selectRandom _bombs), ((getPos _vehicle) vectorAdd [0, 0, -40]), [], 5, "FLY"];
			_bomb setDir _plane_dir;
			_bomb setVelocity (velocity _vehicle);
			sleep 60;
		};
		sleep 3;
	} else {
		// Modern aircraft AI
		_target = [_targetpos, GRLIB_sector_size] call F_getNearestBlufor;
		if (!isNull _target) then {
			(gunner _vehicle) reveal [_target, 4];
			(gunner _vehicle) doTarget _target;
			sleep 120;
		};
		// private _plane_dir = getDir _vehicle;
		// private _spot = _vehicle getPos [1500, _plane_dir];
		// if ([_spot, 150, GRLIB_side_friendly] call F_getUnitsCount > 2) then {
		// 	_round = "Cluster_155mm_AMOS" createVehicle (getPos _vehicle);
		// 	[_round, -80, 0] call BIS_fnc_setPitchBank;
		// 	_round setVelocity [0,0,-100];
		// };
		sleep 60;
	};
	_vehicle setVehicleAmmo 1;
	_vehicle setFuel 1;
};

if ({alive _x} count (units _grp) == 0) exitWith {};

// Cleanup
[_grp] call F_deleteWaypoints;
private _waypoint = _grp addWaypoint [_spawnpos, 0];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "CARELESS";
_waypoint setWaypointCombatMode "BLUE";
_waypoint setWaypointCompletionRadius 300;
_waypoint setWaypointStatements ["true", "[vehicle this, true, true] spawn F_vehicleClean"];
{_x doFollow (leader _grp)} foreach units _grp;
sleep 60;
if (!alive _vehicle) exitWith {};
[_vehicle, true, true] spawn F_vehicleClean;
