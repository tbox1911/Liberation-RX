params [ "_targetpos" ];

private _spawnsector = ( [ sectors_airspawn , [ _targetpos ] , { (markerpos _x) distance2D _input0 }, "ASCEND"] call BIS_fnc_sortBy ) select 0;

private _newvehicle = [markerpos _spawnsector, selectRandom opfor_troup_transports_heli] call F_libSpawnVehicle;
private _pilot_group = createGroup [GRLIB_side_enemy, true];
(crew _newvehicle) joinSilent _pilot_group;

_newvehicle setVariable ["GRLIB_counter_TTL", round(time + 3600)];
{
	_x setVariable ["GRLIB_counter_TTL", round(time + 3600)];
} foreach (crew _newvehicle);
sleep 1;

private _cargo_seat_free = _newvehicle emptyPositions "Cargo";
if (_cargo_seat_free > 8) then {_cargo_seat_free = 8};
diag_log format ["Spawn (%1) ParaTroopers objective %2 at %3", _cargo_seat_free, _targetpos, time];

private _unitclass = [];
private _para_squad = [opfor_paratrooper,opfor_paratrooper,opfor_paratrooper,opfor_paratrooper,opfor_paratrooper,opfor_paratrooper,opfor_paratrooper,opfor_rpg];
while { (count _unitclass) < _cargo_seat_free } do { _unitclass pushback (selectRandom _para_squad) };
private _para_group = [markerpos _spawnsector, _unitclass, GRLIB_side_enemy, "para"] call F_libSpawnUnits;
{
	_x assignAsCargoIndex [_newvehicle, _forEachIndex + 1];
	_x moveInCargo _newvehicle;
	[_x] orderGetIn true;
	_x setSkill 0.65;
	_x setSkill ["courage", 1];
	_x allowFleeing 0;
	_x setVariable ["GRLIB_counter_TTL", round(time + 3600)];
} foreach (units _para_group);

[_pilot_group] call F_deleteWaypoints;
private _waypoint = _pilot_group addWaypoint [ _targetpos, 300];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "CARELESS";
_waypoint setWaypointCombatMode "BLUE";
_waypoint setWaypointCompletionRadius 20;
_waypoint = _pilot_group addWaypoint [ _targetpos, 150];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointCompletionRadius 20;
_waypoint = _pilot_group addWaypoint [ _targetpos, 1];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointCompletionRadius 20;
{_x doFollow (leader _pilot_group)} foreach units _pilot_group;

[_newvehicle, _targetpos, _pilot_group, _para_group] spawn {
	params [ "_newvehicle", "_targetpos", "_pilot_group", "_para_group"];

	waitUntil { sleep 1;
		if (_newvehicle distance2D _targetpos < 600) then { _newvehicle flyInHeight 100 };
		!(alive _newvehicle) || (damage _newvehicle > 0.2 ) || (_newvehicle distance2D _targetpos < 300)
	};

	{ [_newvehicle, _x] spawn F_ejectUnit } forEach (units _para_group);
	[_para_group, _targetpos] spawn battlegroup_ai;

	sleep 5;
	[_pilot_group] call F_deleteWaypoints;
	private _waypoint = _pilot_group addWaypoint [ _targetpos, 300];
	_waypoint setWaypointType "SAD";
	_waypoint setWaypointSpeed "NORMAL";
	_waypoint setWaypointBehaviour "COMBAT";
	_waypoint setWaypointCombatMode "RED";
	_waypoint setWaypointType "SAD";
	_waypoint = _pilot_group addWaypoint [_targetpos, 300];
	_waypoint setWaypointType "SAD";
	_waypoint = _pilot_group addWaypoint [_targetpos, 300];
	_waypoint setWaypointType "SAD";
	_waypoint = _pilot_group addWaypoint [_targetpos, 300];
	_waypoint setWaypointType "CYCLE";
	{_x doFollow (leader _pilot_group)} foreach units _pilot_group;

	_newvehicle flyInHeight 300;
};

_para_group;
