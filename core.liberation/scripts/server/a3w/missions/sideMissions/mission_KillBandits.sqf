if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_convoy_attacked", "_disembark_troops"];

_setupVars = {
	_missionType = "STR_KILL_BANDIT";
	_locationsArray = nil; // locations are generated on the fly from towns
	_missionTimeout = (40 * 60);
};

_setupObjects = {
	private _min_waypoints = 5;
	private _citylist = ((sectors_capture - active_sectors) select { _x in blufor_sectors });
	if (count _citylist < _min_waypoints) exitWith {
		diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
		false;
	};

	private _convoy_destinations_markers = [6000, _citylist, _min_waypoints] call F_getSectorPath;
	private _convoy_destinations = [_convoy_destinations_markers] call F_getPathRoadFilter;
	if (count _convoy_destinations < _min_waypoints) exitWith {
		diag_log format ["--- LRX Error: side mission %1, cannot find sector path!", localize _missionType];
		false;
	};

	_missionPos = _convoy_destinations select 0;
	_aiGroup = createGroup [GRLIB_side_enemy, true];

	private _blacklist = [
		"tractor",
		"bicycle",
		"medevac",
		"b_gen_van",
		"kart_",
		"quadbike_",
		"_van_"
	];

	private _allowed_veh = {
		params ["_item", "_blaklist"];
		private _ret = true;
		{ if (_item find _x >= 0) exitWith { _ret = false } } foreach _blaklist;
		_ret;
	};

	private _bandits_car = selectRandom (civilian_vehicles select { _x isKindOf "Car" && [tolower _x, _blacklist] call _allowed_veh });
	if (isNil "_bandits_car") exitWith {
		diag_log format ["--- LRX Error: side mission %1, cannot find vehicle classname!", localize _missionType];
		false;
	};

	// veh1
	_vehicle1 = [_missionPos, _bandits_car, 0, false, GRLIB_side_enemy, false, true] call F_libSpawnVehicle;
	private _vehicle_seat = (_vehicle1 emptyPositions "") min 4;
	if (_vehicle_seat < 3) exitWith {
		diag_log format ["--- LRX Error: side mission %1, vehicle %2, no enough seat!", localize _missionType ,typeOf _vehicle1];
		deleteVehicle _vehicle1;
		false;
	};

	private _grp = [_missionPos, _vehicle_seat, "bandits", false] call createCustomGroup;
	[_vehicle1, _grp] call F_manualCrew;
	(units _grp) joinSilent _aiGroup;
	(driver _vehicle1) limitSpeed 50;
	_aiGroup selectLeader (driver _vehicle1);
	_vehicle1 setVariable ["GRLIB_vehicle_owner", "public", true];
	sleep 1;

	// Waypoints
	[_aiGroup, _convoy_destinations] call add_convoy_waypoints;

	// wait
	(driver _vehicle1) MoveTo (_convoy_destinations select 1);
	private _timout = round (time + (3 * 60));
	waitUntil {sleep 1; _vehicle1 distance2D _missionPos > 30 || time > _timout};

	// veh2
	_vehicle2 = [_missionPos, _bandits_car, 0, false, GRLIB_side_enemy, false, true] call F_libSpawnVehicle;
	_grp = [_missionPos, _vehicle_seat, "bandits", false] call createCustomGroup;
	[_vehicle2, _grp] call F_manualCrew;
	(units _grp) joinSilent _aiGroup;
	_vehicle2 setVariable ["GRLIB_vehicle_owner", "public", true];

	// wait
	(driver _vehicle2) MoveTo (_convoy_destinations select 1);
	private _timout = round (time + (3 * 60));
	waitUntil {sleep 1; _vehicle2 distance2D _missionPos > 30 || time > _timout};

	// veh3
	_vehicle3 = [_missionPos, _bandits_car, 0, false, GRLIB_side_enemy, false, true] call F_libSpawnVehicle;
	_grp = [_missionPos, _vehicle_seat, "bandits", false] call createCustomGroup;
	[_vehicle3, _grp] call F_manualCrew;
	(units _grp) joinSilent _aiGroup;
	_vehicle3 setVariable ["GRLIB_vehicle_owner", "public", true];
	(driver _vehicle3) MoveTo (_convoy_destinations select 1);
	sleep 1;

	// define final
	_missionPos = getPosATL leader _aiGroup;
	_missionPicture = getText (configFile >> "CfgVehicles" >> (_bandits_car param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (_bandits_car param [0,""]) >> "displayName");
	_missionHintText = ["STR_KILL_BANDIT_MESSAGE1", sideMissionColor];
	_convoy_attacked = false;
	_disembark_troops = false;
	_vehicles = [_vehicle1, _vehicle2, _vehicle3];

	// Manage convoy
	[_aiGroup, _vehicles] spawn convoy_ai;
	true;
};

_waitUntilMarkerPos = { getPosATL (leader _aiGroup) };
_waitUntilExec = nil;
_waitUntilCondition = nil;
_waitUntilSuccessCondition = nil;

_failedExec = {
	// Mission failed
	_failedHintMessage = ["STR_KILL_BANDIT_MESSAGE2", sideMissionColor];
	{ [_x, -5] call F_addReput } forEach (AllPlayers - (entities "HeadlessClient_F"));
	private _msg = format [localize "STR_SIDE_FAILED_REPUT", -5];
	[gamelogic, _msg] remoteExec ["globalChat", 0];
};

_successExec = {
	// Mission completed
	_successHintMessage = ["STR_KILL_BANDIT_MESSAGE3", sideMissionColor];
};

_this call sideMissionProcessor;
