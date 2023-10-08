params ["_targetpos", "_side", "_count"];
private ["_vehicle", "_unit", "_priso"];

if (isNil "_side") then {_side = GRLIB_side_enemy};
private _planeType = opfor_air;
if (_side == GRLIB_side_friendly) then {_planeType = blufor_air};

private _air_grp = createGroup [_side, true];

for "_i" from 1 to _count do {
	_vehicle = [_targetpos, selectRandom _planeType, false, false, _side] call F_libSpawnVehicle;
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
	diag_log format [ "Spawn Air vehicle %1 on %2 at %3", typeOf _vehicle, _targetpos, time ];
	sleep 5;
};

[_air_grp] call F_deleteWaypoints;
private _waypoint = _air_grp addWaypoint [ _targetpos, 200];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "NORMAL";
_waypoint setWaypointBehaviour "COMBAT";
_waypoint setWaypointCombatMode "RED";
_waypoint setWaypointType "SAD";
_waypoint = _air_grp addWaypoint [ _targetpos, 200];
_waypoint setWaypointType "SAD";
_waypoint = _air_grp addWaypoint [ _targetpos, 200];
_waypoint setWaypointType "SAD";
_waypoint = _air_grp addWaypoint [ _targetpos, 200];
_waypoint setWaypointType "CYCLE";
{_x doFollow leader _air_grp} foreach units _air_grp;
sleep 60;

while {	{( alive _x )} count (units _air_grp) > 0 } do {
	{
		_unit = _x;
		_vehicle = objectParent _unit;
		if ( alive _vehicle && driver _vehicle == _unit) then {
			_vehicle setVehicleAmmo 1;
			_vehicle setFuel 1;
		};

		if ( alive _unit && isNull _vehicle && !(_unit getVariable ["GRLIB_is_prisonner", false])) then {
			[_unit, false, true] spawn prisonner_ai;
			sleep 4;
		};
		sleep 1;
	} foreach units _air_grp;
	sleep 5;
};
