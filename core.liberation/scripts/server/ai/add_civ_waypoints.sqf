params ["_grp", "_basepos"];
if (isNil "_grp" || isNil "_basepos") exitWith {};
if (isNull _grp) exitWith {};

private ["_waypoint", "_wp0", "_nearestroad", "_radius", "_nextpos"];
private _civ_veh = objectParent (leader _grp);
if (_civ_veh isKindOf "Ship") exitWith { [_grp, getPosATL _civ_veh, 80] spawn add_defense_waypoints };

[_grp] call F_deleteWaypoints;
private _max_try = 100;

private _behaviour = "SAFE";
private _combatMode = "BLUE";
if (side _grp == GRLIB_side_enemy) then {
	_behaviour = "AWARE";
	_combatMode = "WHITE";
	_grp setCombatMode _combatMode;
	_grp setBehaviour _behaviour;
};

if (isNull _civ_veh) then {
	while { (count (waypoints _grp) <= 4) && _max_try > 0} do {
		_radius = GRLIB_capture_size + ([[-150,0,80], 0] call F_getRND);
		_nextpos = _basepos getPos [_radius, random 360];
		if !(surfaceIsWater _nextpos) then {
			_waypoint = _grp addWaypoint [_nextpos, 0];
			_waypoint setWaypointType "MOVE";
			_waypoint setWaypointSpeed "LIMITED";
			_waypoint setWaypointBehaviour _behaviour;
			_waypoint setWaypointCombatMode _combatMode;
			_waypoint setWaypointCompletionRadius 20;
		};
		_max_try = _max_try - 1;
	};
} else {
	private _pos = getPosATL _civ_veh;
	private _radius = GRLIB_spawn_max;
	private _speed = "LIMITED";

	if (_civ_veh isKindOf "Air") then { 
		_pos = _basepos;
		_radius = GRLIB_spawn_max * 2;
		_speed = "NORMAL";
	};

	private _sectors_patrol = [];
	{
		if (_pos distance2D (markerPos _x) < _radius) then {
			_sectors_patrol pushback _x;
		};
	} foreach (sectors_bigtown + sectors_capture + sectors_factory + sectors_military);

	if (count _sectors_patrol > 0) then {
		_sectors_patrol = _sectors_patrol call BIS_fnc_arrayShuffle;
		{
			if (count (waypoints _grp) <= 4) then {
				_nearestroad = [markerPos _x, 100] call BIS_fnc_nearestRoad;
				if !(surfaceIsWater (getPosATL _nearestroad)) then {
					if ( isNull _nearestroad ) then {
						_waypoint = _grp addWaypoint [ markerpos _x, 100 ];
					} else {
						_waypoint = _grp addWaypoint [ getPosATL _nearestroad, 0 ];
					};
					_waypoint setWaypointType "MOVE";
					_waypoint setWaypointSpeed _speed;
					_waypoint setWaypointBehaviour _behaviour;
					_waypoint setWaypointCombatMode _combatMode;
					_waypoint setWaypointCompletionRadius 100;
				};
			};
		} foreach _sectors_patrol;	
	};
};

if (count (waypoints _grp) > 1) then {
	_wp0 = waypointPosition [_grp, 0];
	_waypoint = _grp addWaypoint [_wp0, 0];
	_waypoint setWaypointType "CYCLE";
};

{_x doFollow leader _grp} foreach units _grp;
