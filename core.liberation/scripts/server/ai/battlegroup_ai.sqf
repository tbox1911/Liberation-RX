params ["_grp", "_objective_pos"];
if (isNil "_grp" || isNil "_objective_pos") exitWith {};
if (isNull _grp) exitWith {};

private _vehicle = objectParent (leader _grp);
if (_vehicle isKindOf "Ship") exitWith {
	[_grp, getPosATL _vehicle] spawn defence_ai;
};

sleep (1 + floor random 10);
if ({alive _x} count (units _grp) == 0) exitWith {};

private _timer = 0;
private _last_pos = getPosATL (leader _grp);
private ["_waypoint", "_wp0", "_next_objective", "_sector", "_timer"];

while { ({alive _x} count (units _grp) > 0) && (GRLIB_endgame == 0) && !(_objective_pos isEqualTo zeropos)} do {
	if ( time > _timer) then {
		_sector = [GRLIB_sector_size, _objective_pos] call F_getNearestSector;
		if (_sector in blufor_sectors) then {
			[_objective_pos] remoteExec ["remote_call_incoming", 0];
		};
		diag_log format ["Group %1 - Attack: %2", _grp, _objective_pos];

		[_grp] call F_deleteWaypoints;
		_waypoint = _grp addWaypoint [_objective_pos, 100];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointSpeed "FULL";
		_waypoint setWaypointBehaviour "COMBAT";
		_waypoint setWaypointCombatMode "RED";
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
		_grp setSpeedMode "FULL";
		_grp setBehaviourStrong "COMBAT";
		_grp setCombatMode "RED";
		{ _x doFollow (leader _grp) } foreach units _grp;

		if (_vehicle isKindOf "AllVehicles") then {
			(driver _vehicle) doMove _objective_pos;
		};
		_timer = round (time + (10 * 60));
	};

	{
		[_x] call F_fixPosUnit;
		if (surfaceIsWater (getPos _x) && _x distance2D _objective_pos > 400) then {
			deleteVehicle _x;
		};
		sleep 0.2;
	} forEach (units _grp);

	if (!isNull _vehicle) then {
		[_vehicle] call F_vehicleUnflip;
		_vehicle setFuel 1;
		_vehicle setVehicleAmmo 1;
	};

	_last_pos = getPosATL (leader _grp);
	_next_objective = [_objective_pos] call F_getNearestBluforObjective;
	if ((_next_objective select 1) <= GRLIB_spawn_max) then { _objective_pos = (_next_objective select 0) } else { _objective_pos = zeropos };
	if (GRLIB_global_stop == 1) then {
		private _target = [_last_pos, GRLIB_spawn_max] call F_getNearestBlufor;
		if !(isNil "_target") then { _objective_pos = getPosATL _target } else { _objective_pos = zeropos };
	};

	sleep 33;
};

// Cleanup
waitUntil { sleep 30; (GRLIB_global_stop == 1 || [_last_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
[_vehicle] call clean_vehicle;
{ deleteVehicle _x } forEach (units _grp);
deleteGroup _grp;
