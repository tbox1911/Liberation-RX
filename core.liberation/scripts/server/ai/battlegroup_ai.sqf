params ["_grp", "_objective_pos"];
if (isNil "_grp" || isNil "_objective_pos") exitWith {};
if (isNull _grp) exitWith {};

private _vehicle = objectParent leader _grp;
if (_vehicle isKindOf "Ship_F") exitWith {
	[_grp, getPosATL _vehicle] spawn defence_ai;
};

if (_vehicle isKindOf "ParachuteBase") then {
	_vehicle = objNull;
	waitUntil { sleep 1; ({getPos _x select 2 > 2} count (units _grp) == 0) };
	sleep 5;
};

private _veh_type = "No vehicle";
if !(isNull _vehicle) then { _veh_type = typeOf _vehicle };
private _attack = true;
private _timer = 0;
private _last_pos = getPosATL (leader _grp);
diag_log format ["Group %1 (%2) - Attack: %3 - Distance: %4m", _grp, _veh_type, _objective_pos, round (_last_pos distance2D _objective_pos)];
sleep (5 + floor random 30);

private ["_waypoint", "_wp0", "_next_objective", "_timer", "_sleep", "_target"];
while {true} do {
	_sleep = 300;
	{
		if (surfaceIsWater (getPos _x) && _x distance2D _objective_pos > 300) then { deleteVehicle _x } else { [_x] spawn F_fixPosUnit };
		sleep 1;
	} forEach (units _grp);
	if ({alive _x} count (units _grp) == 0) exitWith {};

	if (_attack) then {
		_attack = false;
		[_objective_pos] remoteExec ["remote_call_incoming", 0];
		diag_log format ["Group %1 - Attack: %2", _grp, _objective_pos];

		[_grp] call F_deleteWaypoints;
		_waypoint = _grp addWaypoint [_objective_pos, 100];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointSpeed "FULL";
		_waypoint setWaypointBehaviour "COMBAT";
		_waypoint setWaypointCombatMode "YELLOW";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint = _grp addWaypoint [_objective_pos, 100];
		_waypoint setWaypointType "MOVE";
		_waypoint = _grp addWaypoint [_objective_pos, 100];
		_waypoint setWaypointType "MOVE";
		_waypoint = _grp addWaypoint [_objective_pos, 100];
		_waypoint setWaypointType "MOVE";
		_wp0 = waypointPosition [_grp, 0];
		_waypoint = _grp addWaypoint [_wp0, 0];
		_waypoint setWaypointType "CYCLE";
		sleep 1;
		{ _x doFollow (leader _grp) } foreach units _grp;

		if (_vehicle isKindOf "AllVehicles") then {
			(driver _vehicle) doMove _objective_pos;
		};

		_timer = round (time + (15 * 60));
	};

	if (time > _timer) then {
		_last_pos = getPosATL (leader _grp);
		if (GRLIB_global_stop == 1) then {
			_target = [_last_pos, GRLIB_spawn_min] call F_getNearestBlufor;
			_next_objective = [getPosATL _target, round (_last_pos distance2D _target)];
		} else {
			_next_objective = [_last_pos] call F_getNearestBluforObjective;
		};

		_objective_pos = [];
		if ((_next_objective select 1) <= GRLIB_spawn_min) then {
			_objective_pos = (_next_objective select 0);
			_attack = true;
		};
		_timer = round (time + (10 * 60));
		_sleep = 5;
	};
	if (count _objective_pos == 0) exitWith {};

	if (!isNull _vehicle) then {
		[_vehicle] call F_vehicleUnflip;
		_vehicle setFuel 1;
		_vehicle setVehicleAmmo 1;
		_last_pos = getPosATL _vehicle;
	};

	sleep _sleep;
};

// Cleanup
waitUntil { sleep 30; (GRLIB_global_stop == 1 || [_last_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
[_vehicle] spawn cleanMissionVehicles;
{ deleteVehicle _x; sleep 0.1 } forEach (units _grp);
deleteGroup _grp;
