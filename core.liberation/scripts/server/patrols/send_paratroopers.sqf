params [ "_targetpos", ["_qrf", false] ];
if (count opfor_troup_transports_heli == 0) exitWith { grpNull };

private _name = "";
private _unload_dist = 500;
private _unit_skill = 0.65;
private _para_squad = [opfor_paratrooper,opfor_paratrooper,opfor_paratrooper,opfor_paratrooper,opfor_paratrooper,opfor_paratrooper,opfor_paratrooper,opfor_rpg];
if (_qrf == true) then {
	_name = "QRF-";
	_unload_dist = 1000;
	_unit_skill = 0.75;
	_para_squad = [opfor_squad_leader,opfor_sniper,opfor_marksman,opfor_marksman,opfor_machinegunner,opfor_rpg,opfor_rpg,opfor_at,opfor_grenadier];
};

private _vehicle = [_targetpos, selectRandom opfor_troup_transports_heli] call F_libSpawnVehicle;
private _pilot_group = group driver _vehicle;
_vehicle setVariable ["GRLIB_counter_TTL", round(time + 3600)];
{
	_x setVariable ["GRLIB_counter_TTL", round(time + 3600)];
} foreach (crew _vehicle);
sleep 1;
_vehicle flyInHeight 150;

[_pilot_group] call F_deleteWaypoints;
private _waypoint = _pilot_group addWaypoint [_targetpos, 50];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "AWARE";
_waypoint setWaypointCombatMode "RED";
_waypoint setWaypointCompletionRadius 200;
{_x doFollow (leader _pilot_group)} foreach units _pilot_group;

private _cargo_seat_free = _vehicle emptyPositions "Cargo";
if (_cargo_seat_free > 8) then { _cargo_seat_free = 8 };
if (_cargo_seat_free == 0) exitWith { _pilot_group };
diag_log format ["Spawn (%1) %2ParaTroopers objective %3 at %4", _cargo_seat_free, _name, _targetpos, time];

private _unitclass = [];
while { (count _unitclass) < _cargo_seat_free } do { _unitclass pushback (selectRandom _para_squad) };
private _para_group = [zeropos, _unitclass, GRLIB_side_enemy, "para"] call F_libSpawnUnits;
{
	_x assignAsCargoIndex [_vehicle, (_forEachIndex + 1)];
	_x moveInCargo _vehicle;
	_x setSkill _unit_skill;
	_x setSkill ["courage", 1];
	_x allowFleeing 0;
	_x setVariable ["GRLIB_counter_TTL", round(time + 3600)];
} foreach (units _para_group);

if (_vehicle isKindOf "Plane_Base_F") then { _unload_dist = _unload_dist * 2 };

[_vehicle, _targetpos, _pilot_group, _para_group, _unload_dist] spawn {
	params [ "_vehicle", "_targetpos", "_pilot_group", "_para_group", "_unload_dist"];

	waitUntil { sleep 0.2;
		!(alive _vehicle) || (damage _vehicle > 0.2 ) || (_vehicle distance2D _targetpos <= _unload_dist)
	};

	if ( { alive _x } count (units _para_group) > 0 ) then {
		[_para_group, _vehicle] spawn F_ejectGroup;
		sleep 10;
		[_para_group, _targetpos] spawn battlegroup_ai;
	};

	private _spawnpos = [];
	private _spawn_sectors = ([sectors_airspawn, [_targetpos], { (markerpos _x) distance2D _input0 }, "ASCEND"] call BIS_fnc_sortBy);
	{
		_spawnpos = markerPos _x;
		if (_spawnpos distance2D _targetpos > GRLIB_spawn_min) exitWith {};
	} foreach _spawn_sectors;

	[_pilot_group] call F_deleteWaypoints;
	_waypoint = _pilot_group addWaypoint [_spawnpos, 0];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "FULL";
	_waypoint setWaypointBehaviour "AWARE";
	_waypoint setWaypointCombatMode "RED";
	_waypoint setWaypointCompletionRadius 500;
	_waypoint setWaypointStatements ["true", "[vehicle this] spawn clean_vehicle"];
	{ _x doFollow (leader _pilot_group) } foreach (units _pilot_group);	
};

_para_group;
