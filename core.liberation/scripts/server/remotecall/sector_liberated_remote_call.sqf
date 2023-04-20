if (isServer) then {

	params [ "_liberated_sector" ];

	_combat_readiness_increase = 0;


	if ( _liberated_sector in sectors_bigtown ) then {
		_combat_readiness_increase = (floor (random 10)) * GRLIB_difficulty_modifier;
	};

	if ( _liberated_sector in sectors_capture ) then {
		_combat_readiness_increase = (floor (random 6)) * GRLIB_difficulty_modifier;
	};

	if ( _liberated_sector in sectors_military ) then {
		_combat_readiness_increase = (5 + (floor (random 11))) * GRLIB_difficulty_modifier;

		private _trucklist = [entities [[opfor_ammobox_transport], [], false, false], {
			(getPos _x) distance2D (markerPos _liberated_sector) < 300
		}] call BIS_fnc_conditionalSelect;
		{
			_x setVariable ["R3F_LOG_disabled", false, true];
			_x setVariable ["GRLIB_vehicle_owner", "public", true];
		} forEach _trucklist;

		private _boxlist = [entities [[ammobox_o_typename], [], false, false], {
			(getPos _x) distance2D (markerPos _liberated_sector) < 300
		}] call BIS_fnc_conditionalSelect;
		{
			_x setVariable ["R3F_LOG_disabled", false, true];
		} forEach _boxlist;
	};

	if ( _liberated_sector in sectors_factory ) then {
		_combat_readiness_increase = (3 + (floor (random 7))) * GRLIB_difficulty_modifier;
	};

	if ( _liberated_sector in sectors_tower ) then {
		_combat_readiness_increase = (floor (random 4));
	};

	private _income = (75 + floor(random 100));
	private _text = format ["Reward Received: + %1 Ammo.", _income];
	{
		if (_x distance2D (markerpos _liberated_sector) < GRLIB_sector_size ) then {
			private _ammo_collected = _x getVariable ["GREUH_ammo_count",0];
			_x setVariable ["GREUH_ammo_count", _ammo_collected + _income, true];
			[gamelogic, _text] remoteExec ["globalChat", owner _x];
		};
	} forEach allPlayers;
	[markerPos _liberated_sector] call showlandmines;

	combat_readiness = combat_readiness + _combat_readiness_increase;
	if ( combat_readiness > 100.0 && GRLIB_difficulty_modifier <= 2.0 ) then { combat_readiness = 100.0 };
	stats_readiness_earned = stats_readiness_earned + _combat_readiness_increase;
	[ _liberated_sector, 0 ] remoteExec ["remote_call_sector", 0];
	reset_battlegroups_ai = true; publicVariable "reset_battlegroups_ai";

	blufor_sectors pushback _liberated_sector; publicVariable "blufor_sectors";
	stats_sectors_liberated = stats_sectors_liberated + 1;

	[] call recalculate_caps;
	[] spawn check_victory_conditions;

	sleep 1;

	trigger_server_save = true;

	sleep 45;

	if ( GRLIB_endgame == 0 ) then {
		if ( (!( _liberated_sector in sectors_tower )) && ((floor(random (200.0 / (GRLIB_difficulty_modifier * GRLIB_csat_aggressivity) )) < (combat_readiness - 20)) || ( _liberated_sector in sectors_bigtown )) && ([] call F_opforCap < GRLIB_battlegroup_cap) ) then {
			[ _liberated_sector ] spawn spawn_battlegroup;
		};
	};
};