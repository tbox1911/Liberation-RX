params ["_targetpos", "_side", "_count"];

if (isNil "_side") then {_side = GRLIB_side_enemy};
private _planeType = opfor_air;
if (_side == GRLIB_side_friendly) then {_planeType = blufor_air};

private _air_spawnpoint = ( [ sectors_airspawn , [ _targetpos ] , { (markerpos _x) distance2D _input0 }, "ASCEND"] call BIS_fnc_sortBy ) select 0;
private _air_grp = createGroup [_side, true];

for "_i" from 1 to _count do {
	_vehicle = [markerpos _air_spawnpoint, selectRandom _planeType] call F_libSpawnVehicle;
	_vehicle setVariable ["GRLIB_counter_TTL", round(time + 1800), true];  // 30 minutes TTL
	(crew _vehicle) joinSilent _air_grp;
	{
		_x addBackpack "B_Parachute";
		_x setVariable ["GRLIB_counter_TTL", round(time + 1800), true];  // 30 minutes TTL	
	} forEach (crew _vehicle);
	if (_side == GRLIB_side_friendly) then {
		_msg = format ["Air support %1 incoming...", [typeOf _vehicle] call F_getLRXName];
		[gamelogic, _msg] remoteExec ["globalChat", 0];
	};
	diag_log format [ "Spawn Air vehicle %1 at %2", typeOf _vehicle, time ];
	sleep 5;
};

[_air_grp] call F_deleteWaypoints;
{_x doFollow leader _air_grp} foreach units _air_grp;
sleep 1;

_waypoint = _air_grp addWaypoint [ _targetpos, 200];
_waypoint setWaypointBehaviour "COMBAT";
_waypoint setWaypointCombatMode "RED";
_waypoint setWaypointType "SAD";
_waypoint = _air_grp addWaypoint [ _targetpos, 200];
_waypoint setWaypointType "SAD";
_waypoint = _air_grp addWaypoint [ _targetpos, 200];
_waypoint setWaypointType "SAD";
_waypoint = _air_grp addWaypoint [ _targetpos, 200];
_waypoint setWaypointType "CYCLE";

sleep 60;

while {	sleep 5; {( alive _x )} count (units _air_grp) > 0 } do {

	{
		private _unit = _x;
		if ( alive _unit && vehicle _unit == _unit ) then {
			private _sectors = (sectors_allSectors - blufor_sectors);
			if (_side == GRLIB_side_friendly) then {_sectors = blufor_sectors};
			private _nearest_sector = [_sectors, _unit] call F_nearestPosition;

			if (typeName _nearest_sector == "STRING") then {
				private _flee_grp = createGroup [_side, true];
				[_unit] joinSilent _flee_grp;

				[_flee_grp] call F_deleteWaypoints;
				{_x doFollow leader _flee_grp} foreach units _flee_grp;

				_waypoint = _flee_grp addWaypoint [markerPos _nearest_sector, 0];
				_waypoint setWaypointType "MOVE";
				_waypoint setWaypointSpeed "FULL";
				_waypoint setWaypointBehaviour "SAFE";
				_waypoint setWaypointCombatMode "GREEN";
				_waypoint setWaypointCompletionRadius 50;

				_waypoint = _flee_grp addWaypoint [markerPos _nearest_sector, 0];
				_waypoint setWaypointType "MOVE";
				_waypoint setWaypointCompletionRadius 50;
				_waypoint setWaypointStatements ["true", "deleteVehicle this"];
				sleep 10;
			} else {
				sleep 60;
				{ deleteVehicle _x } forEach _flee_grp;
			};
		};
	} foreach units _air_grp;

};
