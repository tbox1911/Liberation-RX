params ["_grp"];

if (count units _grp == 0) exitWith {};
private _unit = (units _grp) select 0;
if ((typeOf _unit) select [0,10] == "RyanZombie") exitWith {};
if (surfaceIsWater (getPosATl _unit)) exitWith {};
if (count units _grp > 1 || (floor random 4 == 0)) exitWith { [_grp, getPos _unit, GRLIB_capture_size] call BIS_fnc_taskPatrol };
//if (!local _grp) exitWith { [_grp] remoteExec ["civilian_ai", groupOwner _grp] };


private _moveTo = {
	params ["_unit", "_target", ["_radius", 5]];
	private _ret = false;
	private _timer = time + 120;
	while {true} do {
		private _dest = getPos _target;
		_unit doMove _dest;
		sleep 5;
		private _dist = _unit distance2D _dest;
		// diag_log [name _target, name _unit, _dist];
		if (!alive _unit || !alive _target || _dist > GRLIB_capture_size || time >= _timer) exitWith {};
		if (_dist <= _radius) exitWith { _ret = true };
	};
	_ret;
};

private _weapons_light = [
	"hgun_ACPC2_F",
	"hgun_P07_F",
	"hgun_Rook40_F",
	"hgun_Pistol_heavy_01_F",
	"hgun_Pistol_heavy_02_F",
	"hgun_Pistol_heavy_02_Yorris_F",
	"hgun_PDW2000_F",
	"SMG_01_F",
	"sgun_HunterShotgun_01_F",
	"sgun_HunterShotgun_01_sawedoff_F",
	"sgun_HunterShotgun_01_F",
	"sgun_HunterShotgun_01_sawedoff_F",
	"srifle_DMR_06_hunter_F"
];

private [
	"_list_actions", "_action", "_reputation",
	"_nearby_players", "_target", "_target_veh",
	"_hit_index", "_damage", "_ret",
	"_new_grp", "_danger",
	"_box", "_magType", "_ied"
];

[_grp, getPosATL _unit] spawn add_civ_waypoints;

sleep (60 + floor random 60);

private _continue = true;
while {alive _unit && _continue} do {
	_action = 0;
	_nearby_players = ([_unit, GRLIB_capture_size] call F_getNearbyPlayers) select { isNil {_x getVariable "GRLIB_civilian_action"} };
	if (count _nearby_players > 0) then {
		_target = selectRandom _nearby_players;
		_target_veh = vehicles select {
			(alive _x) &&
			(_x distance2D _unit <= GRLIB_capture_size)  &&
			(_x isKindOf "LandVehicle") &&
			([_target, _x, true] call is_owner)
		};
		_reputation = [_target] call F_getReput;
		_list_actions = [0];
		if ( _reputation >= 25 ) then { _list_actions = [0,1,1,1,2] };
		if ( _reputation >= 50 ) then { _list_actions = [1,2,2,3,3] };
		if ( _reputation >= 75 ) then { _list_actions = [2,2,3,4,4,5] };
		if ( _reputation >= 100 ) then { _list_actions = [2,3,4,5,5] };
		if ( _reputation <= -25 ) then { _list_actions = [0,10,10] };
		if ( _reputation <= -50 ) then { _list_actions = [10,11,11] };
		if ( _reputation <= -75 ) then { _list_actions = [11,11,12,12,14] };
		if ( _reputation <= -100 ) then { _list_actions = [11,12,12,13,13,14,14] };
		_action = selectRandom _list_actions;
	};

	if (_action > 0) then {
		_target setVariable ["GRLIB_civilian_action", _action, true];
		diag_log format ["Civilian AI %1 action %2 at %3", name _unit, _action, time];
	};

	switch (_action) do {
		//--- Info / Insult
		case 1;
		case 10: {
			[_grp] call F_deleteWaypoints;
			_ret = [_unit, _target] call _moveTo;
			if (_ret && !([_target] call PAR_is_wounded)) then {
				if (isServer) then {
					[_unit, _action, _target] spawn speak_manager_remote_call;
				} else {
					[_unit, _action, _target] remoteExec ["speak_manager_remote_call", 2];
				};
				if (_action == 10) then {
					playSound3D ["A3\Sounds_F_Tacops\SFX\Missions\Crowd_b.wss", _unit, false, getPosASL _unit, 3, 1, 250];
				};
				sleep 3;
			};
		};

		//--- Heal
		case 2: {
			if (damage _target == 0) exitWith {};
			[_grp] call F_deleteWaypoints;
			_ret = [_unit, _target] call _moveTo;
			if (_ret  && damage _target <= 0.1 && !([_target] call PAR_is_wounded)) then {
				if (isServer) then {
					[_unit, _action, _target] spawn speak_manager_remote_call;
				} else {
					[_unit, _action, _target] remoteExec ["speak_manager_remote_call", 2];
				};
				_unit stop true;
				_unit setDir (_unit getDir _target);
				_unit switchMove "ainvpknlmstpslaywrfldnon_medicother";
				_unit playMoveNow "ainvpknlmstpslaywrfldnon_medicother";
				sleep 6;
				_target setDamage 0;
				_unit stop false;
				_unit switchMove "AmovPercMwlkSnonWnonDf";
				_unit playMoveNow "AmovPercMwlkSnonWnonDf";
			};
		};

		//--- Repair
		case 3: {
			_target_veh = _target_veh select { ([_x] call F_VehicleNeedRepair) };
			if (count _target_veh == 0) exitWith {};
			_target = selectRandom _target_veh;
			[_grp] call F_deleteWaypoints;
			_ret = [_unit, _target, 7] call _moveTo;
			if (_ret) then {
				if (isServer) then {
					[_unit, _action, _target] spawn speak_manager_remote_call;
				} else {
					[_unit, _action, _target] remoteExec ["speak_manager_remote_call", 2];
				};
				sleep 6;
				_unit stop true;
				_unit setDir (_unit getDir _target);
				_unit switchMove "ainvpknlmstpslaywrfldnon_medicother";
				_unit playMoveNow "ainvpknlmstpslaywrfldnon_medicother";
				playSound3D ["a3\sounds_f\sfx\ui\vehicles\vehicle_repair.wss", _target, false, getPosASL _target, 3, 1, 250];
				sleep 3;
				playSound3D ["a3\sounds_f\sfx\ui\vehicles\vehicle_repair.wss", _target, false, getPosASL _target, 3, 1, 250];
				sleep 3;
				{ _target setHitPointDamage [_x, 0] } forEach (getAllHitPointsDamage _target select 0);
				_unit stop false;
				_unit switchMove "AmovPercMwlkSnonWnonDf";
				_unit playMoveNow "AmovPercMwlkSnonWnonDf";
			};
		};

		//--- Reammo
		case 4: {
			_danger = ([_unit, GRLIB_capture_size, GRLIB_side_enemy] call F_getUnitsCount >= 5);
			if (_danger) then {
				[_grp] call F_deleteWaypoints;
				_ret = [_unit, _target] call _moveTo;
				if (_ret) then {
					if (isServer) then {
						[_unit, _action, _target] spawn speak_manager_remote_call;
					} else {
						[_unit, _action, _target] remoteExec ["speak_manager_remote_call", 2];
					};
					_box = createVehicle ["Box_Syndicate_Ammo_F", getPosATL _unit, [], 2, "CAN_COLLIDE"];
					_box allowDamage false;
					[_box] call F_clearCargo;
					_box addItemCargoGlobal ["FirstAidKit", 5];
					_box addMagazineCargoGlobal ["HandGrenade", 4];
					_box addMagazineCargoGlobal ["SmokeShell", 6];
					_magType = getArray (configFile >> "CfgWeapons" >> (primaryWeapon _target) >> "magazines") select 0;
					if (!isNil "_magType") then { _box addMagazineCargoGlobal [_magType, 10] };
					_magType = getArray (configFile >> "CfgWeapons" >> (secondaryWeapon _target) >> "magazines") select 0;
					if (!isNil "_magType") then { _box addMagazineCargoGlobal [_magType, 4] };
					_box spawn { sleep 60; deleteVehicle _this };
					sleep 3;
				};
			};
		};

		//--- Help (armed)
		case 5: {
			_danger = ([_unit, GRLIB_capture_size, GRLIB_side_enemy] call F_getUnitsCount >= 5);
			if (_danger && count (units group _target) < 8) then {
				[_grp] call F_deleteWaypoints;
				_ret = [_unit, _target] call _moveTo;
				if (_ret) then {
					if (isServer) then {
						[_unit, _action, _target] spawn speak_manager_remote_call;
					} else {
						[_unit, _action, _target] remoteExec ["speak_manager_remote_call", 2];
					};
					removeAllAssignedItems _unit;
					_unit addWeapon (selectRandom _weapons_light);
					_unit addVest "V_Rangemaster_belt";
					[_unit] call reammo_ai;
					_unit setSkill ["courage", 1];
					(group _unit) setCombatMode "YELLOW";
					sleep 1;
					[_unit] joinSilent (group _target);
					_unit setCaptive false;
					[_unit] spawn {
						params ["_unit"];
						waitUntil {sleep 10; (!(alive _unit) || ([_unit, GRLIB_capture_size, GRLIB_side_enemy] call F_getUnitsCount == 0)) };
						deleteVehicle _unit;
					};
					_continue = false;
				};
			};
		};

		//------------ you'll see the line, the line that's drawn between, good and bad (DP) ----------------------------

		//--- Sabotage
		case 11: {
			if (count _target_veh == 0) exitWith {};
			_target = selectRandom _target_veh;
			[_grp] call F_deleteWaypoints;
			_ret = [_unit, _target, 7] call _moveTo;
			if (_ret) then {
				_unit stop true;
				_unit setDir (_unit getDir _target);
				_unit switchMove "ainvpknlmstpslaywrfldnon_medicother";
				_unit playMoveNow "ainvpknlmstpslaywrfldnon_medicother";
				sleep 3;
				if (_target isKindOf "AllVehicles") then {
					_hit_index = selectRandom ["HitBody", "HitEngine", "HitFuel", "HitLFWheel", "HitLBWheel", "HitRFWheel", "HitRBWheel"];
					_target setHitPointDamage [_hit_index, 1];
				} else {
					_damage = damage _target;
					_target setDamage (_damage + 0.25);
				};
				sleep 5;
				_unit stop false;
				_unit switchMove "AmovPercMwlkSnonWnonDf";
				_unit playMoveNow "AmovPercMwlkSnonWnonDf";
			};
		};

		//--- Attack (armed)
		case 12: {
			_danger = ([_unit, GRLIB_capture_size, GRLIB_side_enemy] call F_getUnitsCount >= 5);
			if (_danger) then {
				removeAllAssignedItems _unit;
				_unit addWeapon (selectRandom _weapons_light);
				_unit addVest "V_Rangemaster_belt";
				[_unit] call reammo_ai;
				_unit setSkill ["courage", 1];
				sleep 1;
				_new_grp = createGroup [GRLIB_side_enemy, true];
				[_unit] joinSilent _new_grp;
				[_new_grp, getPosATL _target] spawn defence_ai;

				[_unit] spawn {
					params ["_unit"];
					waitUntil {sleep 10; !(alive _unit) || ([_unit, GRLIB_capture_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
					deleteVehicle _unit;
				};
				_continue = false;
			};

		};

		//--- Bomber
		case 13: {
			[_unit] spawn bomber_ai;
			_continue = false;
		};

		//--- Bomb Attack
		case 14: {
			if (count _target_veh == 0) exitWith {};
			_target = selectRandom _target_veh;
			[_grp] call F_deleteWaypoints;
			_ret = [_unit, _target, 7] call _moveTo;
			if (_ret) then {
				_unit stop true;
				_unit setDir (_unit getDir _target);
				_unit switchMove "ainvpknlmstpslaywrfldnon_medicother";
				_unit playMoveNow "ainvpknlmstpslaywrfldnon_medicother";
				sleep 3;
				_ied = createMine ["IEDUrbanSmall_F", (_target getPos [1, random(360)]), [], 0];
				_ied setPos (getPos _ied);
				[_ied] spawn { sleep 40; (_this select 0) setDamage 1 };
				sleep 5;
				_unit stop false;
				_unit switchMove "AmovPercMwlkSnonWnonDf";
				_unit playMoveNow "AmovPercMwlkSnonWnonDf";
			};
		};

		//--- Normal
		default { };
	};

	if (_action > 0) then {
		_target setVariable ["GRLIB_civilian_action", nil, true];
	};

	if (_continue) then {
		[_grp, getPosATL _unit] spawn add_civ_waypoints;
		sleep 120;
	};
};
