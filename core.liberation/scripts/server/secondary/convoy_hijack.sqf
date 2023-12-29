params [ ["_mission_cost", 0], "_caller" ];
if ( count (opfor_sectors - sectors_tower) < 4) exitWith { [gamelogic, "Could not find enough free sectors for convoy hijack mission"] remoteExec ["globalChat", 0] };

private _convoy_destinations_markers = [];
private _max_try = 20;
private _max_waypoints = 6;
private _sector_list = (opfor_sectors - sectors_tower);

while { count _convoy_destinations_markers < _max_waypoints && _max_try > 0} do {
	_start_pos = selectRandom _sector_list;
	_convoy_destinations_markers = [_start_pos, 4000, _sector_list, _max_waypoints] call F_getSectorPath;
    _max_try = _max_try - 1;
};

if ( count _convoy_destinations_markers < 4) exitWith { [gamelogic, "Could not find enough free sectors for convoy hijack mission"] remoteExec ["globalChat", 0] };

private _boxes_amount = 0;
{
	if ( _x select 0 == opfor_transport_truck ) exitWith { _boxes_amount = (count _x) - 2 };
} foreach box_transport_config;
if ( _boxes_amount == 0 ) exitWith { diag_log "Opfor ammobox truck classname doesn't allow for ammobox transport, correct your classnames.sqf"; };

diag_log format ["--- LRX: %1 start static mission: Convoy Hijack at %2", _caller, time];
resources_intel = resources_intel - _mission_cost;
GRLIB_secondary_in_progress = 1;
publicVariable "GRLIB_secondary_in_progress";

private _convoy_destinations = [];
{
	private _nearestroad = [markerpos _x, 100] call BIS_fnc_nearestRoad;
	if ( isNull _nearestroad ) then {
		_convoy_destinations pushback (markerPos _x);
	} else {
		_convoy_destinations pushback (getpos _nearestroad);
	};
 } foreach _convoy_destinations_markers;

private _spawnpos = _convoy_destinations select 0;
private _convoy_group = createGroup [GRLIB_side_enemy, true];

//-----------------------------------------
// Scout Vehicles
private _scout_vehicle = [_spawnpos, selectRandom (opfor_vehicles_low_intensity - opfor_troup_transports_truck), true] call F_libSpawnVehicle;
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
[_convoy_group] call F_deleteWaypoints;
for "_i" from 1 to ((count _convoy_destinations) -1) do {
	private _waypoint = _convoy_group addWaypoint [ _convoy_destinations select _i, 100];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointCombatMode "WHITE";
	_waypoint setWaypointCompletionRadius 200;
};
_waypoint = _convoy_group addWaypoint [_convoy_destinations select 1, 0];
_waypoint setWaypointType "CYCLE";
_waypoint setWaypointCompletionRadius 200;
{_x doFollow (leader _convoy_group)} foreach units _convoy_group;

(driver _scout_vehicle) MoveTo (_convoy_destinations select 1);

//-----------------------------------------
// ammo transport
private _timout = round (time + (3 * 60));
waitUntil {sleep 1; _scout_vehicle distance2D _spawnpos > 30 || time > _timout};
private _transport_vehicle = [_spawnpos, opfor_transport_truck, true] call F_libSpawnVehicle;
(crew _transport_vehicle) joinSilent _convoy_group;

_transport_vehicle setConvoySeparation 40;
_transport_vehicle allowCrewInImmobile [true, true];
_transport_vehicle addEventHandler ["HandleDamage", { private [ "_damage" ]; if ( side (_this select 3) != GRLIB_side_friendly ) then { _damage = 0 } else { _damage = _this select 2 }; _damage } ];
for "_n" from 1 to _boxes_amount do { [_transport_vehicle, ammobox_o_typename] call attach_object_direct };
(driver _transport_vehicle) MoveTo (_convoy_destinations select 1);

// troop transport
private _timout = round (time + (3 * 60));
waitUntil {sleep 1; _transport_vehicle distance2D _spawnpos > 30 || time > _timout};
private _troop_vehicle = [_spawnpos, opfor_transport_truck, true] call F_libSpawnVehicle;
(crew _troop_vehicle) joinSilent _convoy_group;

_troop_vehicle setConvoySeparation 40;
_troop_vehicle allowCrewInImmobile [true, true];
_troop_vehicle addEventHandler ["HandleDamage", { private [ "_damage" ]; if ( side (_this select 3) != GRLIB_side_friendly ) then { _damage = 0 } else { _damage = _this select 2 }; _damage } ];
private _troops_group = [_spawnpos, ([] call F_getAdaptiveSquadComp), GRLIB_side_enemy, "infantry"] call F_libSpawnUnits;
{
	_x assignAsCargoIndex [_troop_vehicle, (_forEachIndex + 1)];
	_x moveInCargo _troop_vehicle;
	_x setSkill 0.65;
	_x setSkill ["courage", 1];
	_x allowFleeing 0;
} foreach (units _troops_group);
(driver _transport_vehicle) MoveTo (_convoy_destinations select 1);

_convoy_group setFormation "COLUMN";
_convoy_group setBehaviour "AWARE";
_convoy_group setCombatMode "WHITE";
_convoy_group setSpeedMode "LIMITED";

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
// Mission loop
private _mission_timeout = time + (2*3600);	// 2 hours tiemout
private _mission_in_progress = true;
private _convoy_attacked = false;
private _convoy_flee = false;
private _disembark_troops = false;

while { _mission_in_progress } do {
	if ( !(alive _transport_vehicle) || (side group _transport_vehicle == GRLIB_side_friendly) || time >= _mission_timeout) then {
		_mission_in_progress = false;
	};

	_convoy_marker setMarkerPos (getpos _transport_vehicle);

	if ( !_convoy_attacked ) then {
		{
			_killed = ({!(alive _x)} count (crew _x) > 0);
			if ( !(alive _x) || (damage _x > 0.3) || _killed && (count ([getPosATL _x, 3000] call F_getNearbyPlayers) > 0) ) then { _convoy_attacked = true; };
		} foreach [_scout_vehicle, _transport_vehicle, _troop_vehicle];
	};

	if ( _convoy_attacked && !_disembark_troops) then {
		_disembark_troops = true;
		{ _x removeAllEventHandlers "HandleDamage" } foreach [_scout_vehicle, _transport_vehicle, _troop_vehicle];
		[_troops_group, _troop_vehicle] spawn F_ejectGroup;
		_troops_group setCombatBehaviour "COMBAT";
		_troops_group setCombatMode "RED";
		[_troops_group, getPosATL _troop_vehicle, 30] spawn add_defense_waypoints;
	};

	if ( _convoy_attacked && !_convoy_flee) then {
		_convoy_flee = true;
		_convoy_group setCombatBehaviour "COMBAT";
		_convoy_group setSpeedMode "FULL";
	};

	_veh_leader = vehicle (leader _convoy_group);
	{
		_veh = vehicle _x;
		if (_x == driver _veh && speed _veh < 2 && (_x distance2D _veh_leader > 50 || _veh == vehicle _veh_leader) && behaviour _x != "COMBAT") then {
			_veh setFuel 1;
			_veh setDamage 0;
			[_veh] execVM "scripts\client\actions\do_unflip.sqf";
			if (_veh != _veh_leader) then { _x doFollow (leader _convoy_group) };
			sleep 60;
		};
	} forEach (units _convoy_group);
	sleep 5;
};

//-----------------------------------------
// Mission cleanup
{ deleteMarker _x } foreach _convoy_marker_list;
if (time < _mission_timeout) then {
	if (side group _transport_vehicle == GRLIB_side_friendly) then {
		combat_readiness = combat_readiness - 0.25;
		if ( combat_readiness < 0 ) then { combat_readiness = 0 };
		stats_secondary_objectives = stats_secondary_objectives + 1;
	} else {
		combat_readiness = combat_readiness + 0.25;
		if ( combat_readiness > 100 && GRLIB_difficulty_modifier < 2 ) then { combat_readiness = 100 };
	};
	[ 5 ] remoteExec ["remote_call_intel", 0];
};
private _vehicles = [_scout_vehicle, _troop_vehicle];
[_vehicles, 5] spawn cleanMissionVehicles;

sleep 120;
GRLIB_secondary_in_progress = -1;
publicVariable "GRLIB_secondary_in_progress";
sleep 1;
