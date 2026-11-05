params ["_grp", "_basepos", "_vehicle"];

if (isNil "_grp" || isNil "_basepos") exitWith {};
if (isNull _grp) exitWith {};
if (!local _grp) exitWith { [_grp, _basepos, _vehicle] remoteExec ["add_civ_waypoints_veh", groupOwner _grp] };

if (_vehicle isKindOf "Ship_F") exitWith { [_grp, getPosATL _vehicle, 220] call patrol_ai };

[_grp] call F_deleteWaypoints;

private _behaviour = "SAFE";
private _combatMode = "GREEN";
private _speed = "LIMITED";
private _radius = GRLIB_spawn_max;
private _check_water = true;

if (side _grp == GRLIB_side_enemy) then {
	_combatMode = "YELLOW";
	_speed = "NORMAL";
	_radius = GRLIB_spawn_max * 1.5;
};

if (_vehicle isKindOf "Air") then {
	_check_water = false;
	if (_vehicle isKindOf "Helicopter_Base_F") then { _speed = "NORMAL" };
	_radius = GRLIB_spawn_max * 2;
};

_grp setCombatMode _combatMode;
_grp setBehaviourStrong  _behaviour;
_grp setSpeedMode _speed;

private _min_waypoints = 3;
private _citylist = (sectors_allSectors select { ((markerPos _x) distance2D _basepos <= _radius) });
if (count _citylist < _min_waypoints) exitWith { [_grp, _basepos, 220] call patrol_ai };

private _destinations_markers = [_citylist, _radius, _min_waypoints, 20, _check_water] call F_getSectorPath;
private _destinations = [];

if (_vehicle isKindOf "Air") then {
	{ _destinations pushBack (markerPos _x) } forEach _destinations_markers;
} else {
	_destinations = [_destinations_markers] call F_getPathRoadFilter;
};

if (count _destinations < _min_waypoints) exitWith {
	diag_log format ["--- LRX Error: %1 patrol waypoints fail, cannot find sector path (%2).", side _grp, _basepos];
	[_grp, _basepos] call add_civ_waypoints;
};

if (isNull _vehicle) then {
	private _pos = (_destinations select 0);
	{ _x setPos ([_pos, 5] call F_getRandomPos) } forEach (units _grp);
};

if (_vehicle isKindOf "LandVehicle") then {
	_vehicle setPos (_destinations select 0);
};

private ["_waypoint", "_wp0"];
{
	_waypoint = _grp addWaypoint [_x, 0];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed _speed;
	_waypoint setWaypointBehaviour _behaviour;
	_waypoint setWaypointCombatMode _combatMode;
	_waypoint setWaypointCompletionRadius 200;
} foreach _destinations;

_wp0 = waypointPosition [_grp, 0];
_waypoint = _grp addWaypoint [_wp0, 0];
_waypoint setWaypointType "CYCLE";

(driver _vehicle) doMove _wp0;

{_x doFollow leader _grp} foreach units _grp;
