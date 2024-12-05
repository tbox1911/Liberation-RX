params ["_targetpos", "_side", "_count"];

if (_count == 0) exitWith {};
if (_count >= 1) then {
	sleep 10;
	[_targetpos, _side, _count - 1] spawn spawn_air;
};

private _planeType = opfor_air;
if (_side == GRLIB_side_friendly) then { _planeType = blufor_air };

if (_side == GRLIB_side_enemy) then {
	private _pilots = (units GRLIB_side_friendly) select { (objectParent _x) isKindOf "Air" && (driver vehicle _x) == _x };
	if (count _pilots == 0) then {
		_planeType = opfor_air select { _x isKindOf "Helicopter_Base_F" };
		if (count _planeType == 0) then { _planeType = opfor_air };
	};
};
if (count _planeType == 0) exitWith { diag_log format ["--- LRX Error: Cannot find Air classname in template %1", _side]; };

private _grp = createGroup [_side, true];
private _vehicle = [_targetpos, selectRandom _planeType, 0, false, _side] call F_libSpawnVehicle;
_vehicle setVariable ["GRLIB_counter_TTL", round(time + 1800), true];  // 30 minutes TTL
(crew _vehicle) joinSilent _grp;
_grp setBehaviourStrong "COMBAT";
_grp setCombatMode "RED";
_grp setSpeedMode "FULL";

private _spawnpos = getPosATL _vehicle;
private _radius = 350;

[_grp] call F_deleteWaypoints;
private _waypoint = _grp addWaypoint [ _targetpos, _radius];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "COMBAT";
_waypoint setWaypointCombatMode "RED";
_waypoint = _grp addWaypoint [ _targetpos, _radius];
_waypoint setWaypointType "SAD";
_waypoint = _grp addWaypoint [ _targetpos, _radius];
_waypoint setWaypointType "SAD";
_wp0 = waypointPosition [_grp, 0];
_waypoint = _grp addWaypoint [_wp0, 0];
_waypoint setWaypointType "CYCLE";
{_x doFollow leader _grp} foreach units _grp;

if (_side == GRLIB_side_friendly) exitWith {
	private _msg = format ["Air support %1 incoming...", [typeOf _vehicle] call F_getLRXName];
	[gamelogic, _msg] remoteExec ["globalChat", 0];
};
diag_log format ["Spawn Air Squad %1 objective %2 at %3", typeOf _vehicle, _targetpos, time];
sleep 300;

while { ({alive _x} count (units _grp) > 0) && (GRLIB_endgame == 0) && count _targetpos > 0 } do {
	_pilots = allPlayers select { (objectParent _x) isKindOf "Air" && (driver vehicle _x) == _x };
	if (count _pilots > 0) then {
		_targetpos = getPos (selectRandom _pilots);
	} else {
		_targetpos = [];
	};
	if (count _targetpos == 0) exitWith {};

	[_grp] call F_deleteWaypoints;
	_waypoint = _grp addWaypoint [_targetpos, _radius];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "FULL";
	_waypoint setWaypointBehaviour "COMBAT";
	_waypoint setWaypointCombatMode "RED";
	_waypoint = _grp addWaypoint [_targetpos, _radius];
	_waypoint setWaypointType "SAD";
	_waypoint = _grp addWaypoint [_targetpos, _radius];
	_waypoint setWaypointType "SAD";
	_waypoint = _grp addWaypoint [_targetpos, _radius];
	_waypoint setWaypointType "SAD";
	_wp0 = waypointPosition [_grp, 0];
	_waypoint = _grp addWaypoint [_wp0, 0];
	_waypoint setWaypointType "CYCLE";
	{ _x doFollow leader _grp } foreach units _grp;

	_vehicle setFuel 1;
	_vehicle setVehicleAmmo 1;
	sleep 360;
};

if ({alive _x} count (units _grp) == 0) exitWith {};

// Cleanup
[_grp] call F_deleteWaypoints;
private _waypoint = _grp addWaypoint [_spawnpos, 0];
_waypoint setWaypointType "MOVE";
_waypoint setWaypointSpeed "FULL";
_waypoint setWaypointBehaviour "COMBAT";
_waypoint setWaypointCombatMode "YELLOW";
_waypoint setWaypointCompletionRadius 300;
_waypoint setWaypointStatements ["true", "[vehicle this] spawn clean_vehicle"];
{_x doFollow (leader _grp)} foreach units _grp;