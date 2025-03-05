params ["_targetpos", "_kamikaze", "_count"];

if (combat_readiness <= 50) exitWith {};
if (count uavs_vehicles == 0) exitWith {};

if (_count == 0) exitWith {};
if (_count > 1) then {
	sleep 20;
	[_targetpos, _kamikaze, _count - 1] spawn send_drones;
};

private _uav_classname = selectRandom ["O_UAV_01_F", "O_UAV_06_F"];
if (GRLIB_side_enemy == WEST) then {
	_uav_classname = selectRandom ["B_UAV_01_F", "B_UAV_06_F"];
};

// create uav
private _grp = createGroup [GRLIB_side_enemy, true];
private _radius = round (80 + floor random 100);
private _spawn_pos = _targetpos getPos [_radius, 360];
if (_kamikaze) then { _spawn_pos = [_targetpos] call F_getAirSpawn };
private _airveh_alt = (120 + floor random 50);
_spawn_pos set [2, _airveh_alt];
private _vehicle = createVehicle [_uav_classname, _spawn_pos, [], 50, "FLY"];
_vehicle allowDamage false;
_vehicle setDir (_vehicle getDir _targetpos);
_vehicle setPosATL _spawn_pos;
_vehicle setVelocityModelSpace [0, 80, 0];
[_vehicle, GRLIB_side_enemy] call F_forceCrew;
_vehicle engineOn true;
_vehicle flyInHeight _airveh_alt;
_vehicle addMPEventHandler ['MPKilled', {_this spawn kill_manager}];
_vehicle addEventHandler ["HandleDamage", { _this call damage_manager_enemy }];
_vehicle setVariable ["GRLIB_vehicle_reward", true, true];
_vehicle setVariable ["GRLIB_counter_TTL", round(time + 1800), true];  // 30 minutes TTL
(crew _vehicle) joinSilent _grp;
_grp setCombatMode "BLUE";
_grp setSpeedMode "NORMAL";
sleep 0.5;
_vehicle allowDamage true;

private _uav_role = 1;
if (_kamikaze) then {
	_uav_role = 0;
} else {
	[_grp, _targetpos] call patrol_ai_uavs;
	if (floor random 4 == 0) then { _uav_role = 0 };
};
sleep 5;

diag_log format ["--- LRX Enemy Drones - type: %1 target: %2", _uav_role, _targetpos];
// UAV logic
private ["_target"];
while {alive _vehicle} do {
	// kamikaze + bomb
	if (_uav_role == 0) then {
		_target = [_targetpos, 150] call F_getNearestBlufor;
		if (!isNil "_target") then {
			_grp setSpeedMode "FULL";
			(driver _vehicle) doMove (getPos _target);
			sleep 20;
			waitUntil {
				(driver _vehicle) doMove (getPos _target);
				sleep 1;
				private _dist = _vehicle distance2D _target;
				if (_dist <= 600) then { _vehicle flyInHeight 50 };
				if (!alive _target) then { _target = [_targetpos, 150] call F_getNearestBlufor };
				(_dist <= 15 || !alive _vehicle || isNil "_target")
			};
			if (!alive _vehicle || isNil "_target") exitWith {};
			private _bomb = "DemoCharge_Remote_Ammo" createVehicle zeropos;
			_bomb attachTo [_vehicle, [0, 0, 0]];
			_bomb setVectorDirAndUp [[0.5, 0.5, 0], [-0.5, 0.5, 0]];
			sleep 1;
			_vehicle setDir (_vehicle getDir _target);
			[_vehicle, -80, 0] call BIS_fnc_setPitchBank;
			_vehicle setVelocity [0,0,-100];
			sleep 20;
		};
		deleteVehicle _vehicle;
	};

	// lanch grenades
	if (_uav_role == 1) then {
		_target = [_vehicle, 120] call F_getNearestBlufor;
		if (!isNil "_target") then {
			[_grp] call F_deleteWaypoints;
			_grp setCombatMode "YELLOW";
			_grp setSpeedMode "LIMITED";
			waitUntil {
				(driver _vehicle) doMove (getPos _target);
				sleep 1;
				(_vehicle distance2D _target <= 15 || _vehicle distance2D _target >= 100 || !alive _vehicle)
			};
			if !(alive _vehicle) exitWith {};
			if (_vehicle distance2D _target <= 15) then {
				private _round = "GrenadeHand" createVehicle (getPosATL _vehicle);
				[_round, -90, 0] call BIS_fnc_setPitchBank;
				_round setVelocity [0,0,-50];
				sleep 1;
				_round = "GrenadeHand" createVehicle (getPosATL _vehicle);
				[_round, -90, 0] call BIS_fnc_setPitchBank;
				_round setVelocity [0,0,-50];
			};
			sleep 2;
			[_grp, _targetpos] call patrol_ai_uavs;
			_grp setCombatMode "BLUE";
			_grp setSpeedMode "NORMAL";
			sleep 60;
		};
	};

	sleep 1;
};


