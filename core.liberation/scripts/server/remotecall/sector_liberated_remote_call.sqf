if (!isServer && hasInterface) exitWith {};
params [ "_liberated_sector" ];

diag_log format ["Sector %1 Liberated!", _liberated_sector];
private _combat_readiness_increase = 0;

if ( _liberated_sector in sectors_bigtown ) then {
	_combat_readiness_increase = (5 + (floor (random 10))) * GRLIB_difficulty_modifier;
};

if ( _liberated_sector in sectors_capture ) then {
	_combat_readiness_increase = (3 + (floor (random 5))) * GRLIB_difficulty_modifier;
};

if ( _liberated_sector in sectors_military ) then {
	_combat_readiness_increase = (5 + (floor (random 10))) * GRLIB_difficulty_modifier;

	private _trucklist = (entities [[opfor_transport_truck], [], false, false]) select {
		_x distance2D (markerPos _liberated_sector) < 300 &&
		_x getVariable ["GRLIB_vehicle_owner", ""] == "server"
	};
	{
		[_x, "abandon"] call F_vehicleLock;
		_x setVariable ["GRLIB_vehicle_owner", "public", true];
	} forEach _trucklist;

	private _boxlist = (entities [[ammobox_o_typename], [], false, false]) select {
		_x distance2D (markerPos _liberated_sector) < 300 &&
		_x getVariable ["GRLIB_vehicle_owner", ""] == "server"
	};
	{
		[_x, "abandon"] call F_vehicleLock;
		[_x] call F_aceInitVehicle;
	} forEach _boxlist;
};

if ( _liberated_sector in sectors_factory ) then {
	_combat_readiness_increase = (3 + (floor (random 7))) * GRLIB_difficulty_modifier;
};

if ( _liberated_sector in sectors_tower ) then {
	_combat_readiness_increase = (2 + (floor (random 4)));
};

private _rwd_ammo = (100 + floor(random 100)) * GRLIB_resources_multiplier;
private _rwd_fuel = (10 + floor(random 10)) * GRLIB_resources_multiplier;
private _text = format ["Reward Received: %1 Ammo and %2 Fuel", _rwd_ammo, _rwd_fuel];
{
	if (_x distance2D (markerpos _liberated_sector) < GRLIB_sector_size ) then {
		if (_liberated_sector in (sectors_capture + sectors_bigtown) && (call is_night)) then {
			[markerPos _liberated_sector, 15] remoteExec ["remote_call_fireworks", owner _x];
		};
		[_x, _rwd_ammo, _rwd_fuel] call ammo_add_remote_call;
		[gamelogic, _text] remoteExec ["globalChat", owner _x];
	};
} forEach (AllPlayers - (entities "HeadlessClient_F"));

[markerPos _liberated_sector] call showlandmines;

combat_readiness = combat_readiness + _combat_readiness_increase;
if ( combat_readiness > 100 && GRLIB_difficulty_modifier < 2.0 ) then { combat_readiness = 100 };
publicVariable "combat_readiness";
stats_readiness_earned = stats_readiness_earned + _combat_readiness_increase;
publicVariable "stats_readiness_earned";

[ _liberated_sector, 0 ] remoteExec ["remote_call_sector", 0];

blufor_sectors pushback _liberated_sector;
publicVariable "blufor_sectors";
opfor_sectors = (sectors_allSectors - blufor_sectors);
publicVariable "opfor_sectors";
stats_sectors_liberated = stats_sectors_liberated + 1;

sleep 45;

if ( GRLIB_endgame == 0 ) then {
	if (
	   (!( _liberated_sector in sectors_tower )) &&
	   ((combat_readiness > 70) || (_liberated_sector in sectors_bigtown)) &&
	   (opforcap < GRLIB_battlegroup_cap) &&
	   (diag_fps > 30.0) && (floor random 3 > 0)
	) then {
		sleep (floor random 300);
		diag_log format ["Spawn Revenge BattlegGroup at %1", time];
		[_liberated_sector] spawn spawn_battlegroup;
	};
};

sleep 45;

if ( _liberated_sector in sectors_tower ) then {
	_pos = markerPos _liberated_sector;
	_nextower = Radio_tower createVehicle _pos;
	_nextower setpos _pos;
	_nextower setVectorUp [0,0,1];
	_nextower setVariable ["GRLIB_Radio_Tower", true, true];
	if (GRLIB_TFR_enabled) then {
		[_nextower, GRLIB_TFR_radius] call TFAR_antennas_fnc_initRadioTower;
	};
};