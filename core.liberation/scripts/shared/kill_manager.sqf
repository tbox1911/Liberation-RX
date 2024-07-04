params [ "_unit", "_killer", "_instigator"];

if (isNull _unit) exitWith {};
private ["_msg"];

if ( isServer ) then {
	if (_unit getVariable ["GRLIB_mp_kill", false]) exitWith {};
	_unit setVariable ["GRLIB_mp_kill", true];

	if (!isNull _instigator) then {
		if (isNull (getAssignedCuratorLogic _instigator)) then {
	    	_killer = _instigator;
		};
	} else {
		if (!(_killer isKindOf "CAManBase")) then {
			_killer = effectiveCommander _killer;
		};
	};

	// ACE
	if (GRLIB_ACE_medical_enabled && local _unit) then {
		if (isNull _killer || _killer == _unit) then {
			_killer = _unit getVariable ["ace_medical_lastDamageSource", objNull];
		};
	};

	if (isNull _killer) then {
		_killer = _unit getVariable ["GRLIB_last_killer", objNull];
	};

	private _unit_class = typeOf _unit;
	private _unit_side = side group _unit;
	private _killer_side = side group _killer;
	//diag_log format ["DBG: Killer: %1 %2", name _killer, _killer_side];
	//diag_log format ["DBG: Killed: %1 %2", name _unit, _unit_side];

	// Quick Delete
	if (_unit_class in GRLIB_quick_delete) exitWith {
		_unit setDamage 1;
		sleep 5;
		deleteVehicle _unit;
	};

	if (isNil "infantry_weight") then { infantry_weight = 33 };
	if (isNil "armor_weight") then { armor_weight = 33 };
	if (isNil "air_weight") then { air_weight = 33 };
	if (isPlayer _unit) then {
		stats_player_deaths = stats_player_deaths + 1
	};

	if ( _killer_side == GRLIB_side_friendly && !(_unit getVariable ["GRLIB_mission_AI", false]) && !(_unit getVariable ["GRLIB_battlegroup", false]) ) then {
		private _readiness = (0.1 * GRLIB_difficulty_modifier);
		if (_unit isKindOf "AllVehicles") then { _readiness = (0.3 * GRLIB_difficulty_modifier) };
		if (_unit isKindOf "Air") then { _readiness = (0.4 * GRLIB_difficulty_modifier) };

		combat_readiness = combat_readiness + _readiness;
		stats_readiness_earned = stats_readiness_earned + _readiness;
		if ( combat_readiness > 100 && GRLIB_difficulty_modifier < 2 ) then { combat_readiness = 100 };

		if ( (vehicle _killer) isKindOf "CAManBase" ) then {
			infantry_weight = infantry_weight + 1;
			armor_weight = armor_weight - 0.2;
			air_weight = air_weight - 0.2;
		};
		if ( (vehicle _killer) isKindOf "LandVehicle" ) then {
			infantry_weight = infantry_weight - 10;
			armor_weight = armor_weight + 10;
			air_weight = air_weight - 1;
		};
		if ( (vehicle _killer) isKindOf "Air" ) then {
			infantry_weight = infantry_weight - 10;
			armor_weight = armor_weight - 1;
			air_weight = air_weight + 10;
		};

		if ( infantry_weight > 100 ) then { infantry_weight = 100 };
		if ( infantry_weight < 0 ) then { infantry_weight = 0 };
		if ( armor_weight > 100 ) then { armor_weight = 100 };
		if ( armor_weight < 0 ) then { armor_weight = 0 };
		if ( air_weight > 100 ) then { air_weight = 100 };
		if ( air_weight < 0 ) then { air_weight = 0 };
	};

	if (_unit_class isKindOf "CAManBase") then {
		if ( !isNull objectParent _unit ) then { [_unit, false] spawn F_ejectUnit };

		if (isNull _killer) exitWith {};
		if ( _unit != _killer ) then {
			_isPrisonner = _unit getVariable ["GRLIB_is_prisoner", false];
			_isKamikaz = _unit getVariable ["GRLIB_is_kamikaze", false];
			_isZombie = (_unit_class select [0,10] == "RyanZombie");
			if ( _isKamikaz ) then {
				_msg = format ["%1 kill a Kamikaze !! +10 XP", name _killer] ;
				[gamelogic, _msg] remoteExec ["globalChat", 0];
				[_killer, 11] call F_addScore;
			};
			if ( _isZombie ) then { [_killer, 5] call F_addScore };
			if ( !_isKamikaz && !_isZombie && _unit_side == GRLIB_side_civilian || _isPrisonner ) then {
				stats_civilians_killed = stats_civilians_killed + 1;
				if ( isPlayer _killer ) then {
					stats_civilians_killed_by_players = stats_civilians_killed_by_players + 1;
					if ( GRLIB_civ_penalties > 0 ) then {
						private _penalty = GRLIB_civ_penalties;
						private _score = [_killer] call F_getScore;
						if ( _score < GRLIB_perm_inf ) then { _penalty = GRLIB_civ_penalties/2};
						if ( _score > GRLIB_perm_inf ) then { _penalty = GRLIB_civ_penalties };
						if ( _score > GRLIB_perm_air ) then { _penalty = GRLIB_civ_penalties*2 };
						if ( _score > GRLIB_perm_max ) then { _penalty = GRLIB_civ_penalties*3 };
						[_killer, -_penalty] call F_addScore;
						[_killer, -5] call F_addReput;
						[name _unit, _penalty, _killer] remoteExec ["remote_call_civ_penalty", 0];
						combat_readiness = combat_readiness + (0.5 * GRLIB_difficulty_modifier);
						stats_readiness_earned = stats_readiness_earned + (0.5 * GRLIB_difficulty_modifier);
						if ( combat_readiness > 100 && GRLIB_difficulty_modifier < 2 ) then { combat_readiness = 100 };
					};
				};

				if ( _killer_side == GRLIB_side_friendly && (!isPlayer _killer)) then {
					private _owner_id = (vehicle _killer) getVariable ["GRLIB_vehicle_owner", ""];
					if (_owner_id in ["", "server"]) then {
						_owner_id = (_killer getVariable ["PAR_Grp_ID", "0_0"]) splitString "_" select 1;
					};
					if (_owner_id != "0" && GRLIB_civ_penalties > 0) then {
						_owner_player = _owner_id call BIS_fnc_getUnitByUID;
						[_owner_player, -GRLIB_civ_penalties] call F_addScore;
						[_owner_player, -1] call F_addReput;
						_msg = format ["%1, Your AI kill Civilian !!", name _owner_player] ;
						[gamelogic, _msg] remoteExec ["globalChat", 0];
						[name _unit, GRLIB_civ_penalties, _owner_player] remoteExec ["remote_call_civ_penalty", 0];
					};
				};
			};

			if ( _killer_side == GRLIB_side_friendly ) then {
				if ( _unit_side == GRLIB_side_enemy ) then {
					stats_opfor_soldiers_killed = stats_opfor_soldiers_killed + 1;
					if ( isplayer _killer ) then {
						stats_opfor_killed_by_players = stats_opfor_killed_by_players + 1;
						_killer = (getPlayerUID _killer) call BIS_fnc_getUnitByUID;
						[_killer, 1] call F_addScore;
					};

					private _ai_score = _killer getVariable ["PAR_AI_score", nil];
					if (!isNil "_ai_score") then {
						_killer setVariable ["PAR_AI_score", (_ai_score - 1), true];
						_leader = leader group _killer;
						_vehicle = objectParent _killer;
						if (!isNull _vehicle && objectParent _leader == _vehicle && isPlayer _leader && (driver _vehicle == _leader || commander _vehicle == _leader)) then {
							[_leader, 1] call F_addScore;
						};
					};
					if (floor random 2 == 0) then {
						private _deathsound = format ["A3\sounds_f\characters\human-sfx\P%1\hit_max_%2.wss", selectRandom ["03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18"], selectRandom [1,2,3]];
						playSound3D [_deathsound, _unit, false, getPosASL _unit, 5, 1, 300];
					};
				};
				if ( _unit_side == GRLIB_side_friendly ) then {
					stats_blufor_teamkills = stats_blufor_teamkills + 1;
					[_killer, -20] call F_addScore;
					_msg = localize "STR_FRIENDLY_FIRE";
					[gamelogic, _msg] remoteExec ["globalChat", 0];
				};
			} else {
				if ( _unit_side == GRLIB_side_friendly ) then {
					stats_blufor_soldiers_killed = stats_blufor_soldiers_killed + 1;
				};
			};
		};

	} else {
		if (_unit_class == mobile_respawn) exitWith { [_unit, "del"] remoteExec ["addel_beacon_remote_call", 2] };

		if (_unit_class in GRLIB_explo_delete && (getPosATL _unit) select 2 < 10) exitWith {
			detach _unit;
			sleep 0.1;
			_unit setVelocity [([] call F_getRND), ([] call F_getRND), 10];
			sleep 2;
			_unit setDamage 1;
			( "R_80mm_HE" createVehicle (getPosATL _unit) ) setVelocity [0, 0, -200];
			deleteVehicle _unit;
		};

		if (isPlayer _killer) then {
			_owner_id = getPlayerUID _killer;
			if ( !(_unit getVariable ["GRLIB_vehicle_owner", ""] in ["", "public", "server", _owner_id]) ) then {
				_penalty = 50;
				_msg = format ["Penalty of %1 to %2 for killing a Friendly vehicle !!", _penalty, name _killer] ;
				[gamelogic, _msg] remoteExec ["globalChat", 0];
				[_killer, -_penalty] call F_addScore;
			};

			if (_unit_class in all_hostile_classnames) then {
				_bounty = [_unit] call F_getBounty;
				[_unit_class, _bounty, _killer] remoteExec ["remote_call_ammo_bounty", 0];
				[_killer, (_bounty select 0), 0] call ammo_add_remote_call;
				[_killer, (_bounty select 1)] call F_addScore;
				stats_opfor_vehicles_killed_by_players = stats_opfor_vehicles_killed_by_players + 1;
			};
		};

		if (_unit_class in all_hostile_classnames) then {
			stats_opfor_vehicles_killed = stats_opfor_vehicles_killed + 1;
		} else {
			stats_blufor_vehicles_killed = stats_blufor_vehicles_killed + 1;
		};

		[_unit, false, true, true] spawn clean_vehicle;
	};
};
