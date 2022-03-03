if ( count (sectors_allSectors - blufor_sectors - sectors_tower) < 4) exitWith { [gamelogic, "Could not find enough free sectors for convoy hijack mission"] remoteExec ["globalChat", 0] };

private _convoy_destinations_markers = [];
private _max_try = 10;
private _max_waypoints = 6;
_sector_list = (sectors_allSectors - blufor_sectors - sectors_tower - sectors_military);

while { count _convoy_destinations_markers != _max_waypoints && _max_try > 0} do {
	_start_pos = selectRandom _sector_list;
	_convoy_destinations_markers = [_start_pos, 4000, _sector_list, _max_waypoints] call F_getSectorPath;
    _max_try = _max_try - 1;
};

if ( count _convoy_destinations_markers < 3) exitWith { [gamelogic, "Could not find enough free sectors for convoy hijack mission"] remoteExec ["globalChat", 0] };

private _boxes_amount = 0;
{
	if ( _x select 0 == opfor_ammobox_transport ) exitWith { _boxes_amount = (count _x) - 2 };
} foreach box_transport_config;
if ( _boxes_amount == 0 ) exitWith { diag_log "Opfor ammobox truck classname doesn't allow for ammobox transport, correct your classnames.sqf"; };

params [ ["_mission_cost", 0] ];
resources_intel = resources_intel - _mission_cost;
GRLIB_secondary_in_progress = 1; publicVariable "GRLIB_secondary_in_progress";

private _convoy_destinations = [];
{
	private _nearestroad = [ markerpos _x, 200, [] ] call BIS_fnc_nearestRoad;
	if ( isNull _nearestroad ) then {
		_convoy_destinations pushback (markerPos _x);
	} else {
		_convoy_destinations pushback (getpos _nearestroad);
	};
 } foreach _convoy_destinations_markers;

private _spawnpos = _convoy_destinations select 0;
[ 4, _spawnpos ] remoteExec ["remote_call_intel", 0];

private _convoy_group = createGroup [GRLIB_side_enemy, true];

// scout
private _scout_vehicle = [_spawnpos, selectRandom opfor_vehicles_low_intensity, true, false ] call F_libSpawnVehicle;
_scout_vehicle addEventHandler ["HandleDamage", { private [ "_damage" ]; if ( side (_this select 3) != GRLIB_side_friendly ) then { _damage = 0 } else { _damage = _this select 2 }; _damage } ];
( crew _scout_vehicle ) joinSilent _convoy_group;

//-----------------------------------------
// Waypoints
sleep 0.5;

_convoy_group setFormation "FILE";
_convoy_group setBehaviour "SAFE";
_convoy_group setCombatMode "GREEN";
_convoy_group setSpeedMode "LIMITED";

while {(count (waypoints _convoy_group)) != 0} do {deleteWaypoint ((waypoints _convoy_group) select 0);};
{_x doFollow leader _convoy_group} foreach units _convoy_group;

for "_i" from 1 to ((count _convoy_destinations) -1) do {
	_waypoint = _convoy_group addWaypoint [_convoy_destinations select _i, 0];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "LIMITED";
	_waypoint setWaypointBehaviour "SAFE";
	_waypoint setWaypointCombatMode "GREEN";
	_waypoint setWaypointCompletionRadius 100;
};

// Back and cycle
_waypoint = _convoy_group addWaypoint [_convoy_destinations select 0, 0];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointCompletionRadius 100;

_waypoint = _convoy_group addWaypoint [_convoy_destinations select 0, 0];
_waypoint setWaypointType "CYCLE";
_waypoint setWaypointCompletionRadius 100;

//-----------------------------------------
// ammo transport
sleep 10;
waitUntil {sleep 2; speed _scout_vehicle > 2 || !(alive _scout_vehicle)};

private _transport_vehicle = [ _spawnpos, opfor_ammobox_transport, true, false ] call F_libSpawnVehicle;
_transport_vehicle addEventHandler ["HandleDamage", { private [ "_damage" ]; if ( side (_this select 3) != GRLIB_side_friendly ) then { _damage = 0 } else { _damage = _this select 2 }; _damage } ];
for "_n" from 1 to _boxes_amount do { [_transport_vehicle, ammobox_o_typename] call attach_object_direct };
( crew _transport_vehicle ) joinSilent _convoy_group;

// troop transport
sleep 10;
waitUntil {sleep 2; speed _transport_vehicle > 2 || !(alive _transport_vehicle) };
private _troop_vehicle = [ _spawnpos, opfor_transport_truck, true, false ] call F_libSpawnVehicle;
_troop_vehicle addEventHandler ["HandleDamage", { private [ "_damage" ]; if ( side (_this select 3) != GRLIB_side_friendly ) then { _damage = 0 } else { _damage = _this select 2 }; _damage } ];

private _troops_group = createGroup [GRLIB_side_enemy, true];
{ _x createUnit [_spawnpos, _troops_group,'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]', 0.65, "PRIVATE"] } foreach ([] call F_getAdaptiveSquadComp);
{ _x moveInCargo _troop_vehicle } foreach (units _troops_group);
( crew _troop_vehicle ) joinSilent _convoy_group;
//-----------------------------------------

// Markers
private _convoy_marker = createMarkerLocal [ format [ "convoymarker%1", round time], getpos _transport_vehicle ];
_convoy_marker setMarkerText (localize "STR_SECONDARY_CSAT_CONVOY");
_convoy_marker setMarkerType "o_armor";
_convoy_marker setMarkerColor GRLIB_color_enemy_bright;

private _convoy_marker_list = [];
for "_i" from 0 to ((count _convoy_destinations) -1) do {
	_convoy_marker_wp = createMarkerLocal [ format [ "convoymarkerwp%1", _i], _convoy_destinations select _i];
	_convoy_marker_wp setMarkerText (localize "STR_SECONDARY_CSAT_CONVOY_WP");
	_convoy_marker_wp setMarkerType "o_armor";
	_convoy_marker_wp setMarkerColor GRLIB_color_enemy_bright;
	_convoy_marker_wp setMarkerSize [0.6, 0.6];
	_convoy_marker_list pushback _convoy_marker_wp;
};
//-----------------------------------------

private _mission_in_progress = true;
private _convoy_attacked = false;
private _convoy_flee = false;
private _disembark_troops = false;

while { _mission_in_progress } do {

	if ( !(alive _transport_vehicle) || !(alive driver _transport_vehicle) ) then {
		_mission_in_progress = false;
	};

	_convoy_marker setMarkerPos (getpos _transport_vehicle);

	if ( !_convoy_attacked ) then {
		{
			if ( !(alive _x) || (damage _x > 0.3) || !(alive driver _x)) exitWith { _convoy_attacked = true; };
		} foreach [_scout_vehicle, _transport_vehicle, _troop_vehicle];
	};

	if ( _convoy_attacked && !_disembark_troops) then {

		_disembark_troops = true;
		{
			unAssignVehicle _x;
			_x action ["eject", vehicle _x];
			_x action ["getout", vehicle _x];
			sleep 0.2;
		} foreach ( crew _troop_vehicle );

		_troops_group setBehaviour "COMBAT";
		_troops_group setCombatMode "RED";
	};

	if ( _convoy_attacked && !_convoy_flee) then {
		_convoy_flee = true;
		_convoy_group setBehaviour "COMBAT";
		_convoy_group setSpeedMode "FULL";
	};

	sleep 2;
};

sleep 20;

deleteMarker _convoy_marker;
{ deleteMarker _x } foreach _convoy_marker_list;
{ moveOut _x; deleteVehicle _x } forEach units _troops_group;

combat_readiness = round (combat_readiness * (GRLIB_secondary_objective_impact / 2) );
stats_secondary_objectives = stats_secondary_objectives + 1;
[ 5 ] remoteExec ["remote_call_intel", 0];
GRLIB_secondary_in_progress = -1; publicVariable "GRLIB_secondary_in_progress";
sleep 1;
trigger_server_save = true;
