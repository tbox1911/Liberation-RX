if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_tank", "_targetPos", "_vehicleName", "_smoke", "_managed_units"];

_setupVars = {
	_missionType = "STR_VEHICLEREP";
	_locationsArray = [LRX_MissionMarkersMil] call checkSpawn;
	_ignoreAiDeaths = true;
};

_setupObjects = {
	private _opfor_tank = selectRandom (opfor_vehicles select { _x isKindOf "Tank_F" });
	if (isNil "_opfor_tank") exitWith {
		diag_log format ["--- LRX Error: side mission %1, cannot find vehicle classname!", localize _missionType];
		false;
	};

	// find road
	_missionPos = [];
	_targetPos = markerpos _missionLocation;
	private	_found = false;
	private _idx = 200;
	while {!_found && _idx > 0} do {
		private _pos_check = ([_targetPos, GRLIB_sector_size] call F_getRandomPos);
		if (isOnRoad _pos_check) then {
			_missionPos = _pos_check;
			_found = true;
		};
		_idx = _idx - 1;
	};
	if (count _missionPos == 0) exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
    	false;
	};

	_tank = [_missionPos, _opfor_tank, 5, false, GRLIB_side_friendly, true, true] call F_libSpawnVehicle;
	_tank setVariable ["GRLIB_vehicle_owner", "server", true];
	_tank lockCargo true;
	{ _tank lockTurret [_x, true] } forEach (allTurrets _tank);
	_tank setVehicleAmmo 0;
	_tank setFuel 0;
	_smoke = GRLIB_sar_fire createVehicle (getPos _tank);
	_smoke attachTo [_tank, [0, 1.5, 0]];
	_managed_units = crew _tank;
	_tank_driver = driver _tank;
	_last_dead_pos = [];
	{
		if (_x != _tank_driver) then {
			_x setPos ([_tank, 10] call F_getRandomPos);
			_x setDamage 1;
			_last_dead_pos = getPosATL _x;
			sleep 0.1;
		};
	} forEach _managed_units;

	_toolbox_pos = (_last_dead_pos getPos [2, floor random 360]);
	_toolbox = createVehicle ["GroundWeaponHolder", _toolbox_pos, [], 0, "CAN_COLLIDE"];
	_toolbox addItemCargoGlobal ["ToolKit", 1];
	_toolbox setPosATL _toolbox_pos;
	_managed_units append [_toolbox];

	waitUntil {sleep 1; isNil {_tank getVariable "GRLIB_vehicle_init"}};
	_tank setHitPointDamage ["HitEngine", 1];
	_tank_driver allowDamage false;
	_tank allowCrewInImmobile [true, true];
	_tank setUnloadInCombat [false, false];

	// waypoints
	private _tank_grp = group (driver _tank);
	_tank_grp setBehaviourStrong "AWARE";
	_tank_grp setCombatMode "WHITE";
	_tank_grp setSpeedMode "LIMITED";

	[_tank_grp] call F_deleteWaypoints;
	private _waypoint = _tank_grp addWaypoint [_targetPos, 10];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointBehaviour "AWARE";
	_waypoint setWaypointCombatMode "WHITE";
	_waypoint setWaypointCompletionRadius 30;

	// manage mission
	[_tank, _targetPos] spawn {
		params ["_tank", "_targetPos"];
		waitUntil {sleep 1; !alive _tank || (_tank getHitPointDamage "HitEngine" < 1)};
		if (!alive _tank) exitWith {};
		_tank setFuel 1;
		_tank engineOn true;
		_tank_driver = driver _tank;
		_tank_driver doMove _targetPos;

		// loop
		private ["_spawn_pos","_grp"];
		while {alive _tank && (_tank distance2D _targetPos > 50)} do {
			_last_tank_pos = getPosATL _tank;
			waitUntil {sleep 1; (_tank distance2D _last_tank_pos > 150)};
			_tank setHitPointDamage ["HitEngine", 1];
			_tank setFuel 0;
			_tank engineOn false;
			_spawn_pos = ([_tank, 200] call F_getRandomPos);
			_grp = [_spawn_pos, ([] call getNbUnits), "militia", false] call createCustomGroup;
			[_grp, _tank] spawn battlegroup_ai_direct;
			sleep 30;
			waitUntil {sleep 1; (_tank getHitPointDamage "HitEngine" < 1)};
			_tank setFuel 1;
			_tank engineOn true;
			_tank_driver doMove _targetPos;
		};
	};

	_missionPicture = getText (configOf _tank >> "picture");
	_vehicleName = getText (configOf _tank >> "displayName");
	_missionHintText = ["STR_VEHICLEREP_MESSAGE1", _vehicleName, sideMissionColor];
	true;
};

_waitUntilExec = nil;
_waitUntilMarkerPos = { getPosATL _tank };
_waitUntilSuccessCondition = { (alive _tank && (_tank distance2D _targetPos < 50)) };
_waitUntilCondition = { !(alive _tank) };

_failedExec = {
	// Mission failed
	deleteVehicle _smoke;
	{deleteVehicle _x} forEach _managed_units;
	deleteVehicle _tank;	
};

_successExec = {
	// Mission completed
	deleteVehicle _smoke;
	{deleteVehicle _x} forEach _managed_units;
	[_tank, "abandon"] call F_vehicleLock;
	_successHintMessage = ["STR_VEHICLEREP_MESSAGE2", _vehicleName];
};

_this call sideMissionProcessor;
