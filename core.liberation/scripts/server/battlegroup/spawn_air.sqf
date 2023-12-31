params ["_targetpos", "_side", "_count"];

if (isNil "_side") then {_side = GRLIB_side_enemy};
private _planeType = opfor_air;
if (_side == GRLIB_side_friendly) then {_planeType = blufor_air};
if (count _planeType == 0) exitWith { objNull };

private _grp = createGroup [_side, true];
private ["_vehicle"];
for "_i" from 1 to _count do {
	_vehicle = [zeropos, selectRandom _planeType, false, false, _side] call F_libSpawnVehicle;
	_vehicle setVariable ["GRLIB_counter_TTL", round(time + 1800), true];  // 30 minutes TTL
	(crew _vehicle) joinSilent _grp;
	{
		_x addBackpack "B_Parachute";
		_x setVariable ["GRLIB_counter_TTL", round(time + 1800), true];  // 30 minutes TTL	
	} forEach (crew _vehicle);
	if (_side == GRLIB_side_friendly) then {
		private _msg = format ["Air support %1 incoming...", [typeOf _vehicle] call F_getLRXName];
		[gamelogic, _msg] remoteExec ["globalChat", 0];
	};
	diag_log format [ "Spawn Air vehicle %1 on %2 at %3", typeOf _vehicle, _targetpos, time ];
	sleep 5;
};

private _radius = 400;
[_grp] call F_deleteWaypoints;
private _waypoint = _grp addWaypoint [ _targetpos, _radius];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "COMBAT";
_waypoint setWaypointCombatMode "RED";
_waypoint setWaypointType "MOVE";
_waypoint = _grp addWaypoint [ _targetpos, _radius];
_waypoint setWaypointType "MOVE";
_waypoint = _grp addWaypoint [ _targetpos, _radius];
_waypoint setWaypointType "MOVE";
_waypoint = _grp addWaypoint [ _targetpos, _radius];
_waypoint setWaypointType "CYCLE";
{_x doFollow leader _grp} foreach units _grp;

if (_side == GRLIB_side_friendly) exitWith {};
sleep 300;

while { ({alive _x} count (units _grp) > 0) && ( GRLIB_endgame == 0 ) } do {

	_target = (leader _grp) findNearestEnemy (leader _grp);
	if (isNull _target) then {
		_pilots = allPlayers select { (objectParent _x) isKindOf "Air" && (driver vehicle _x) == _x };
		if (count _pilots > 0) then { _targetpos = getPos (selectRandom _pilots) };
	} else {
		_targetpos = getPos _target;
	};

	if (count _targetpos > 0) then {
		[_grp] call F_deleteWaypoints;
		_waypoint = _grp addWaypoint [_targetpos, _radius];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointBehaviour "COMBAT";
		_waypoint setWaypointCombatMode "RED";
		_waypoint setWaypointSpeed "FULL";
		_waypoint = _grp addWaypoint [_targetpos, _radius];
		_waypoint setWaypointType "MOVE";
		_waypoint = _grp addWaypoint [_targetpos, _radius];
		_waypoint setWaypointType "MOVE";
		_waypoint = _grp addWaypoint [_targetpos, _radius];
		_waypoint setWaypointType "MOVE";
		_waypoint = _grp addWaypoint [_targetpos, _radius];
		_waypoint setWaypointType "CYCLE";
		{ _x doFollow leader _grp } foreach units _grp;
		sleep 300;
	};
	_vehicle setFuel 1;
	_vehicle setVehicleAmmo 1;
	sleep 30;
};
