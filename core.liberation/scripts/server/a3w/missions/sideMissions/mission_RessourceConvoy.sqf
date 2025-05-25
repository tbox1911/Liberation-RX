if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private [ "_ressources", "_convoy_attacked", "_disembark_troops"];

_setupVars = {
	_missionType = "STR_RSC_CONV";
	_locationsArray = nil; // locations are generated on the fly from towns
	_ignoreAiDeaths = true;
	_missionTimeout = (45 * 60);
};

_setupObjects = {
	// Check Box
	private _boxes_amount = 0;
	{
		if ( _x select 0 == a3w_truck_open ) exitWith { _boxes_amount = (count _x) - 2 };
	} foreach box_transport_config;
	if ( _boxes_amount == 0 ) exitWith {
		diag_log format ["Opfor ammobox truck (%1) doesn't allow for ammobox transport, correct your classnames!",  a3w_truck_open];
		false;
	};

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
	_vehicle1 = [_missionPos, opfor_mrap_hmg, 0, false, GRLIB_side_enemy, true, true] call F_libSpawnVehicle;
	(crew _vehicle1) joinSilent _aiGroup;
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

	// veh2 + ressources
	_vehicle2 = [_missionPos, a3w_truck_open, 0, false, GRLIB_side_enemy, true, true] call F_libSpawnVehicle;
	(crew _vehicle2) joinSilent _aiGroup;
	_vehicle2 setVariable ["GRLIB_vehicle_owner", "public", true];

	_ressources = [];
	if !(isNull _vehicle2) then {
		// Ressources
		for "_n" from 1 to _boxes_amount do {
			private _boxclass = selectRandom [ammobox_o_typename, waterbarrel_typename, fuelbarrel_typename, repairbox_typename, basic_weapon_typename];
			[_vehicle2, _boxclass] call attach_object_direct;
		};
		_ressources = _vehicle2 getVariable ["GRLIB_ammo_truck_load", []];

		// wait
		(driver _vehicle2) MoveTo (_convoy_destinations select 1);
		private _timout = round (time + (3 * 60));
		waitUntil {sleep 1; _vehicle2 distance2D _missionPos > 30 || time > _timout};
	};

	// veh3
	_vehicle3 = [_missionPos, a3w_truck_covered, 0, false, GRLIB_side_enemy, true, true] call F_libSpawnVehicle;
	(crew _vehicle3) joinSilent _aiGroup;
	_vehicle3 setVariable ["GRLIB_vehicle_owner", "public", true];

	if !(isNull _vehicle3) then {
		// troops
		private _grp = [_missionPos, 8, "infantry", false] call createCustomGroup;
		{
			_x assignAsCargo _vehicle3;
			_x moveInCargo _vehicle3;
			sleep 0.1;
		} forEach (units _grp);
		(units _grp) joinSilent _aiGroup;
		(driver _vehicle3) MoveTo (_convoy_destinations select 1);
	};

	// define final
	_missionPos = getPosATL leader _aiGroup;
	_missionPicture = getText (configFile >> "CfgVehicles" >> (a3w_truck_open param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (a3w_truck_open param [0,""]) >> "displayName");
	_missionHintText = ["STR_RSC_CONV_MESSAGE1", sideMissionColor];
	_convoy_attacked = false;
	_disembark_troops = false;
	_vehicles = [_vehicle1, _vehicle2, _vehicle3];

	// Manage convoy
	[_aiGroup, _vehicles] spawn convoy_ai;
	true;
};

_waitUntilMarkerPos = { getPosATL (_ressources select 0) };
_waitUntilExec = nil;
_waitUntilCondition = {	(({ alive _x } count _ressources) == 0) };

_waitUntilSuccessCondition = {
	private _free_box = { alive _x && isNull (attachedTo _x) } count _ressources;
	private _truck = attachedTo (_ressources select 0);
	if (isNil "_truck") exitWith { false };
	(_free_box > 0 || (side group _truck == GRLIB_side_friendly));
};

_failedExec = {
	// Mission failed
	_failedHintMessage = ["STR_RSC_CONV_MESSAGE2", sideMissionColor];
	{ deleteVehicle _x } foreach _ressources;
};

_successExec = {
	// Mission completed
	_successHintMessage = ["STR_RSC_CONV_MESSAGE3", sideMissionColor];
};

_this call sideMissionProcessor;
