if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private [ "_vip", "_convoy_attacked", "_disembark_troops"];

_setupVars = {
	_missionType = "STR_VIP_CAP";
	_locationsArray = nil; // locations are generated on the fly from towns
	_ignoreAiDeaths = true;
	_missionTimeout = (40 * 60);
};

_setupObjects = {
	private _min_waypoints = 3;
	private _citylist = ((sectors_bigtown - active_sectors) select { _x in opfor_sectors && (count ([markerPos _x, GRLIB_capture_size] call F_getNearbyPlayers) == 0) });
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

	// veh1 + squad
	_vehicle1 = [_missionPos, a3w_vip_vehicle, 0, false, GRLIB_side_enemy, false, true] call F_libSpawnVehicle;
	private _vehicle_seat = (_vehicle1 emptyPositions "") min 5;
	if (_vehicle_seat < 3) exitWith {
		diag_log format ["--- LRX Error: side mission %1, vehicle %2, no enough seat!", _missionType ,typeOf _vehicle1];
		deleteVehicle _vehicle1;
		false;
	};

	private _grp = [_missionPos, _vehicle_seat, "guards", false] call createCustomGroup;
	[_vehicle1, _grp] call F_manualCrew;
	(units _grp) joinSilent _aiGroup;
	(driver _vehicle1) limitSpeed 50;
	_aiGroup selectLeader (driver _vehicle1);
	sleep 1;

	// Waypoints
	[_aiGroup, _convoy_destinations] call add_convoy_waypoints;

	// wait
	(driver _vehicle1) MoveTo (_convoy_destinations select 1);
	private _timout = round (time + (3 * 60));
	waitUntil {sleep 1; _vehicle1 distance2D _missionPos > 30 || time > _timout};

	// veh2 + vip + squad
	_vehicle2 = [_missionPos, a3w_vip_vehicle, 0, false, GRLIB_side_enemy, false, true] call F_libSpawnVehicle;
	_grp = [_missionPos, (_vehicle_seat-1), "guards", false] call createCustomGroup;
	[_vehicle2, _grp] call F_manualCrew;
	(units _grp) joinSilent _aiGroup;

	// VIP
	_vip = _aiGroup createUnit ["O_Officer_Parade_Veteran_F", _missionPos, [], 0, "NONE"];
	[_vip] joinSilent _aiGroup;
	_vip addEventHandler ["HandleDamage", { _this call damage_manager_enemy }];
	_vip addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
	_vip setVariable ["GRLIB_mission_AI", true, true];
	_vip setSkill ["courage", 0.5];
	_vip setrank "COLONEL";
	_vip assignAsCargo _vehicle2;
	_vip moveInCargo _vehicle2;
	[_vip] spawn {
		params ["_unit"];
		waitUntil { sleep 1; (isNull objectParent _unit || !alive _unit) };
		if (!alive _unit) exitWith {};
		[_unit, false, true] spawn prisoner_ai;
	};

	// wait
	(driver _vehicle2) MoveTo (_convoy_destinations select 1);
	private _timout = round (time + (3 * 60));
	waitUntil {sleep 1; _vehicle2 distance2D _missionPos > 30 || time > _timout};

	// veh3 + squad
	_vehicle3 = [_missionPos, a3w_vip_vehicle, 0, false, GRLIB_side_enemy, false, true] call F_libSpawnVehicle;
	_grp = [_missionPos, _vehicle_seat, "guards", false] call createCustomGroup;
	[_vehicle3, _grp] call F_manualCrew;
	(units _grp) joinSilent _aiGroup;
	(driver _vehicle3) MoveTo (_convoy_destinations select 1);

	// define final
	_missionPos = getPosATL leader _aiGroup;
	_missionPicture = getText (configFile >> "CfgVehicles" >> (a3w_vip_vehicle param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (a3w_vip_vehicle param [0,""]) >> "displayName");
	_missionHintText = ["STR_VIP_CAP_MESSAGE1", sideMissionColor];
	_convoy_attacked = false;
	_disembark_troops = false;
	_vehicles = [_vehicle1, _vehicle2, _vehicle3];

	// Manage convoy
	[_aiGroup, _vehicles] spawn convoy_ai;
	true;
};

_waitUntilMarkerPos = { getPosATL _vip };
_waitUntilExec = nil;
_waitUntilCondition = { (!alive _vip) };
_waitUntilSuccessCondition = { alive _vip && side group _vip == GRLIB_side_friendly };

_failedExec = {
	// Mission failed
	_failedHintMessage = ["STR_VIP_CAP_MESSAGE2", sideMissionColor];
	deleteVehicle _vip;
};

_successExec = {
	// Mission completed
	_successHintMessage = ["STR_VIP_CAP_MESSAGE3", sideMissionColor];
};

_this call sideMissionProcessor;
