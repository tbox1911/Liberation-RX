if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_guard_grp", "_detected"];

_setupVars = {
	_missionType = "STR_ROADBLOCK";
	_locationsArray = nil;
	_precise_marker = false;
	_detected = false;
};

_setupObjects = {
	private ["_bunker", "_def1", "_def2", "_veh1", "_veh2"];
	// find a pos near a road, between opfor and blufor sector
	_missionPos = [];
	private	_found = false;
	private _road_dir = 0;
	{
		_sector_pos = markerPos _x;
		private _next_objective = [_sector_pos] call F_getNearestBluforObjective;
		private _next_objective_dist = _next_objective select 1;
		if (_next_objective_dist >= GRLIB_sector_size && _next_objective_dist <= GRLIB_spawn_max) then {
			private _idx = 200;
			while {!_found && _idx > 0} do {
				private _pos_check = ([_sector_pos, GRLIB_sector_size] call F_getRandomPos);
				if ((!isOnRoad _pos_check) && (!surfaceIsWater _pos_check)) then {
					private _roads = (_pos_check nearRoads 15) select { (getRoadInfo _x select 0) in ["TRACK","ROAD","MAIN ROAD"] };
					if (count _roads > 0) exitWith {
						_found = true;
						_missionPos = _pos_check;
						_road_dir = _pos_check getDir (_roads select 0);
					};
				};
				_idx = _idx - 1;
			};
		};
		if (_found) exitWith {};
	} forEach ((opfor_sectors - sectors_tower) call BIS_fnc_arrayShuffle);

	if (count _missionPos == 0) exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
    	false;
	};

	//----- build Check point ---------------------------------
	private _bunker_typename = selectRandom ["Land_BagBunker_Small_F"];
	_bunker = createVehicle [_bunker_typename, _missionPos, [], 0, "None"];
	_bunker setVectorDirAndUp [[-cos (_road_dir - 180), sin (_road_dir - 180), 0] vectorCrossProduct surfaceNormal _missionPos, surfaceNormal _missionPos];

	private _bunker_dir = (90 + getdir _bunker);
	private _def1_pos = (getPosATL _bunker) vectorAdd ([[0, 12, 0], -_bunker_dir] call BIS_fnc_rotateVector2D);
	_def1 = createVehicle ["Land_BagFence_Round_F", _def1_pos, [], 1, "None"];
	_def1 setVectorDirAndUp [[-cos (_bunker_dir - 180), sin (_bunker_dir - 180), 0] vectorCrossProduct surfaceNormal _def1_pos, surfaceNormal _def1_pos];
	_def1 setPosATL _def1_pos;

	private _def2_pos = (getPosATL _bunker) vectorAdd ([[0, -12, 0], -_bunker_dir] call BIS_fnc_rotateVector2D);
	_def2 = createVehicle ["Land_BagFence_Round_F", _def2_pos, [], 1, "None"];
	_def2 setVectorDirAndUp [[-cos _bunker_dir, sin _bunker_dir, 0] vectorCrossProduct surfaceNormal _def2_pos, surfaceNormal _def2_pos];
	_def2 setPosATL _def2_pos;

	// R3F disable
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_bunker, _def1, _def2];

	private _veh1_pos = (getPosATL _def1) vectorAdd ([[0, -1, 0.1], - _bunker_dir] call BIS_fnc_rotateVector2D);
	_veh1 = createVehicle [selectRandom a3w_enemy_static, _veh1_pos, [], 0, "None"];
	_veh1 setVariable ["R3F_LOG_disabled", true, true];
	_veh1 disableCollisionWith _def1;
	_veh1 setDir _bunker_dir;
	_veh1 setPos _veh1_pos;

	private _veh2_pos = (getPosATL _def2) vectorAdd ([[0, 1, 0.1], - _bunker_dir] call BIS_fnc_rotateVector2D);
	_veh2 = createVehicle [selectRandom a3w_enemy_static, _veh2_pos, [], 0, "None"];
	_veh2 setVariable ["R3F_LOG_disabled", true, true];
	_veh2 disableCollisionWith _def2;
	_veh2 setDir (_bunker_dir -180);
	_veh2 setPos _veh2_pos;

	//----- spawn units ---------------------------------
	_guard_grp = [_missionPos, 3, "militia", false] call createCustomGroup;
	private _guard = (units _guard_grp) select 0;
	_guard setPosATL (getPosATL _bunker);
	_guard setUnitPos "UP";
	_guard disableAI "PATH";

	private _gunner1 = (units _guard_grp) select 1;
	_gunner1 assignAsGunner _veh1;
	_gunner1 moveInGunner _veh1;
	//_veh1 setVariable ["GRLIB_vehicle_gunner", [_gunner1, _guard]];

	private _gunner2 = (units _guard_grp) select 2;
	_gunner2 assignAsGunner _veh2;
	_gunner2 moveInGunner _veh2;
	//_veh2 setVariable ["GRLIB_vehicle_gunner", [_gunner2, _guard]];

	_aiGroup = [_missionPos, ([] call getNbUnits), "militia"] call createCustomGroup;
	_vehicles = [_bunker, _def1, _def2, _veh1, _veh2];
	_missionPicture = "\A3\Static_f_gamma\data\ui\gear_StaticTurret_GMG_CA.paa";
	_missionHintText = "STR_ROADBLOCK_MESSAGE1";
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = {
	private _ret = false;
	{
		if (_aiGroup knowsAbout _x == 4 ) then { _ret = true };
	} forEach ([_missionPos, GRLIB_sector_size] call F_getNearbyPlayers);

	if (_ret && !_detected) then {
		_detected = true;
		private _sound = "A3\data_f_curator\sound\cfgsounds\air_raid.wss";
		if (GRLIB_AlarmsEnabled) then {
			playSound3D [_sound, _missionPos, false, ATLToASL _missionPos, 5, 1, 1000];
		};
		sleep 5;
		private _msg = ["<t color='#FFFFFF' size='2'>You have been Detected!!<br/><br/>Enemies launch the </t><t color='#ff0000' size='3'>RED ALERT</t><t color='#FFFFFF' size='2'> !!</t>", "PLAIN", -1, false, true];
		{
			[_msg] remoteExec ["titleText", owner _x];
		} forEach ([_missionPos, GRLIB_sector_size] call F_getNearbyPlayers);
		private _grp = [([_missionPos, 120] call F_getRandomPos), 6, "infantry", false] call createCustomGroup;
		[_grp, _missionPos] spawn battlegroup_ai;
		sleep 5;
		if (GRLIB_AlarmsEnabled) then {
			playSound3D [_sound, _missionPos, false, ATLToASL _missionPos, 5, 1, 1000];
		};
	};
};
_waitUntilCondition = nil;

_failedExec = {
	// Mission failed
	{ deleteVehicle _x } forEach (units _guard_grp);
};

_successExec = {
	// Mission completed
	private _rwd_ammo = (100 + floor(random 100));
	private _rwd_fuel = (10 + floor(random 10));
	private _text = format ["Reward Received: %1 Ammo and %2 Fuel", _rwd_ammo, _rwd_fuel];
	{
		[_x, _rwd_ammo, _rwd_fuel] call ammo_add_remote_call;
		[gamelogic, _text] remoteExec ["globalChat", owner _x];
	} forEach ([_missionPos, GRLIB_capture_size] call F_getNearbyPlayers);

	_successHintMessage = "STR_ROADBLOCK_MESSAGE2";
};

_this call sideMissionProcessor;
