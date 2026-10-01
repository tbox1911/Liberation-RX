params ["_grp", "_objective_pos"];
if (isNil "_grp" || isNil "_objective_pos") exitWith {};
if (isNull _grp) exitWith {};

private _vehicle = objectParent (leader _grp);
if (_vehicle isKindOf "Ship_F") exitWith { [_grp, getPosATL _vehicle, 250] call patrol_ai };
if (_vehicle isKindOf "Air") exitWith { [_grp, getPosATL _vehicle, 500] call patrol_ai };

waitUntil { sleep 1; ({(round (getPos _x select 2) > 5)} count (units _grp) == 0) };

private _vehicle = objectParent (leader _grp);
private _veh_type = typeOf _vehicle;
if (isNull _vehicle) then { _veh_type = "No vehicle" };
private _attack = true;
private _timer = 0;
private _last_pos = getPosATL (leader _grp);

private ["_waypoint", "_wp0", "_next_objective", "_sector", "_timer", "_sleep"];
while { (({ alive _x } count (units _grp)) > 0) } do {
	_sleep = 60;
	{
		if (surfaceIsWater (getPos _x) && _x distance2D _objective_pos > (GRLIB_sector_size * 1.5)) then { deleteVehicle _x } else { [_x] call F_fixPosUnit };
		sleep 0.2;
	} forEach (units _grp);
	if ({alive _x} count (units _grp) == 0) exitWith {};

	if (time >= _timer) then {
		if (alive (leader _grp)) then { _last_pos = getPosATL (leader _grp) };
		_sector = [GRLIB_sector_size, _objective_pos] call F_getNearestSector;
		_no_blu = ([_objective_pos, GRLIB_sector_size, GRLIB_side_friendly, 1] call F_getUnitsCount == 0);

		if ((_sector in opfor_sectors || _sector == "") && _no_blu) then {
			_next_objective = [_last_pos] call F_getNearestBluforObjective;
			if ((_next_objective select 1) < GRLIB_spawn_max) then {
				_objective_pos = (_next_objective select 0);
				_attack = true;
			} else {
				diag_log format ["Delete Group %1 (%2) - No more objectives", _grp, _veh_type];
				{ deleteVehicle _x } forEach (units _grp);
				[_vehicle, true] spawn cleanMissionVehicles;
				_attack = false;
			};
		};

		_timer = round (time + 300);
		_sleep = 5;
	};

	if (_attack) then {
		_attack = false;
		[_objective_pos] remoteExec ["remote_call_incoming", 0];
		diag_log format ["Group %1 (%2) - Attack: %3 - Distance: %4m", _grp, _veh_type, _objective_pos, round (_last_pos distance2D _objective_pos)];

		[_grp] call F_deleteWaypoints;
		_waypoint = _grp addWaypoint [_objective_pos, 100];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointSpeed "FULL";
		_waypoint = _grp addWaypoint [_objective_pos, 100];
		_waypoint setWaypointType "MOVE";
		_waypoint = _grp addWaypoint [_objective_pos, 100];
		_waypoint setWaypointType "MOVE";
		_waypoint = _grp addWaypoint [_objective_pos, 100];
		_waypoint setWaypointType "MOVE";
		_wp0 = waypointPosition [_grp, 0];
		_waypoint = _grp addWaypoint [_wp0, 0];
		_waypoint setWaypointType "CYCLE";

		if (isNull _vehicle) then {
			(leader _grp) doMove _objective_pos;
		} else {
			(driver _vehicle) doMove _objective_pos;
		};

		{_x doFollow (leader _grp)} foreach units _grp;
		_timer = round (time + 300);
	};

	if (alive _vehicle) then {
		_last_pos = getPosATL _vehicle;
		if (round (speed _vehicle) == 0) then {
			[_vehicle] call F_vehicleUnflip;
			_vehicle setFuel 1;
			_vehicle setVehicleAmmo 1;
		};
	};

	sleep _sleep;

	// TTL
	if ({ (_x getVariable ["GRLIB_battlegroup", false]) && (time > _x getVariable ["GRLIB_counter_TTL", 0]) } count (units _grp) > 0) exitWith { diag_log format ["Group %1 (%2) - TTL expired!", _grp, _veh_type];};
};

// Cleanup
waitUntil { sleep 30; (GRLIB_global_stop == 1 || [_last_pos, GRLIB_sector_size, GRLIB_side_friendly, 1] call F_getUnitsCount == 0) };
[_vehicle, true] spawn cleanMissionVehicles;
{ deleteVehicle _x } forEach (units _grp);
deleteGroup _grp;
