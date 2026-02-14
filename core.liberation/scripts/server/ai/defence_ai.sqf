params ["_grp", "_flagpos", ["_radius", 100]];
if (isNil "_grp" || isNil "_flagpos") exitWith {};
if (isNull _grp) exitWith {};

private _grp_veh = objectParent (leader _grp);
if (_grp_veh isKindOf "Ship_F") exitWith { [_grp, getPosATL _grp_veh, 200] call patrol_ai };

sleep 10;
_flagpos = ([_flagpos, 5] call F_getRandomPos);
diag_log format ["Group %1 - Defend: %2", _grp, _flagpos];

private _timer = 0;
private _patrol = false;
private ["_target", "_target_list", "_basepos", "_waypoint", "_wp0"];

while { GRLIB_endgame == 0 && ({alive _x} count (units _grp) > 0) } do {
	if (time >= _timer) then {
		_target = objNull;
		if (side _grp == GRLIB_side_enemy) then {
			_target = [_flagpos] call F_getNearestBlufor;
		};
		if (side _grp == GRLIB_side_friendly) then {
			_target_list = (units GRLIB_side_enemy) select { alive _x && (isNull objectParent _x) && (_x distance2D _flagpos < GRLIB_capture_size)};
			if (count _target_list > 0) then {
				_target = selectRandom _target_list;
			};
		};

		if (_timer > 0) then {
			{ [_x] call F_fixPosUnit; sleep 0.5 } forEach units _grp;
		};

		if (isNull _target) then {
			if (!_patrol) then {
				_patrol = true;
				[_grp, _flagpos, _radius] call patrol_ai;
			};
			_timer = round (time + 300);
		} else {
			_basepos = getPosATL _target;
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
			(leader _grp) doMove (waypointPosition [_grp, 0]);
			(units _grp) doFollow leader _grp;
			_timer = round (time + 600);
		};
	};

	sleep 60;
};
