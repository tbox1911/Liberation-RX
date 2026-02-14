if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private [ "_prisoners", "_convoy_attacked", "_disembark_troops"];

_setupVars = {
	_missionType = "STR_PRI_CONV";
	_locationsArray = nil; // locations are generated on the fly from towns
	_ignoreAiDeaths = true;
	_missionTimeout = (45 * 60);
};

_setupObjects = {
	private _min_waypoints = 4;
	private _citylist = ((sectors_military + sectors_factory - active_sectors) select { _x in opfor_sectors && (count ([markerPos _x, GRLIB_capture_size] call F_getNearbyPlayers) == 0) });
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

	// veh1
	_vehicle1 = [_missionPos, opfor_mrap_hmg, 0, GRLIB_side_enemy, "", true, true] call F_libSpawnVehicle;
	(crew _vehicle1) joinSilent _aiGroup;
	(driver _vehicle1) limitSpeed 50;
	_aiGroup selectLeader (driver _vehicle1);
	_vehicle1 setVariable ["GRLIB_vehicle_owner", "public", true];
	sleep 1;

	// Waypoints
	[_aiGroup, _convoy_destinations] call add_convoy_waypoints;

	// wait
	(driver _vehicle1) doMove (_convoy_destinations select 1);
	private _timout = round (time + (3 * 60));
	waitUntil {sleep 1; _vehicle1 distance2D _missionPos > 30 || time > _timout};

	// veh2 + prisoners
	_vehicle2 = [_missionPos, a3w_truck_covered, 0, GRLIB_side_enemy, "", true, true] call F_libSpawnVehicle;
	(crew _vehicle2) joinSilent _aiGroup;
	_vehicle2 setVariable ["GRLIB_vehicle_owner", "public", true];

	_prisoners = [];
	if !(isNull _vehicle2) then {
		// Prisoners
		private _grp = [_missionPos, 5, "prisoner", false] call createCustomGroup;
		_prisoners = (units _grp);
		[_vehicle2, _prisoners] call F_manualCrew;
		
		// troops
		private _grp = [_missionPos, 3, "infantry", false] call createCustomGroup;
		[_vehicle2, (units _grp)] call F_manualCrew;
		(units _grp) joinSilent _aiGroup;

		// wait
		(driver _vehicle2) doMove (_convoy_destinations select 1);
		private _timout = round (time + (3 * 60));
		waitUntil {sleep 1; _vehicle2 distance2D _missionPos > 30 || time > _timout};
	};

	// veh3
	_vehicle3 = [_missionPos, a3w_truck_covered, 0, GRLIB_side_enemy, "", true, true] call F_libSpawnVehicle;
	(crew _vehicle3) joinSilent _aiGroup;
	_vehicle3 setVariable ["GRLIB_vehicle_owner", "public", true];

	if !(isNull _vehicle3) then {
		// troops
		private _grp = [_missionPos, 8, "infantry", false] call createCustomGroup;
		[_vehicle3, (units _grp)] call F_manualCrew;
		(units _grp) joinSilent _aiGroup;
		(driver _vehicle3) doMove (_convoy_destinations select 1);
	};

	// define final
	_missionPos = getPosATL leader _aiGroup;
	_missionPicture = getText (configFile >> "CfgVehicles" >> (a3w_truck_covered param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (a3w_truck_covered param [0,""]) >> "displayName");
	_missionHintText = ["STR_PRI_CONV_MESSAGE1", sideMissionColor];
	_convoy_attacked = false;
	_disembark_troops = false;
	_vehicles = [_vehicle1, _vehicle2, _vehicle3];

	// Manage convoy
	[_aiGroup, _vehicles] spawn convoy_ai;
	true;
};

_waitUntilMarkerPos = { getPosATL (_prisoners select 0) };
_waitUntilExec = nil;
_waitUntilCondition = {	(({ alive _x } count _prisoners) == 0) };

_waitUntilSuccessCondition = {
	private _alive_units = { alive _x } count _prisoners;
	private _free_units = { alive _x && side group _x == GRLIB_side_friendly } count _prisoners;
	(_alive_units > 0 && _free_units == _alive_units);
};

_failedExec = {
	// Mission failed
	private _intel = (10 + floor random 15); 
	_failedHintMessage = ["STR_PRI_CONV_MESSAGE2", sideMissionColor, _intel];
	{ deleteVehicle _x } foreach _prisoners;
	resources_intel = resources_intel - _intel;
	if (resources_intel < 0) then { resources_intel = 0 };
	publicVariable "resources_intel";
};

_successExec = {
	// Mission completed
	{ [_x, 15] call F_addReput } forEach ([markerPos _marker, GRLIB_sector_size] call F_getNearbyPlayers);
	_successHintMessage = ["STR_PRI_CONV_MESSAGE3", sideMissionColor];
};

_this call sideMissionProcessor;
