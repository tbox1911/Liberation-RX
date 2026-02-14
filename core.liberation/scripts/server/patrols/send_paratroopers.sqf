params ["_targetpos", ["_qrf", false], ["_unload_dist", 500]];
if (count opfor_troup_transports_heli == 0) exitWith { grpNull };

private _name = "";
private _para_squad = [
	opfor_squad_leader,
	opfor_paratrooper,
	opfor_paratrooper,
	opfor_rpg,
	opfor_paratrooper,
	opfor_paratrooper,
	opfor_rpg,
	opfor_paratrooper,
	opfor_paratrooper,
	opfor_paratrooper
];
if (_qrf == true) then {
	_name = "QRF-";
	_unload_dist = 800;
	_para_squad = [
		opfor_squad_leader,
		opfor_sniper,
		opfor_marksman,
		opfor_rpg,
		opfor_marksman,
		opfor_machinegunner,
		opfor_rpg,
		opfor_grenadier,
		opfor_at,
		opfor_grenadier
	];
};

private _go_target = {
	params ["_grp", "_target", "_spawnpos"];
	if (isNull _grp) exitWith {};
	if ({alive _x} count (units _grp) == 0) exitWith {};
	[_grp] call F_deleteWaypoints;
	private _waypoint = _grp addWaypoint [_target, 100];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "FULL";
	_waypoint setWaypointBehaviour "AWARE";
	_waypoint setWaypointCombatMode "WHITE";
	_waypoint setWaypointCompletionRadius 300;
	sleep 3;
	_waypoint = _grp addWaypoint [_spawnpos, 0];
	_waypoint setWaypointType "MOVE";
	_waypoint setWaypointSpeed "FULL";
	_waypoint setWaypointBehaviour "AWARE";
	_waypoint setWaypointCombatMode "YELLOW";
	_waypoint setWaypointCompletionRadius 400;
	_waypoint setWaypointStatements ["true", "[vehicle this, true, true] spawn F_vehicleClean"];
	{_x doFollow (leader _grp)} foreach units _grp;
};

private _vehicle = [_targetpos, selectRandom opfor_troup_transports_heli] call F_libSpawnVehicle;
if (isNull _vehicle) exitWith { grpNull };

private _pilot_group = group driver _vehicle;
private _spawnpos = getPosATL _vehicle;
_vehicle flyInHeight 350;

private _cargo_seat_free = _vehicle emptyPositions "Cargo";
if (_cargo_seat_free == 0) exitWith {
	diag_log format ["--- LRX Error bad classname (%1) for troup transport.", typeOf _vehicle];
	[_vehicle, true, true] spawn F_vehicleClean;
	grpNull;
};

private _unitclass = _para_squad select [0, (_cargo_seat_free min 10)];
private _para_group = [_spawnpos, _unitclass, GRLIB_side_enemy, "para"] call F_libSpawnUnits;
[_vehicle, (units _para_group)] call F_manualCrew;

// Move to obj
[_vehicle, 3600] call F_setUnitTTL;
[_pilot_group, _targetpos, getPosATL _vehicle] call _go_target;

if (floor random 3 == 0) then {
	if (count opfor_air > 0) then {
		sleep 5;
		private _escort_veh = [_targetpos, selectRandom opfor_air] call F_libSpawnVehicle;
		private _escort_group = group driver _escort_veh;
		_escort_veh flyInHeight 350;
		[_escort_veh, 1800] call F_setUnitTTL;
		[_escort_group, _targetpos, _escort_veh] call _go_target;
	};
};

sleep 1;

diag_log format ["Send (%1) %2ParaTroopers to objective %3 at %4", _cargo_seat_free, _name, _targetpos, time];
stats_reinforcements_called = stats_reinforcements_called + 1;
if (_vehicle isKindOf "Plane_Base_F") then { _unload_dist = _unload_dist * 1.5 };

[_vehicle, _targetpos, _para_group, _unload_dist] spawn {
	params [ "_vehicle", "_targetpos", "_para_group", "_unload_dist"];

	waitUntil {
		sleep 0.2;
		if (_vehicle distance2D _targetpos <= _unload_dist * 3) then {
			_vehicle flyInHeight [200, true];
			_vehicle flyInHeightASL [200, 200, 200];
		};
		!(alive _vehicle) || (damage _vehicle > 0.2 ) || (_vehicle distance2D _targetpos <= _unload_dist)
	};

	if ({alive _x} count (units _para_group) > 0) then {
		[_para_group, _vehicle] call F_ejectGroup;
		[_para_group, _targetpos] spawn battlegroup_ai;
	};
};

private _hc = [] call F_lessLoadedHC;
if (isDedicated && !isNull _hc) then {
	_para_group setGroupOwner (owner _hc);
};

_para_group;
