// Taxi functions
taxi_land = {
	params ["_vehicle"];
	private _stop = time + (2 * 60);
	waitUntil {
		hintSilent localize "STR_TAXI_LANDING";
		_vehicle land "LAND";
		sleep 20;
		_alt = getPosATL _vehicle select 2;
		if (round (speed _vehicle) == 0 && _alt > 3) then {
			_vehicle setPosATL (getPosATL _vehicle vectorAdd [0, 0, -2]);
		};
		_alt <= 3 || time > _stop
	};
	doStop driver _vehicle;
	hintSilent localize "STR_TAXI_LANDED";
	deleteVehicle _helipad;
};

taxi_dest = {
	params ["_air_grp", "_dest"];
	private _waypoint = _air_grp addWaypoint [ _dest, 1];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "FULL";
	_waypoint setWaypointBehaviour "AWARE";
	_waypoint setWaypointCombatMode "GREEN";
};

taxi_cargo = {
	params ["_vehicle", "_pilots"];
	private _ret = crew _vehicle - _pilots;
	_ret;
};

taxi_outboard = {
	params ["_vehicle"];
	_ret = true;
	{
		if ( vehicle _x == _vehicle) then {
			unassignVehicle _x;
			commandGetOut _x;
			doGetOut _x;
			_ret = false
		};
	} forEach ([_vehicle, _pilots] call taxi_cargo);
	sleep 2;
	_ret;
};
