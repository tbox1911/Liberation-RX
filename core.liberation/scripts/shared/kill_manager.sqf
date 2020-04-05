params [ "_unit", "_killer" ];
private [ "_nearby_bigtown", "_bounty", "_bonus", "_msg" ];


if ( isServer ) then {
	//diag_log format ["DBG: %1 %2 %3", name _unit, side _unit, captive _unit];
	// ACE
	if (GRLIB_ACE_enabled && local _unit) then {
		if (isNull _killer) then {
			_killer = _unit getVariable ["ace_medical_lastDamageSource", objNull];
		};
	};

	please_recalculate = true;

	if (isNil "infantry_weight") then { infantry_weight = 33 };
	if (isNil "armor_weight") then { armor_weight = 33 };
	if (isNil "air_weight") then { air_weight = 33 };

	if ( side _killer == GRLIB_side_friendly ) then {

		_nearby_bigtown = [ sectors_bigtown, {  (!(_x in blufor_sectors)) && ( _unit distance (markerpos _x) < 250 ) } ] call BIS_fnc_conditionalSelect;
		if ( count _nearby_bigtown > 0 ) then {
			combat_readiness = combat_readiness + (0.5 * GRLIB_difficulty_modifier);
			stats_readiness_earned = stats_readiness_earned + (0.5 * GRLIB_difficulty_modifier);
			if ( combat_readiness > 100.0 && GRLIB_difficulty_modifier < 2 ) then { combat_readiness = 100.0 };
		};

		if ( _killer isKindOf "Man" ) then {
			infantry_weight = infantry_weight + 1;
			armor_weight = armor_weight - 0.66;
			air_weight = air_weight - 0.66;
		} else {
			if ( (typeof (vehicle _killer) ) in land_vehicles_classnames ) then  {
				infantry_weight = infantry_weight - 0.66;
				armor_weight = armor_weight + 1;
				air_weight = air_weight - 0.66;
			};
			if ( (typeof (vehicle _killer) ) in air_vehicles_classnames ) then  {
				infantry_weight = infantry_weight - 0.66;
				armor_weight = armor_weight - 0.66;
				air_weight = air_weight + 1;
			};
		};

		if ( infantry_weight > 100 ) then { infantry_weight = 100 };
		if ( armor_weight > 100 ) then { armor_weight = 100 };
		if ( air_weight > 100 ) then { air_weight = 100 };
		if ( infantry_weight < 0 ) then { infantry_weight = 0 };
		if ( armor_weight < 0 ) then { armor_weight = 0 };
		if ( air_weight < 0 ) then { air_weight = 0 };
	};

	if ( isPlayer _unit ) then { stats_player_deaths = stats_player_deaths + 1 };

	if ((_unit iskindof "LandVehicle") || (_unit iskindof "Air") || (_unit iskindof "Ship") ) then {
		// Delete Cargo
		{[[_x], "deleteVehicle"] call BIS_fnc_MP} forEach (_unit getVariable ["R3F_LOG_objets_charges", []]);

		// Delete GR Cargo
		//{[[_x], "deleteVehicle"] call BIS_fnc_MP} foreach (attachedObjects _unit);

		// Delete Crew
		{if (! alive _x) then {[[_x], "deleteVehicle"] call BIS_fnc_MP}} forEach crew _unit;
		_unit removeAllEventHandlers "HandleDamage";
	};

	if ( _unit isKindOf "Man" && _unit != _killer ) then {
		_isPrisonner = _unit getVariable ["GRLIB_is_prisonner", false];
		if ( side (group _unit) == GRLIB_side_civilian || _isPrisonner ) then {
			stats_civilians_killed = stats_civilians_killed + 1;
			if ( isPlayer _killer ) then {
				stats_civilians_killed_by_players = stats_civilians_killed_by_players + 1;
				if ( GRLIB_civ_penalties ) then {
					_penalty = GRLIB_civ_killing_penalty;
					_score = score _killer;
					if ( _score < GRLIB_perm_inf ) then { _penalty = 5 };
					if ( _score > GRLIB_perm_inf && _score < GRLIB_perm_log ) then { _penalty = 10 };
					_killer addScore - _penalty;
					[[name _unit, _penalty, _killer] , "remote_call_civ_penalty"] call BIS_fnc_MP;
				};
			};
		};

		if ( side _killer == GRLIB_side_friendly ) then {
			if ( side (group _unit) == GRLIB_side_enemy ) then {
				stats_opfor_soldiers_killed = stats_opfor_soldiers_killed + 1;
				if ( isplayer _killer ) then {
					stats_opfor_killed_by_players = stats_opfor_killed_by_players + 1;
				};
			};
			if ( side (group _unit) == GRLIB_side_friendly ) then {
				stats_blufor_teamkills = stats_blufor_teamkills + 1;
				_killer addScore -9;
				_msg = localize "STR_FRIENDLY_FIRE";
				[gamelogic, _msg]  remoteExec ["globalChat", -2];
			};
		} else {
			if ( side (group _unit) == GRLIB_side_friendly ) then {
				stats_blufor_soldiers_killed = stats_blufor_soldiers_killed + 1;
			};
		};
	} else {
		if ( typeof _unit in all_hostile_classnames ) then {
			stats_opfor_vehicles_killed = stats_opfor_vehicles_killed + 1;
			if ( isplayer _killer ) then {
				stats_opfor_vehicles_killed_by_players = stats_opfor_vehicles_killed_by_players + 1;

				if ( GRLIB_ammo_bounties ) then {
					_res = [_unit] call F_getBounty;
					[ [ typeOf _unit, _res select 0,  _res select 1, _killer] , "remote_call_ammo_bounty" ] call BIS_fnc_MP;
					_killer addScore (_bonus);
					_killer addRating 100;
				};
			};
		} else {
			stats_blufor_vehicles_killed = stats_blufor_vehicles_killed + 1;
		};
	};

	if ( ((typeof _unit) in [ammobox_o_typename, ammobox_b_typename]) && ((getPosATL _unit) select 2 < 10) ) exitWith {
		( "R_80mm_HE" createVehicle (getPosATL _unit) ) setVelocity [0, 0, -200];
		sleep 2;
		deleteVehicle _unit;
	};

	_unit setVariable ["R3F_LOG_disabled", true, true];
	_unit enableSimulationGlobal true;
	sleep GRLIB_cleanup_delay;
	deleteVehicle _unit;
};
