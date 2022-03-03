params [ "_unit", "_killer", "_instigator"];
private [ "_nearby_bigtown","_msg" ];

if ( isServer ) then {
	if (!(isNull _instigator)) then {
		_killer = _instigator;
	} else {
		if (!(_killer isKindOf "CAManBase")) then {
			_killer = effectiveCommander _killer;
		};
	};

	//diag_log format ["DBG: Killer: %1 %2", name _killer, side (group _killer)];
	//diag_log format ["DBG: Killed: %1 %2", name _unit, side (group _unit)];

	// ACE
	if (GRLIB_ACE_enabled && local _unit) then {
		if (isNull _killer || _killer == _unit) then {
			_killer = _unit getVariable ["ace_medical_lastDamageSource", objNull];
		};
	};

	if (isNil "infantry_weight") then { infantry_weight = 33 };
	if (isNil "armor_weight") then { armor_weight = 33 };
	if (isNil "air_weight") then { air_weight = 33 };
	if ( isPlayer _unit ) then { stats_player_deaths = stats_player_deaths + 1 };

	if ( side _killer == GRLIB_side_friendly ) then {

		_nearby_bigtown = [ sectors_bigtown, {  (!(_x in blufor_sectors)) && ( _unit distance (markerpos _x) < 250 ) } ] call BIS_fnc_conditionalSelect;
		if ( count _nearby_bigtown > 0 ) then {
			combat_readiness = combat_readiness + (0.5 * GRLIB_difficulty_modifier);
			stats_readiness_earned = stats_readiness_earned + (0.5 * GRLIB_difficulty_modifier);
			if ( combat_readiness > 100.0 && GRLIB_difficulty_modifier < 2 ) then { combat_readiness = 100.0 };
		};

		if ( _unit isKindOf "Man" ) then {
			infantry_weight = infantry_weight + 1;
			armor_weight = armor_weight - 0.1;
			air_weight = air_weight - 0.1;
		} else {
			if ( _unit isKindOf "Tank" ) then {
				infantry_weight = infantry_weight - 0.50;
				armor_weight = armor_weight + 5;
				air_weight = air_weight - 0.10;
			};
			if ( _unit isKindOf "Air" ) then {
				infantry_weight = infantry_weight - 0.50;
				armor_weight = armor_weight - 0.10;
				air_weight = air_weight + 5;
			};
		};

		if ( infantry_weight > 100 ) then { infantry_weight = 100 };
		if ( armor_weight > 100 ) then { armor_weight = 100 };
		if ( air_weight > 100 ) then { air_weight = 100 };
		if ( infantry_weight < 0 ) then { infantry_weight = 0 };
		if ( armor_weight < 0 ) then { armor_weight = 0 };
		if ( air_weight < 0 ) then { air_weight = 0 };
	};

	if (_unit isKindOf "Man") then {
		if ( vehicle _unit != _unit ) then {
			_unit action ["Eject", vehicle _unit];
			//moveOut _unit;
		};

		if ( _unit != _killer ) then {
			_isPrisonner = _unit getVariable ["GRLIB_is_prisonner", false];
			_isKamikaz = _unit getVariable ["GRLIB_is_kamikaze", false];
			if ( _isKamikaz ) then { 
				_msg = format ["%1 kill a Kamikaze !!", name _killer] ;
				[gamelogic, _msg] remoteExec ["globalChat", 0];
				[_killer, 1] remoteExec ["addScore", 2];
				
				_killer setVariable ["GREUH_ammo_count", ( (_killer getVariable ["GREUH_ammo_count", 0]) + 1 ), true];
				
			};

			if ( !_isKamikaz && side (group _unit) == GRLIB_side_civilian || _isPrisonner ) then {
				stats_civilians_killed = stats_civilians_killed + 1;
				/* if ( isPlayer _killer ) then {
					stats_civilians_killed_by_players = stats_civilians_killed_by_players + 1;
					if ( GRLIB_civ_penalties ) then {
						private _penalty = GRLIB_civ_killing_penalty;
						private _score = score _killer;
						if ( _score < GRLIB_perm_inf ) then { _penalty = 25 };
						if ( _score > GRLIB_perm_inf ) then { _penalty = 25 };
						if ( _score > GRLIB_perm_air ) then { _penalty = 50 };
						if ( _score > GRLIB_perm_max ) then { _penalty = 100 };
						[_killer, -_penalty] remoteExec ["addScore", 2];
						
						_killer setVariable ["GREUH_ammo_count", ( (_killer getVariable ["GREUH_ammo_count", 0]) - _penalty), true];
						
						[name _unit, _penalty, _killer] remoteExec ["remote_call_civ_penalty", 0];
					};
				}; */
				_isDriver = (driver (vehicle _killer) == _killer);

				if ( side (group _killer) == GRLIB_side_friendly && (!isPlayer _killer) && (!_isDriver) ) then {
					_owner_id = (vehicle _killer) getVariable ["GRLIB_vehicle_owner", ""];
					if (_owner_id == "") then {
						_owner_id = (_killer getVariable ["PAR_Grp_ID", "0_0"]) splitString "_" select 1;
					};

					if (_owner_id != "0") then {
						_owner_player = _owner_id call BIS_fnc_getUnitByUID;
						[_owner_player, -GRLIB_civ_killing_penalty] remoteExec ["addScore", 2];
						
						_owner_player setVariable ["GREUH_ammo_count", ( (_owner_player getVariable ["GREUH_ammo_count", 0]) - GRLIB_civ_killing_penalty), true];
						
						_msg = format ["%1, Your AI kill Civilian !!", name _owner_player] ;
						[gamelogic, _msg] remoteExec ["globalChat", 0];
						[name _unit, GRLIB_civ_killing_penalty, _owner_player] remoteExec ["remote_call_civ_penalty", 0];
					};
				};
			};

			if ( side _killer == GRLIB_side_friendly ) then {
				if ( side (group _unit) == GRLIB_side_enemy ) then {
					stats_opfor_soldiers_killed = stats_opfor_soldiers_killed + 1;
					if ( isplayer _killer ) then {
						stats_opfor_killed_by_players = stats_opfor_killed_by_players + 1;
						if (GRLIB_ACE_enabled) then {
							// [_killer, 1] remoteExec ["addScore", 2];
							// _killer setVariable ["GREUH_ammo_count", ( (_killer getVariable ["GREUH_ammo_count", 0]) + 1 ), true];
						};
					};

					private _ai_score = _killer getVariable ["PAR_AI_score", nil];
					if (!isNil "_ai_score") then {
						_killer setVariable ["PAR_AI_score", (_ai_score - 1), true];
					};
				};
				if ( side (group _unit) == GRLIB_side_friendly ) then {
					stats_blufor_teamkills = stats_blufor_teamkills + 1;
					[_killer, -10] remoteExec ["addScore", 2];
					
					_killer setVariable ["GREUH_ammo_count", ( (_killer getVariable ["GREUH_ammo_count", 0]) - 10 ), true];
					
					_msg = localize "STR_FRIENDLY_FIRE";
					[gamelogic, _msg] remoteExec ["globalChat", 0];
				};
			} else {
				if ( side (group _unit) == GRLIB_side_friendly ) then {
					stats_blufor_soldiers_killed = stats_blufor_soldiers_killed + 1;
				};
			};
		};

	} else {
		// unTow
		private _tow = _unit getVariable ["R3F_LOG_remorque", objNull];
		if (!isNull _tow) then {
			_unit setVariable ["R3F_LOG_remorque", objNull, true];
			_tow setVariable ["R3F_LOG_est_transporte_par", objNull, true];
			[_tow, "detachSetVelocity", [0, 0, 0.1]] call R3F_LOG_FNCT_exec_commande_MP;
			waitUntil { sleep 0.3; (isNull attachedTo _tow) };
		};

		private _towed = _unit getVariable ["R3F_LOG_est_transporte_par", objNull];
		if (!isNull _towed) then {
			_towed setVariable ["R3F_LOG_remorque", objNull, true];
			_unit setVariable ["R3F_LOG_est_transporte_par", objNull, true];
			[_unit, "detachSetVelocity", [0, 0, 0.1]] call R3F_LOG_FNCT_exec_commande_MP;
			waitUntil { sleep 0.3; (isNull attachedTo _unit) };
		};

		if ( (typeof _unit) in [FOB_box_typename, FOB_truck_typename, foodbarrel_typename, waterbarrel_typename] ) exitWith {
			sleep 30;
			deleteVehicle _unit;
		};

		if ( typeof _unit == mobile_respawn ) exitWith { [_unit, "del"] remoteExec ["addel_beacon_remote_call", 2] };

		if ( ((typeof _unit) in [ammobox_o_typename, ammobox_b_typename, ammobox_i_typename, fuelbarrel_typename]) && ((getPosATL _unit) select 2 < 10) ) exitWith {
			sleep random 1;
			( "R_80mm_HE" createVehicle (getPosATL _unit) ) setVelocity [0, 0, -200];
			deleteVehicle _unit;
		};

		if ((_unit iskindof "LandVehicle") || (_unit iskindof "Air") || (_unit iskindof "Ship") ) then {
			[_unit] spawn clean_vehicle;
		};

		if ( typeof _unit in all_hostile_classnames ) then {
			stats_opfor_vehicles_killed = stats_opfor_vehicles_killed + 1;
			if ( isplayer _killer ) then {
				stats_opfor_vehicles_killed_by_players = stats_opfor_vehicles_killed_by_players + 1;

				if ( GRLIB_ammo_bounties ) then {
					_res = [_unit] call F_getBounty;
					[typeOf _unit, (_res select 0), (_res select 1), _killer] remoteExec ["remote_call_ammo_bounty", 0];
				};
			};
		} else {
			stats_blufor_vehicles_killed = stats_blufor_vehicles_killed + 1;
		};

	};

	_unit setVariable ["R3F_LOG_disabled", true, true];
	//please_recalculate = true;
	//sleep 3;
	//_unit enableSimulationGlobal false;
};
