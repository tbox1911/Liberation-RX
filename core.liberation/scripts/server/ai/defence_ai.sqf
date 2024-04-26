params ["_grp", "_flagpos", ["_radius", 100]];
if (isNil "_grp" || isNil "_flagpos") exitWith {};
if (isNull _grp) exitWith {};

_flagpos = _flagpos getPos [5, random 360];
diag_log format ["Group %1 - Defend: %2", _grp, _flagpos];

private ["_target", "_basepos", "_waypoint", "_wp0"];
private _grp_veh = objectParent (leader _grp);
if (_grp_veh isKindOf "Ship") exitWith { [_grp, getPosATL _grp_veh, _radius] spawn patrol_ai };

sleep (1 + floor random 10);
if ({alive _x} count (units _grp) == 0) exitWith {};

private _timer = 0;
private _patrol = false;

while { GRLIB_endgame == 0 && ({alive _x} count (units _grp) > 0) } do {
	_target = [_flagpos] call F_getNearestBlufor;
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
			_waypoint setWaypointBehaviour "COMBAT";
			_waypoint setWaypointCombatMode "RED";
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
			_timer = round (time + (10 * 60));
		};
	};

	{
		[_x] spawn F_fixPosUnit;
		sleep 0.2;
	} forEach (units _grp);

	sleep 33;
};
