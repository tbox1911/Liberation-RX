params ["_targetpos", "_side", "_count"];

if (_count == 0) exitWith {};
if (_count > 1) then {
	sleep 10;
	[_targetpos, _side, _count - 1] spawn spawn_air;
};

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
_grp setBehaviourStrong "COMBAT";
_grp setCombatMode "YELLOW";
_grp setSpeedMode "FULL";

private _spawnpos = getPosATL _vehicle;
private _radius = 600;
if (_vehicle isKindOf "Plane") then { _radius = 1200 };

[_grp] call F_deleteWaypoints;
private _waypoint = _grp addWaypoint [ _targetpos, _radius];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "COMBAT";
_waypoint setWaypointCombatMode "YELLOW";
_waypoint = _grp addWaypoint [ _targetpos, _radius];
_waypoint setWaypointType "MOVE";
_waypoint = _grp addWaypoint [ _targetpos, _radius];
_waypoint setWaypointType "MOVE";
_wp0 = waypointPosition [_grp, 0];
_waypoint = _grp addWaypoint [_wp0, 0];
_waypoint setWaypointType "CYCLE";
{_x doFollow leader _grp} foreach units _grp;

if (_side == GRLIB_side_friendly) exitWith {
	private _msg = format ["Air support %1 incoming...", [typeOf _vehicle] call F_getLRXName];
	[gamelogic, _msg] remoteExec ["globalChat", 0];
};
diag_log format ["Spawn Air Squad %1 objective %2 at %3", typeOf _vehicle, _targetpos, time];

if (_vehicle isKindOf "Plane" && (GRLIB_SOG_enabled || GRLIB_SPE_enabled)) then {
	// Bombers AI (for slow aircraft)
	[_vehicle] spawn {
		params ["_plane"];
		private _bombs = ["Bomb_03_F","Bomb_04_F","Bo_GBU12_LGB","Bo_GBU12_LGB_MI10","Bo_Mk82","Bo_Mk82_MI08"];
		sleep 30;
		while { alive _plane } do {
			private _plane_dir = getDir _plane;
			private _spot = _plane getPos [1000, _plane_dir];
			if ([_spot, 80, GRLIB_side_friendly] call F_getUnitsCount > 0) then {
				_plane action ["useWeapon", _plane, driver _plane, selectRandom [10, 11]];
				_bomb = createVehicle [(selectRandom _bombs), ((getPos _plane) vectorAdd [0, 0, -40]), [], 5, "FLY"];
				_bomb setDir _plane_dir;
				_bomb setVelocity (velocity _plane);
				sleep 0.5;
				_plane action ["useWeapon", _plane, driver _plane, selectRandom [10, 11]];
				_bomb = createVehicle [(selectRandom _bombs), ((getPos _plane) vectorAdd [0, 0, -40]), [], 5, "FLY"];
				_bomb setDir _plane_dir;
				_bomb setVelocity (velocity _plane);
				sleep 0.5;
				_plane action ["useWeapon", _plane, driver _plane, selectRandom [10, 11]];
				_bomb = createVehicle [(selectRandom _bombs), ((getPos _plane) vectorAdd [0, 0, -40]), [], 5, "FLY"];
				_bomb setDir _plane_dir;
				_bomb setVelocity (velocity _plane);
				_plane setVehicleAmmo 1;
				sleep 60;
			};
			sleep 3;
		};
	};
} else {
	// Modern aircraft AI
	[_vehicle] spawn {
		params ["_plane"];
		sleep 30;
		while { alive _plane } do {
			private _blu_target = (units GRLIB_side_friendly) select { _x distance2D _plane <= GRLIB_spawn_max };
			if (count _blu_target > 0) then {
				(gunner _plane) reveal [(_blu_target select 0), 4];
				(gunner _plane) doTarget (_blu_target select 0);
				sleep 120;
			};
			// private _plane_dir = getDir _plane;
			// private _spot = _plane getPos [1500, _plane_dir];
			// if ([_spot, 150, GRLIB_side_friendly] call F_getUnitsCount > 2) then {
			// 	_round = "Cluster_155mm_AMOS" createVehicle (getPos _plane);
			// 	[_round, -80, 0] call BIS_fnc_setPitchBank;
			// 	_round setVelocity [0,0,-100];
			// 	sleep 60;
			// };
			sleep 3;
		};
	};
};

private _hc = [] call F_lessLoadedHC;
if (isDedicated && !isNull _hc) then {
	_grp setGroupOwner (owner _hc);
};

sleep 300;

while { ({alive _x} count (units _grp) > 0) && (GRLIB_endgame == 0) && count _targetpos > 0 } do {
	_pilots = allPlayers select { (objectParent _x) isKindOf "Air" && (driver vehicle _x) == _x };
	if (count _pilots > 0) then {
		_targetpos = getPos (selectRandom _pilots);
	} else {
		_targetpos = [];
	};
	if (count _targetpos == 0) exitWith {};

	[_grp] call F_deleteWaypoints;
	_waypoint = _grp addWaypoint [_targetpos, _radius];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "FULL";
	_waypoint setWaypointBehaviour "COMBAT";
	_waypoint setWaypointCombatMode "YELLOW";
	_waypoint = _grp addWaypoint [_targetpos, _radius];
	_waypoint setWaypointType "MOVE";
	_waypoint = _grp addWaypoint [_targetpos, _radius];
	_waypoint setWaypointType "MOVE";
	_waypoint = _grp addWaypoint [_targetpos, _radius];
	_waypoint setWaypointType "MOVE";
	_wp0 = waypointPosition [_grp, 0];
	_waypoint = _grp addWaypoint [_wp0, 0];
	_waypoint setWaypointType "CYCLE";
	(units _grp) doFollow leader _grp;

	_vehicle setFuel 1;
	_vehicle setVehicleAmmo 1;
	sleep 360;
};

if ({alive _x} count (units _grp) == 0) exitWith {};

// Cleanup
[_grp] call F_deleteWaypoints;
private _waypoint = _grp addWaypoint [_spawnpos, 0];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "COMBAT";
_waypoint setWaypointCombatMode "YELLOW";
_waypoint setWaypointCompletionRadius 400;
_waypoint setWaypointStatements ["true", "[vehicle this, true, true] spawn F_vehicleClean"];
{_x doFollow (leader _grp)} foreach units _grp;