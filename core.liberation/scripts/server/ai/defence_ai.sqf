params ["_grp", "_flagpos", ["_radius", 100]];
if (isNil "_grp" || isNil "_flagpos") exitWith {};
if (isNull _grp) exitWith {};

private _grp_veh = objectParent (leader _grp);
if (_grp_veh isKindOf "Ship_F") exitWith { [_grp, getPosATL _grp_veh, 200] spawn patrol_ai };

_flagpos = ([_flagpos, 5] call F_getRandomPos);
diag_log format ["Group %1 - Defend: %2", _grp, _flagpos];
sleep (5 + floor random 30);

private _timer = 0;
private _patrol = false;
private ["_target", "_basepos", "_waypoint", "_wp0"];

while { GRLIB_endgame == 0 && ({alive _x} count (units _grp) > 0) } do {
	if (side _grp == GRLIB_side_enemy) then {
		_target = [_flagpos] call F_getNearestBlufor;
	};
	if (side _grp == GRLIB_side_friendly) then {
		_target = (units GRLIB_side_enemy) select { alive _x && (isNull objectParent _x) && (_x distance2D _flagpos < GRLIB_capture_size)} select 0;
	};

	if (isNil "_target") then {
		if (!_patrol) then {
			_patrol = true;
			[_grp, _flagpos, _radius] spawn patrol_ai;
		};
	} else {
		_basepos = getPosATL _target;
		if ( time > _timer) then {
			_patrol = false;
			if (_grp_veh isKindOf "Truck_F" && count (crew _grp_veh) > 0 ) then { [_grp] call F_ejectGroup };

			[_grp] call F_deleteWaypoints;
			_waypoint = _grp addWaypoint [_basepos, _radius];
			_waypoint setWaypointType "MOVE";
			_waypoint setWaypointBehaviour "AWARE";
			_waypoint setWaypointCombatMode "YELLOW";
			_waypoint setWaypointSpeed "FULL";
			_waypoint = _grp addWaypoint [_basepos, _radius];
			_waypoint setWaypointType "MOVE";
			_waypoint = _grp addWaypoint [_basepos, _radius];
			_waypoint setWaypointType "MOVE";
			_waypoint = _grp addWaypoint [_basepos, _radius];
			_waypoint setWaypointType "MOVE";
			_waypoint = _grp addWaypoint [_basepos, _radius];
			_waypoint setWaypointType "CYCLE";
			{ _x doFollow leader _grp } foreach units _grp;
			_timer = round (time + (15 * 60));
		};
	};

	{ 
		[_x] spawn F_fixPosUnit;
		sleep 1;
	} forEach (units _grp);

	sleep 300;
};
