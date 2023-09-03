params [ "_targetpos", ["_qrf", false] ];

private _unload_dist = 400;
private _unit_skill = 0.65;
private _para_squad = [opfor_paratrooper,opfor_paratrooper,opfor_paratrooper,opfor_paratrooper,opfor_paratrooper,opfor_paratrooper,opfor_paratrooper,opfor_rpg];
if (_qrf == true) then {
	_unload_dist = 1000;
	_unit_skill = 0.75;
	_para_squad = [opfor_squad_leader,opfor_sniper,opfor_marksman,opfor_marksman,opfor_machinegunner,opfor_rpg,opfor_rpg,opfor_at,opfor_grenadier];
};

private _spawnsector = ( [ sectors_airspawn , [ _targetpos ] , { (markerpos _x) distance2D _input0 }, "ASCEND"] call BIS_fnc_sortBy ) select 0;
private _newvehicle = [markerpos _spawnsector, selectRandom opfor_troup_transports_heli] call F_libSpawnVehicle;
private _pilot_group = createGroup [GRLIB_side_enemy, true];
(crew _newvehicle) joinSilent _pilot_group;

_newvehicle setVariable ["GRLIB_counter_TTL", round(time + 3600)];
{
	_x setVariable ["GRLIB_counter_TTL", round(time + 3600)];
} foreach (crew _newvehicle);
sleep 1;
_newvehicle flyInHeight 150;

[_pilot_group] call F_deleteWaypoints;
private _waypoint = _pilot_group addWaypoint [ _targetpos, 50];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "CARELESS";
_waypoint setWaypointCombatMode "WHITE";
_waypoint setWaypointCompletionRadius 200;
{_x doFollow (leader _pilot_group)} foreach units _pilot_group;

private _cargo_seat_free = _newvehicle emptyPositions "Cargo";
if (_cargo_seat_free > 8) then { _cargo_seat_free = 8 };
if (_cargo_seat_free == 0) exitWith { _pilot_group };
diag_log format ["Spawn (%1) ParaTroopers (%2) objective %3 at %4", _cargo_seat_free, _qrf, _targetpos, time];

private _unitclass = [];
while { (count _unitclass) < _cargo_seat_free } do { _unitclass pushback (selectRandom _para_squad) };
private _para_group = [markerpos _spawnsector, _unitclass, GRLIB_side_enemy, "para"] call F_libSpawnUnits;
{
	_x assignAsCargoIndex [_newvehicle, _forEachIndex + 1];
	_x moveInCargo _newvehicle;
	[_x] orderGetIn true;
	_x setSkill _unit_skill;
	_x setSkill ["courage", 1];
	_x allowFleeing 0;
	_x setVariable ["GRLIB_counter_TTL", round(time + 3600)];
} foreach (units _para_group);

[_newvehicle, _targetpos, _pilot_group, _para_group, _unload_dist] spawn {
	params [ "_newvehicle", "_targetpos", "_pilot_group", "_para_group", "_unload_dist"];

	waitUntil { sleep 0.5;
		!(alive _newvehicle) || (damage _newvehicle > 0.2 ) || (_newvehicle distance2D _targetpos <= _unload_dist)
	};

	[_para_group, _newvehicle] spawn F_ejectGroup;
	sleep 10;
	_newvehicle flyInHeight 300;
	[_para_group, _targetpos] spawn battlegroup_ai;
	[_pilot_group, _targetpos, 400] spawn add_defense_waypoints;
};

_para_group;
