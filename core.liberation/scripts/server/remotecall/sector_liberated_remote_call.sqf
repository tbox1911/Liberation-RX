params [ "_liberated_sector" ];
diag_log format ["Sector %1 liberated", _liberated_sector];
private _combat_readiness_increase = 0;

if ( _liberated_sector in sectors_bigtown ) then {
	_combat_readiness_increase = (5 + (floor (random 10))) * GRLIB_difficulty_modifier;
};

if ( _liberated_sector in sectors_capture ) then {
	_combat_readiness_increase = (3 + (floor (random 5))) * GRLIB_difficulty_modifier;
};

if ( _liberated_sector in sectors_military ) then {
	_combat_readiness_increase = (5 + (floor (random 10))) * GRLIB_difficulty_modifier;

	private _trucklist = [entities [[opfor_transport_truck], [], false, false], {
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

if ( _liberated_sector in sectors_factory ) then {
	_combat_readiness_increase = (3 + (floor (random 7))) * GRLIB_difficulty_modifier;
};

if ( _liberated_sector in sectors_tower ) then {
	_combat_readiness_increase = (2 + (floor (random 4)));
};

[ 
	[_liberated_sector], 
{
	params ["_sector"];
	private _rwd_ammo = (100 + floor(random 100)) * GRLIB_resources_multiplier;
	private _rwd_fuel = (10 + floor(random 10)) * GRLIB_resources_multiplier;
	private _text = format ["Reward Received: %1 Ammo and %2 Fuel", _rwd_ammo, _rwd_fuel];

	{
		if (_x distance2D (markerpos _sector) < GRLIB_sector_size ) then {
			[_x, _rwd_ammo, _rwd_fuel] call ammo_add_remote_call;
			[gamelogic, _text] remoteExec ["globalChat", owner _x];
		};
	} forEach (AllPlayers - (entities "HeadlessClient_F"));
}] remoteExec ["bis_fnc_call", 2];

[markerPos _liberated_sector] call showlandmines;

combat_readiness = combat_readiness + _combat_readiness_increase;
if ( combat_readiness > 100 && GRLIB_difficulty_modifier <= 2.0 ) then { combat_readiness = 100 };
stats_readiness_earned = stats_readiness_earned + _combat_readiness_increase;
publicVariable "stats_readiness_earned";

[ _liberated_sector, 0 ] remoteExec ["remote_call_sector", 0];
blufor_sectors pushback _liberated_sector; publicVariable "blufor_sectors";
stats_sectors_liberated = stats_sectors_liberated + 1;

if (isServer) then {
	[] spawn check_victory_conditions;
} else {
	[] remoteExec ["check_victory_conditions", 2];
};

sleep 45;

if ( GRLIB_endgame == 0 ) then {
	if ( 
	   (!( _liberated_sector in sectors_tower )) &&
	   ((combat_readiness > 70) || (_liberated_sector in sectors_bigtown)) &&
	   ([] call F_opforCap < GRLIB_battlegroup_cap) &&
	   (diag_fps > 30.0)
	) then {
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
};