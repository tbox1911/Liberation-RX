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

private _cargo_seat_free = count (fullCrew [_newvehicle, "cargo", true] - fullCrew [_newvehicle, "cargo", false]);
if (_cargo_seat_free > 8) then {_cargo_seat_free = 8};
if ((typeOf _newvehicle) isKindOf "CUP_MH6_TRANSPORT") then {_cargo_seat_free = 6};
diag_log format ["Spawn (%1) ParaTroopers on sector %2 at %3", _cargo_seat_free, _spawnsector, time];

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

[_newvehicle, _targetpos, _pilot_group, _para_group] spawn {
	params [ "_newvehicle", "_targetpos", "_pilot_group", "_para_group"];
	private ["_waypoint"];
	while {(count (waypoints _pilot_group)) != 0} do {deleteWaypoint ((waypoints _pilot_group) select 0);};
	while {(count (waypoints _para_group)) != 0} do {deleteWaypoint ((waypoints _para_group) select 0);};
	sleep 1;

	_waypoint = _pilot_group addWaypoint [ _targetpos, 300];
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

	waitUntil { sleep 1;
		!(alive _newvehicle) || (damage _newvehicle > 0.2 ) || (_newvehicle distance2D _targetpos < 300)
	};

	_newvehicle flyInHeight 200;
	sleep 2;
	{
		_x allowDamage false;
		unassignVehicle _x;
		moveout _x;
		if (_x getVariable ["GRLIB_para_backpack", ""] != "") then {
			[_x] spawn {
				params ["_unit"];
				waituntil {sleep 1; !(alive _unit) || (isTouchingGround _unit)};
				if (!(alive _unit)) exitWith {};
				_unit addBackpack (_unit getVariable ["GRLIB_para_backpack", ""]);
				clearAllItemsFromBackpack _unit;
				{_unit addItemToBackpack _x} foreach (_unit getVariable ["GRLIB_para_backpack_contents", []]);
			};
		};
		sleep 0.5;
	} foreach (units _para_group);

	sleep 3;
	{ _x allowDamage true } foreach (units _para_group);

	while {(count (waypoints _pilot_group)) != 0} do {deleteWaypoint ((waypoints _pilot_group) select 0);};
	while {(count (waypoints _para_group)) != 0} do {deleteWaypoint ((waypoints _para_group) select 0);};
	sleep 1;

	_waypoint = _pilot_group addWaypoint [ _targetpos, 200];
	_waypoint setWaypointBehaviour "COMBAT";
	_waypoint setWaypointCombatMode "RED";
	_waypoint setWaypointType "SAD";
	_waypoint = _pilot_group addWaypoint [ _targetpos, 200];
	_waypoint setWaypointBehaviour "COMBAT";
	_waypoint setWaypointCombatMode "RED";
	_waypoint setWaypointType "SAD";
	_waypoint = _pilot_group addWaypoint [ _targetpos, 200];
	_waypoint setWaypointBehaviour "COMBAT";
	_waypoint setWaypointCombatMode "RED";
	_waypoint setWaypointType "SAD";
	_waypoint = _pilot_group addWaypoint [ _targetpos, 200];
	_waypoint setWaypointType "SAD";
	_waypoint = _pilot_group addWaypoint [ _targetpos, 200];
	_waypoint setWaypointType "CYCLE";

	[_para_group] spawn battlegroup_ai;
};

_para_group;
