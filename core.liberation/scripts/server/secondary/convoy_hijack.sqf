params [ ["_mission_cost", 0], "_caller" ];
if ( count (opfor_sectors - sectors_tower) < 4) exitWith { [gamelogic, "Could not find enough free sectors for convoy hijack mission"] remoteExec ["globalChat", 0] };

// Get Path & Check
private _max_waypoints = 5;
private _sector_list = (opfor_sectors - sectors_tower);
private _convoy_destinations_markers = [6000, _sector_list, _max_waypoints] call F_getSectorPath;
private _convoy_destinations = [_convoy_destinations_markers] call F_getPathRoadFilter;
if (count _convoy_destinations < 3) exitWith { [gamelogic, "Could not find enough free sectors for convoy hijack mission"] remoteExec ["globalChat", 0] };

// Check Box
private _boxes_amount = 0;
{
	if ( _x select 0 == opfor_transport_truck ) exitWith { _boxes_amount = (count _x) - 2 };
} foreach box_transport_config;
if ( _boxes_amount == 0 ) exitWith { diag_log "Opfor ammobox truck classname doesn't allow for ammobox transport, correct your classnames.sqf" };

//-----------------------------------------
// Start Mission
diag_log format ["--- LRX: %1 start static mission: Convoy Hijack at %2", _caller, time];
resources_intel = resources_intel - _mission_cost;
GRLIB_secondary_in_progress = 1;
publicVariable "GRLIB_secondary_in_progress";

private _spawnpos = _convoy_destinations select 0;
private _convoy_group = createGroup [GRLIB_side_enemy, true];

//-----------------------------------------
// Scout Vehicles
private _scout_class = selectRandom (opfor_vehicles_low_intensity - opfor_troup_transports_truck);
private _scout_vehicle = [_spawnpos, _scout_class, 0, GRLIB_side_enemy, "", true, true] call F_libSpawnVehicle;
(crew _scout_vehicle) joinSilent _convoy_group;
(driver _scout_vehicle) limitSpeed 40;

_scout_vehicle allowCrewInImmobile [true, true];
if (typeOf _scout_vehicle isKindOf "Wheeled_APC_F") then {
	_scout_vehicle forceFollowRoad true;
};
_scout_vehicle addEventHandler ["HandleDamage", { private [ "_damage" ]; if ( side (_this select 3) != GRLIB_side_friendly ) then { _damage = 0 } else { _damage = _this select 2 }; _damage } ];
sleep 2;

//-----------------------------------------
// Waypoints
[_convoy_group, _convoy_destinations] call add_convoy_waypoints;

//-----------------------------------------
// wait
(driver _scout_vehicle) doMove (_convoy_destinations select 1);
private _timout = round (time + (3 * 60));
waitUntil {sleep 1; _scout_vehicle distance2D _spawnpos > 30 || time > _timout};

// ammo transport
private _transport_vehicle = [_spawnpos, opfor_transport_truck, 0, GRLIB_side_enemy, "", true, true] call F_libSpawnVehicle;
(crew _transport_vehicle) joinSilent _convoy_group;

_transport_vehicle setVariable ["GRLIB_vehicle_owner", "public", true];
_transport_vehicle allowCrewInImmobile [true, true];
_transport_vehicle addEventHandler ["HandleDamage", { private [ "_damage" ]; if ( side (_this select 3) != GRLIB_side_friendly ) then { _damage = 0 } else { _damage = _this select 2 }; _damage } ];
for "_n" from 1 to _boxes_amount do { [_transport_vehicle, ammobox_o_typename] call attach_object_direct };

// wait
(driver _transport_vehicle) doMove (_convoy_destinations select 1);
private _timout = round (time + (3 * 60));
waitUntil {sleep 1; _transport_vehicle distance2D _spawnpos > 30 || time > _timout};

// troop transport
private _troop_vehicle = [_spawnpos, opfor_transport_truck, 0, GRLIB_side_enemy, "", true, true] call F_libSpawnVehicle;
(crew _troop_vehicle) joinSilent _convoy_group;

_troop_vehicle setVariable ["GRLIB_vehicle_owner", "public", true];
_troop_vehicle allowCrewInImmobile [true, true];
_troop_vehicle addEventHandler ["HandleDamage", { private [ "_damage" ]; if ( side (_this select 3) != GRLIB_side_friendly ) then { _damage = 0 } else { _damage = _this select 2 }; _damage } ];
private _troops_group = [_spawnpos, ([] call F_getAdaptiveSquadComp), GRLIB_side_enemy, "infantry", true] call F_libSpawnUnits;
[_troop_vehicle, (units _troops_group)] call F_manualCrew;

(driver _transport_vehicle) doMove (_convoy_destinations select 1);

//-----------------------------------------
// Markers
private _convoy_marker = createMarkerLocal [ format [ "convoymarker%1", round time], getpos _transport_vehicle ];
_convoy_marker setMarkerText (localize "STR_SECONDARY_CSAT_CONVOY");
_convoy_marker setMarkerType "o_armor";
_convoy_marker setMarkerColor GRLIB_color_enemy_bright;

private _convoy_marker_list = [_convoy_marker];
for "_i" from 0 to ((count _convoy_destinations) -1) do {
	_convoy_marker_wp = createMarkerLocal [ format [ "convoymarkerwp%1", _i], _convoy_destinations select _i];
	_convoy_marker_wp setMarkerText (localize "STR_SECONDARY_CSAT_CONVOY_WP");
	_convoy_marker_wp setMarkerType "o_armor";
	_convoy_marker_wp setMarkerColor GRLIB_color_enemy_bright;
	_convoy_marker_wp setMarkerSize [0.6, 0.6];
	_convoy_marker_list pushback _convoy_marker_wp;
};

[ 4, _spawnpos ] remoteExec ["remote_call_intel", 0];

//-----------------------------------------
// Manage convoy
[_convoy_group, [_scout_vehicle, _transport_vehicle, _troop_vehicle]] spawn convoy_ai;

// Mission loop
private _mission_timeout = time + 3600;	// 1 hours tiemout
private _mission_in_progress = true;

while { _mission_in_progress } do {
	if (!alive _transport_vehicle || (side group _transport_vehicle == GRLIB_side_friendly) || time > _mission_timeout) then {
		_mission_in_progress = false;
	};
	_convoy_marker setMarkerPos (getpos _transport_vehicle);
	sleep 5;
};

diag_log format ["--- LRX: %1 end static mission: Convoy Hijack at %2", _caller, time];

//-----------------------------------------
// Mission cleanup
{ deleteMarker _x } foreach _convoy_marker_list;

if (time > _mission_timeout || !alive _transport_vehicle) then {
	combat_readiness = combat_readiness + 5;
	if ( combat_readiness > 100 && GRLIB_difficulty_modifier < 2 ) then { combat_readiness = 100 };
	[51] remoteExec ["remote_call_intel", 0];
} else {
	combat_readiness = 15 max (combat_readiness - 10);
	stats_secondary_objectives = stats_secondary_objectives + 1;
	[5] remoteExec ["remote_call_intel", 0];
};

private _vehicles = [_scout_vehicle, _transport_vehicle, _troop_vehicle];
[_vehicles] spawn cleanMissionVehicles;

sleep 120;
GRLIB_secondary_in_progress = -1;
publicVariable "GRLIB_secondary_in_progress";
sleep 1;
