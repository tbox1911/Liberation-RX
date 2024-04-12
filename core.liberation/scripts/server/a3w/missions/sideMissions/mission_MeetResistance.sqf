if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_location_name", "_managed_units"];

_setupVars = {
	_missionType = "STR_RESISTANCE";
	// settings for this mission
	_missionLocation = [sectors_capture] call getMissionLocation;
	_ignoreAiDeaths = true;
	_locationsArray = nil;
	_missionTimeout = (30 * 60);
};

_setupObjects = {
	_missionPos = [(markerpos _missionLocation)] call F_findSafePlace;
	if (count _missionPos == 0) exitWith { 
    	diag_log format ["--- LRX Error: side mission MR, cannot find spawn point!"];
    	false;
	};
	_location_name = [_missionPos] call F_getLocationName;

	// create some atmosphere around the crates 8)
	_tent1 = createVehicle ["Land_cargo_addon02_V2_F", _missionPos, [], 3, "None"];
	_chair1 = createVehicle ["Land_CampingChair_V1_F", _missionPos, [], 2, "None"];
	_chair2 = createVehicle ["Land_CampingChair_V2_F", _missionPos, [], 2, "None"];
	_fire1 = createVehicle ["Campfire_burning_F", _missionPos, [], 2, "None"];

	// R3F disable
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_tent1, _chair1, _chair2, _fire1];

	// spawn some resistance
	_nbUnits = 5;
	_managed_units = [];

	// create static weapons + crew
	_veh1 = createVehicle [resistance_squad_static, _missionPos, [], 100, "None"];
	_managed_units append ([_veh1] call F_forceCrew);
	_veh1 setVariable ["GRLIB_vehicle_gunner", [gunner _veh1]];
	_veh1 setVariable ["GRLIB_vehicle_owner", "server", true];
	sleep 0.5;

	_veh2 = createVehicle [resistance_squad_static, _missionPos, [], 100, "None"];
	_managed_units append ([_veh2] call F_forceCrew);
	_veh2 setVariable ["GRLIB_vehicle_gunner", [gunner _veh2]];
	_veh2 setVariable ["GRLIB_vehicle_owner", "server", true];
	sleep 0.5;

	// get Houses nearbby
	_managed_units append (["resistance", 2, _missionPos] call F_spawnBuildingSquad);
	sleep 0.5;
	private _grp = [_missionPos, _nbUnits, "resistance"] call createCustomGroup;
	_managed_units append (units _grp);
	{
		_x setVariable ["GRLIB_can_speak", true, true];
		_x setVariable ["GRLIB_A3W_Mission_MR1", true, true];
	} foreach _managed_units;

	_vehicles = [_tent1, _chair1, _chair2, _fire1, _veh1, _veh2];
	_missionHintText = ["STR_RESISTANCE_MESSAGE1", sideMissionColor, _location_name];
	A3W_sectors_in_use = A3W_sectors_in_use + [_missionLocation];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilSuccessCondition = {
	_ret = false;
	if (!isNil "GRLIB_A3W_Mission_MR") then {
		private _opf = 0;
		{
			_opf = _opf + count (units _x select { alive _x && (_x distance2D _missionPos < (GRLIB_sector_size * 2) || !isNull objectParent _x) })
		} forEach GRLIB_A3W_Mission_MR;
		if (_opf == 0) then {_ret = true};
	};
	_ret;
 };
_waitUntilCondition = { {alive _x && _x distance2D _missionPos < 400} count _managed_units == 0 };

_failedExec = {
	// Mission failed
	{ [_x, -3] call F_addReput } forEach (AllPlayers - (entities "HeadlessClient_F"));
	{ deleteVehicle _x } forEach _managed_units;
	GRLIB_A3W_Mission_MR = nil;
	publicVariable "GRLIB_A3W_Mission_MR";
	_failedHintMessage = ["STR_RESISTANCE_MESSAGE2", sideMissionColor, _location_name];
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_successExec = {
	// Mission completed
	{ [_x, 5] call F_addReput } forEach ([_missionPos, GRLIB_capture_size] call F_getNearbyPlayers);
	{ deleteVehicle _x } forEach _managed_units;
	GRLIB_A3W_Mission_MR = nil;
	publicVariable "GRLIB_A3W_Mission_MR";
	// Reward
	[basic_weapon_typename, _missionPos, false] call boxSetup;
	[ammobox_i_typename, _missionPos, false] call boxSetup;
	_successHintMessage = ["STR_RESISTANCE_MESSAGE3", sideMissionColor, _location_name];
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_this call sideMissionProcessor;
