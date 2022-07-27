if (!isServer && hasInterface) exitWith {};
params [ "_liberated_sector" ];
diag_log format ["Sector %1 liberated", _liberated_sector];
_combat_readiness_increase = 0;

if (isNil "fallback_income") then {
	fallback_income = 50
};

private _income = fallback_income;// default

if (_liberated_sector in sectors_bigtown) then {
	_combat_readiness_increase = (floor (random 10)) * GRLIB_difficulty_modifier;
	if (isNil "income_sectors_bigtown") then {
		income_sectors_bigtown = fallback_income
	};
	_income = income_sectors_bigtown;
};

if (_liberated_sector in sectors_capture) then {
	_combat_readiness_increase = (floor (random 6)) * GRLIB_difficulty_modifier;
	if (isNil "income_sectors_capture") then {
		income_sectors_capture = fallback_income
	};
	_income = income_sectors_capture;
};

if (_liberated_sector in sectors_military) then {
	_combat_readiness_increase = (5 + (floor (random 11))) * GRLIB_difficulty_modifier;
	if (isNil "income_sectors_military") then {
		income_sectors_military = fallback_income
	};
	_income = income_sectors_military;

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
		_x setVariable ["GRLIB_vehicle_owner", "", true];
	} forEach _boxlist;
};

if (_liberated_sector in sectors_factory) then {
	_combat_readiness_increase = (3 + (floor (random 7))) * GRLIB_difficulty_modifier;
	if (isNil "income_sectors_factory") then {
		income_sectors_factory = fallback_income
	};
	_income = income_sectors_factory;
};

if (_liberated_sector in sectors_tower) then {
	_combat_readiness_increase = (floor (random 4));
	if (isNil "income_sectors_tower") then {
		income_sectors_tower = fallback_income
	};
	_income = income_sectors_tower;
};

{
	if (!Sector_ammo_for_all) then {
		if (_x distance2D (markerPos _liberated_sector) < GRLIB_sector_size * 2) then {
			private _ammo_collected = _x getVariable ["GREUH_ammo_count", 0];

			_x setVariable ["GREUH_ammo_count", _ammo_collected + _income, true];

			[_x, 5] remoteExec ["addscore", 2];
		};
	} else {
		private _ammo_collected = _x getVariable ["GREUH_ammo_count", 0];

		_x setVariable ["GREUH_ammo_count", _ammo_collected + _income, true];

		diag_log format ["[Ammo] %1 hat Sektor eingenommen: +%2 ", _x, _income];		

		[_x, 5] remoteExec ["addscore", 2];
	};
} forEach allPlayers;
[markerPos _liberated_sector] call showlandmines;

combat_readiness = combat_readiness + _combat_readiness_increase;


if (limit_readiness) then {
    if (combat_readiness >= 100.0) then {
        combat_readiness = 100.0
    };
} else {
    if (combat_readiness >= 100.0 && GRLIB_difficulty_modifier <= 2.0) then {
        combat_readiness = 100.0
    };
};

stats_readiness_earned = stats_readiness_earned + _combat_readiness_increase;
publicVariable "stats_readiness_earned";

[ _liberated_sector, 0 ] remoteExec ["remote_call_sector", 0];
reset_battlegroups_ai = true;
publicVariable "reset_battlegroups_ai";

blufor_sectors pushback _liberated_sector;
publicVariable "blufor_sectors";
stats_sectors_liberated = stats_sectors_liberated + 1;

[] call recalculate_caps;
[] spawn check_victory_conditions;

sleep 1;

trigger_server_save = true;

sleep 45;

if (GRLIB_endgame == 0) then {
	if ((!( _liberated_sector in sectors_tower )) &&
	((floor(random (200.0 / (GRLIB_difficulty_modifier * GRLIB_csat_aggressivity) )) < (combat_readiness - 20)) || ( _liberated_sector in sectors_bigtown )) &&
	([] call F_opforCap < GRLIB_battlegroup_cap) &&
	(diag_fps > 15.0)) then {
		[ markerPos _liberated_sector ] spawn spawn_battlegroup;
	};
};

sleep 45;

if (_liberated_sector in sectors_tower) then {
	_pos = markerPos _liberated_sector;
	_nextower = "Land_Communication_F" createVehicle _pos;
	_nextower setPos _pos;
	_nextower setVectorUp [0, 0, 1];
};
