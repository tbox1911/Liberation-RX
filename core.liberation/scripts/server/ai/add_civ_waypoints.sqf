params ["_grp", "_basepos"];
if (isNil "_grp" || isNil "_basepos") exitWith {};
if (isNull _grp) exitWith {};
if (!local _grp) exitWith { [_grp, _basepos] remoteExec ["add_civ_waypoints", groupOwner _grp] };

private _civ_veh = objectParent (leader _grp);
if (_civ_veh isKindOf "Ship") exitWith { [_grp, getPosATL _civ_veh, 120] spawn patrol_ai };

[_grp] call F_deleteWaypoints;

private _behaviour = "CARELESS";
private _combatMode = "BLUE";
private _speed = "LIMITED";

if (side _grp == GRLIB_side_enemy) then {
	_behaviour = "AWARE";
	_combatMode = "GREEN";
	_speed = "NORMAL";
};
_grp setCombatMode _combatMode;
_grp setBehaviourStrong  _behaviour;
_grp setSpeedMode _speed;

private ["_waypoint", "_wp0", "_radius", "_nextpos"];
if (isNull _civ_veh) then {
	private _max_try = 50;
	while { (count (waypoints _grp) <= 4) && _max_try > 0} do {
		_radius = GRLIB_capture_size + ([[-150,0,150], 0] call F_getRND);
		_nextpos = _basepos getPos [_radius, random 360];
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
} else {
	private _pos = getPosATL _civ_veh;
	private _radius = GRLIB_spawn_max * 2;
	private _check_water = true;

	if (_civ_veh isKindOf "Air") then {
		_pos = _basepos;
		_check_water = false;
	};

	private _min_waypoints = 3;
	private _citylist = ((sectors_allSectors - sectors_tower - active_sectors) select { (_pos distance2D (markerPos _x) < _radius) });
	private _convoy_destinations_markers = [_radius, _citylist, _min_waypoints, 20, _check_water] call F_getSectorPath;
	private _convoy_destinations = [_convoy_destinations_markers] call F_getPathRoadFilter;
	if (count _convoy_destinations < _min_waypoints) exitWith {
		diag_log format ["--- LRX Error: %1 patrol waypoints fail, cannot find sector path!", side _grp];
		false;
	};

	{
		_waypoint = _grp addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointSpeed _speed;
		_waypoint setWaypointBehaviour _behaviour;
		_waypoint setWaypointCombatMode _combatMode;
		_waypoint setWaypointCompletionRadius 200;
	} foreach _convoy_destinations;

	if (_civ_veh isKindOf "LandVehicle") then {	_civ_veh setPos (_convoy_destinations select 0) };
	(driver _civ_veh) MoveTo (_convoy_destinations select 1);
};

if (count (waypoints _grp) > 1) then {
	_wp0 = waypointPosition [_grp, 0];
	_waypoint = _grp addWaypoint [_wp0, 0];
	_waypoint setWaypointType "CYCLE";
};

{_x doFollow leader _grp} foreach units _grp;
