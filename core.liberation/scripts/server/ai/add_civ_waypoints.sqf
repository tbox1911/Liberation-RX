params ["_grp", "_basepos"];
if (isNil "_grp" || isNil "_basepos") exitWith {};
if (isNull _grp) exitWith {};
if (!local _grp) exitWith { [_grp, _basepos] remoteExec ["add_civ_waypoints", groupOwner _grp] };

[_grp] call F_deleteWaypoints;

private _behaviour = "SAFE";
private _combatMode = "GREEN";
private _speed = "LIMITED";

if (side _grp == GRLIB_side_enemy) then {
	_combatMode = "YELLOW";
	_speed = "NORMAL";
};
_grp setCombatMode _combatMode;
_grp setBehaviourStrong  _behaviour;
_grp setSpeedMode _speed;

private ["_waypoint", "_wp0", "_radius", "_nextpos"];
private _max_try = 50;
while { (count (waypoints _grp) <= 5) && _max_try > 0} do {
	_radius = GRLIB_capture_size + ([[-150,0,150], 0] call F_getRND);
	_nextpos = ([_basepos, _radius] call F_getRandomPos);
	if !(surfaceIsWater _nextpos) then {
		_waypoint = _grp addWaypoint [_nextpos, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointSpeed _speed;
		_waypoint setWaypointBehaviour _behaviour;
		_waypoint setWaypointCombatMode _combatMode;
		_waypoint setWaypointCompletionRadius 20;
	};
	_max_try = _max_try - 1;
};

if (count (waypoints _grp) > 1) then {
	_wp0 = waypointPosition [_grp, 0];
	_waypoint = _grp addWaypoint [_wp0, 0];
	_waypoint setWaypointType "CYCLE";
};

{_x doFollow leader _grp} foreach units _grp;
