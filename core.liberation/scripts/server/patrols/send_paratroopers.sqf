params [ "_targetpos" ];

private _sendPara = {
	params [ "_targetpos", "_para_group" ];

	private _spawnsector = ( [ sectors_airspawn , [ _targetpos ] , { (markerpos _x) distance _input0 }, "ASCEND"] call BIS_fnc_sortBy ) select 0;
	private _pilot_group = createGroup [GRLIB_side_enemy, true];
	private _newvehicle = [markerpos _spawnsector, selectRandom opfor_choppers] call F_libSpawnVehicle;
	(crew _newvehicle) joinSilent _pilot_group;
	_newvehicle setVariable ["GRLIB_counter_TTL", round(time + 3600)];
	{
		_x setVariable ["GRLIB_counter_TTL", round(time + 3600)];
	} foreach (crew _newvehicle);
	sleep 0.2;

	private _cargo_seat_free = count (fullCrew [_newvehicle, "cargo", true] - fullCrew [_newvehicle, "cargo", false]);
	if (_cargo_seat_free > 8) then {_cargo_seat_free = 8};
	for "_i" from 1 to _cargo_seat_free do {
		_unit = _para_group createUnit [opfor_paratrooper, getmarkerpos _spawnsector, [], 0, "NONE"];
		_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		_unit assignAsCargo _newvehicle;
		_unit moveInCargo _newvehicle;
		_unit addBackpack "B_Parachute";
		_unit setSkill 0.65;
		_unit setSkill ["courage", 1];
		_unit allowFleeing 0;
		_unit setVariable ["GRLIB_counter_TTL", round(time + 3600)];
		sleep 0.1;
	};
	(units _para_group) joinSilent _para_group;
	while {(count (waypoints _pilot_group)) != 0} do {deleteWaypoint ((waypoints _pilot_group) select 0);};
	while {(count (waypoints _para_group)) != 0} do {deleteWaypoint ((waypoints _para_group) select 0);};
	sleep 0.2;

	{_x doFollow leader _pilot_group} foreach units _pilot_group;
	{_x doFollow leader _para_group} foreach units _para_group;
	sleep 0.2;

	_waypoint = _pilot_group addWaypoint [ _targetpos, 25];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "FULL";
	_waypoint setWaypointBehaviour "CARELESS";
	_waypoint setWaypointCombatMode "BLUE";
	_waypoint setWaypointCompletionRadius 100;
	_waypoint = _pilot_group addWaypoint [ _targetpos, 25];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "FULL";
	_waypoint setWaypointBehaviour "CARELESS";
	_waypoint setWaypointCombatMode "BLUE";
	_waypoint setWaypointCompletionRadius 100;
	_waypoint = _pilot_group addWaypoint [ _targetpos, 700];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointCompletionRadius 100;
	_waypoint = _pilot_group addWaypoint [ _targetpos, 700];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointCompletionRadius 100;
	_waypoint = _pilot_group addWaypoint [ _targetpos, 700];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointCompletionRadius 100;
	_pilot_group setCurrentWaypoint [ _pilot_group, 1];

	_waypoint = _para_group addWaypoint [ _targetpos, 100];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "NORMAL";
	_waypoint setWaypointBehaviour "COMBAT";
	_waypoint setWaypointCombatMode "GREEN";
	_waypoint setWaypointCompletionRadius 50;
	_waypoint = _para_group addWaypoint [ _targetpos, 100];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointCompletionRadius 50;
	_pilot_group setCurrentWaypoint [ _para_group, 1];

	_newvehicle flyInHeight 300;

	waitUntil { sleep 1;
		!(alive _newvehicle) || (damage _newvehicle > 0.2 ) || (_newvehicle distance2D _targetpos < 200 )
	};

	_newvehicle flyInHeight 200;

	{
		unassignVehicle _x;
		moveout _x;
		sleep 0.5;
	} foreach (units _para_group);

	_newvehicle flyInHeight 300;

	sleep 0.2;
	while {(count (waypoints _pilot_group)) != 0} do {deleteWaypoint ((waypoints _pilot_group) select 0);};
	while {(count (waypoints _para_group)) != 0} do {deleteWaypoint ((waypoints _para_group) select 0);};
	sleep 0.2;
	{_x doFollow leader _pilot_group} foreach units _pilot_group;
	{_x doFollow leader _para_group} foreach units _para_group;
	sleep 0.2;

	_newvehicle flyInHeight 300;

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
	_pilot_group setCurrentWaypoint [ _pilot_group, 1];
	_waypoint = _para_group addWaypoint [ _targetpos, 100];
	_waypoint setWaypointType "SAD";
	_waypoint = _para_group addWaypoint [ _targetpos, 100];
	_waypoint setWaypointType "SAD";
	_waypoint = _para_group addWaypoint [ _targetpos, 100];
	_waypoint setWaypointType "SAD";
	_waypoint = _para_group addWaypoint [ _targetpos, 100];
	_waypoint setWaypointType "SAD";
	_waypoint = _para_group addWaypoint [ _targetpos, 100];
	_waypoint setWaypointType "CYCLE";
	_pilot_group setCurrentWaypoint [ _para_group, 1];
};

_para_group = createGroup [GRLIB_side_enemy, true];
[_targetpos, _para_group] spawn _sendPara;
_para_group;
