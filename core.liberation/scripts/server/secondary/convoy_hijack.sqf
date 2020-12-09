if ( count (sectors_allSectors - blufor_sectors - sectors_tower) < 4) exitWith { [gamelogic, "Could not find enough free sectors for convoy hijack mission"] remoteExec ["globalChat", 0] };

private _convoy_destinations_markers = [];
private _max_try = 10;
private _max_waypoints = 4;
_sector_list = (sectors_allSectors - blufor_sectors - sectors_tower);

while { count _convoy_destinations_markers != _max_waypoints && _max_try > 0} do {
	_start_pos = _sector_list call BIS_fnc_selectRandom;
	_convoy_destinations_markers = [_start_pos, 2000, _sector_list, _max_waypoints] call F_getSectorPath;
    _max_try = _max_try - 1;
};

if ( count _convoy_destinations_markers < 3) exitWith { [gamelogic, "Could not find enough free sectors for convoy hijack mission"] remoteExec ["globalChat", 0] };

params [ ["_mission_cost", 0] ];
resources_intel = resources_intel - _mission_cost;

private _convoy_destinations = [];
{ _convoy_destinations pushback (getMarkerPos _x); } foreach _convoy_destinations_markers;

private _spawnpos = _convoy_destinations select 0;
[ [ 4, _spawnpos ] , "remote_call_intel" ] call BIS_fnc_MP;

private _scout_vehicle = [ [ _spawnpos, 30, 0 ] call BIS_fnc_relPos, opfor_mrap, false, false, false ] call F_libSpawnVehicle;
private _escort_vehicle = [ [ _spawnpos, 10, 0 ] call BIS_fnc_relPos, opfor_vehicles_low_intensity call BIS_fnc_selectRandom, false, false, false ] call F_libSpawnVehicle;
private _transport_vehicle = [ [ _spawnpos, 10, 180 ] call BIS_fnc_relPos, opfor_ammobox_transport, false, true, false ] call F_libSpawnVehicle;

private _boxes_amount = 0;
{
	if ( _x select 0 == opfor_ammobox_transport ) exitWith { _boxes_amount = (count _x) - 2 };
} foreach box_transport_config;

if ( _boxes_amount == 0 ) exitWith { diag_log "Opfor ammobox truck classname doesn't allow for ammobox transport, correct your classnames.sqf"; };

GRLIB_secondary_in_progress = 1; publicVariable "GRLIB_secondary_in_progress";

for "_n" from 1 to _boxes_amount do {
	[_transport_vehicle, ammobox_o_typename] call attach_object_direct;
	sleep 0.5;
};

private _troop_vehicle = [ [ _spawnpos, 30, 180 ] call BIS_fnc_relPos, opfor_transport_truck, false, true, false ] call F_libSpawnVehicle;

sleep 0.5;

private _convoy_group = group driver _scout_vehicle;
( crew _escort_vehicle + crew _transport_vehicle + crew _troop_vehicle ) joinSilent _convoy_group;

sleep 0.5;

{
	_x addEventHandler ["HandleDamage", { private [ "_damage" ]; if ( side (_this select 3) != GRLIB_side_friendly ) then { _damage = 0 } else { _damage = _this select 2 }; _damage } ];
} foreach [ _scout_vehicle, _escort_vehicle, _transport_vehicle, _troop_vehicle ];

_convoy_group setFormation "FILE";
_convoy_group setBehaviour "SAFE";
_convoy_group setCombatMode "GREEN";
_convoy_group setSpeedMode "LIMITED";

while {(count (waypoints _convoy_group)) != 0} do {deleteWaypoint ((waypoints _convoy_group) select 0);};
{_x doFollow leader _convoy_group} foreach units _convoy_group;

for "_i" from 1 to ((count _convoy_destinations) -1) do {
	_waypoint = _convoy_group addWaypoint [_convoy_destinations select _i, 0];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointCompletionRadius 50;
};

// Back and cycle
_waypoint = _convoy_group addWaypoint [_convoy_destinations select 0, 0];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointCompletionRadius 50;

_waypoint = _convoy_group addWaypoint [_convoy_destinations select 0, 0];
_waypoint setWaypointType "CYCLE";
_waypoint setWaypointCompletionRadius 50;

private _troops_group = createGroup [GRLIB_side_enemy, true];
{ _x createUnit [_spawnpos, _troops_group,"this addMPEventHandler [""MPKilled"", {_this spawn kill_manager}]", 0.5, "private"]; } foreach ([] call F_getAdaptiveSquadComp);
{ _x moveInCargo _troop_vehicle } foreach (units _troops_group);

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
		} foreach [_scout_vehicle, _escort_vehicle, _transport_vehicle, _troop_vehicle];
	};

	if ( _convoy_attacked && !_disembark_troops) then {

		_disembark_troops = true;

		if (alive (driver _troop_vehicle)) then {
			private _troop_driver_group = (createGroup [GRLIB_side_enemy, true]);
			[ driver _troop_vehicle ] joinSilent _troop_driver_group;
			sleep 1;
			while {(count (waypoints _troop_driver_group)) != 0} do {deleteWaypoint ((waypoints _troop_driver_group) select 0);};
			_waypoint = _troop_driver_group addWaypoint [getpos _troop_vehicle, 0];
			_waypoint setWaypointType "MOVE";
			sleep 3;
		};

		{
			unAssignVehicle _x;
			_x action ["eject", vehicle _x];
			_x action ["getout", vehicle _x];
			unAssignVehicle _x;
			sleep 0.7;
		} foreach (units _troops_group);

		_troops_group setBehaviour "COMBAT";
		_troops_group setCombatMode "RED";
	};

	if ( _convoy_attacked && !_convoy_flee) then {
		_convoy_flee = true;
		_convoy_group setBehaviour "COMBAT";
		_convoy_group setSpeedMode "FULL";
	};

	sleep 5;
};

sleep 20;

deleteMarker _convoy_marker;
{ deleteMarker _x } foreach _convoy_marker_list;
{ moveOut _x; deleteVehicle _x } forEach units _troops_group;

combat_readiness = round (combat_readiness * 0.85);
stats_secondary_objectives = stats_secondary_objectives + 1;
[ [ 5 ] , "remote_call_intel" ] call BIS_fnc_MP;
GRLIB_secondary_in_progress = -1; publicVariable "GRLIB_secondary_in_progress";
sleep 1;
trigger_server_save = true;
