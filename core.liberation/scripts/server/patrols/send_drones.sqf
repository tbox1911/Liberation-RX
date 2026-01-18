params ["_targetpos", "_count"];

if (combat_readiness <= 50) exitWith {};
if (count uavs_vehicles == 0) exitWith {};

if (_count == 0) exitWith {};
if (_count > 1) then {
	sleep 15;
	[_targetpos, _count - 1] spawn send_drones;
};

private _uav_light = "O_UAV_01_F";
private _uav_bomb = "O_UAV_06_F";
if (GRLIB_side_enemy == WEST) then {
	_uav_light = "B_UAV_01_F";
	_uav_bomb = "B_UAV_06_F";
};
private _uav_classname = _uav_light;
private _radius = round (80 + floor random 100);
private _kamikaze = (floor random 100 >= 80);
if (_kamikaze) then {
	_radius = round (1200 + floor random 100);
	_uav_classname = _uav_bomb;
};

private _spawn_pos = [_targetpos, _radius] call F_getRandomPos;
private _airveh_alt = (60 + floor random 50);
_spawn_pos set [2, _airveh_alt];

// create uav
private _vehicle = createVehicle [_uav_classname, _spawn_pos, [], 50, "FLY"];
_vehicle allowDamage false;
_vehicle setDir (_vehicle getDir _targetpos);
_vehicle setPos _spawn_pos;
_vehicle setVelocityModelSpace [0, 80, 0];
private _grp = [_vehicle, GRLIB_side_enemy] call F_forceCrew;
_vehicle engineOn true;
_vehicle flyInHeight _airveh_alt;
_vehicle addMPEventHandler ['MPKilled', {_this spawn kill_manager}];
_vehicle addEventHandler ["HandleDamage", { _this call damage_manager_enemy }];
_vehicle setVariable ["GRLIB_vehicle_reward", true, true];
[_vehicle, 1800] call F_setUnitTTL;
[_grp] call F_deleteWaypoints;
sleep 0.5;
_vehicle allowDamage true;

private _uav_role = 1;
if (_kamikaze) then {
	_uav_role = 0;
	_waypoint = _grp addWaypoint [_targetpos, 100];
	_waypoint setWaypointType "MOVE";
} else {
	[_grp, _targetpos] call patrol_ai_uavs;
};
_grp setCombatMode "WHITE";
_grp setSpeedMode "FULL";

diag_log format ["--- LRX Enemy Drones - type: %1 target: %2", _uav_role, _targetpos];
sleep 20;

// UAV logic
private ["_target"];
while {alive _vehicle} do {
	// kamikaze + bomb
	if (_uav_role == 0) then {
		_target = [_targetpos, 300] call F_getNearestBlufor;
		if (isNull _target) then {
			{deleteVehicle _x} forEach (crew _vehicle);
			deleteVehicle _vehicle;
		} else {
			deleteWaypoint [_grp, 0];
			_waypoint = _grp addWaypoint [(getPosATL _target), 10];
			_waypoint setWaypointType "MOVE";
			sleep 2;
			waitUntil {
				private _dist = _vehicle distance2D _target;
				if (_dist < 35) then {
					(driver _vehicle) doMove (getPosATL _target);
				} else {
					(driver _vehicle) doMove (getPos _target);
				};
				if (_dist <= 300) then { _vehicle flyInHeight 50 };
				sleep 2;
				(_dist <= 40 || _dist >= 300 || !alive _vehicle)
			};
			if (!alive _vehicle) exitWith {};
			if (_vehicle distance2D _target <= 40) then {
				sleep 1;
				private _bomb = "DemoCharge_Remote_Ammo" createVehicle zeropos;
				_bomb attachTo [_vehicle, [0, 0, 0]];
				_bomb setVectorDirAndUp [[0.5, 0.5, 0], [-0.5, 0.5, 0]];
				_vehicle setDir (_vehicle getDir _target);
				[_vehicle, -70, 0] call BIS_fnc_setPitchBank;
				_vehicle setVelocity [0,0,-100];
				sleep 20;
			};
		};
	};

	// lanch grenades
	if (_uav_role == 1) then {
		_target = [_vehicle, 200] call F_getNearestBlufor;
		if (!isNull _target) then {
			[_grp] call F_deleteWaypoints;
			waitUntil {
				private _dist = _vehicle distance2D _target;
				if (_dist < 35) then {
					(driver _vehicle) doMove (getPosATL _target);
				} else {
					(driver _vehicle) doMove (getPos _target);
				};
				if (_dist <= 200) then { _vehicle flyInHeight 50 };
				sleep 2;
				(_dist <= 20 || _dist >= 300 || !alive _vehicle)
			};
			if !(alive _vehicle) exitWith {};
			if (_vehicle distance2D _target <= 20) then {
				private _pos = getPosATL _vehicle;
				_pos set [2, 60];
				"R_MRAAWS_HE_F" createVehicle _pos;
			};
			sleep 2;
			_vehicle flyInHeight _airveh_alt;
			[_grp, _targetpos] call patrol_ai_uavs;
			sleep 60;
		};
	};

	sleep 1;
};


