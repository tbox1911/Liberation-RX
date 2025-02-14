if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_location_name", "_managed_units"];

_setupVars = {
	_missionType = "STR_RESISTANCE";
	_locationsArray = [LRX_MissionMarkersCap] call checkSpawn;
	_ignoreAiDeaths = true;
	_missionTimeout = (30 * 60);
};

_setupObjects = {
	_missionPos = [(markerpos _missionLocation)] call F_findSafePlace;
	if (count _missionPos == 0) exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
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
	_nbUnits = 6;
	_managed_units = [];

	// the Resistance!
	private _grp = [_missionPos, _nbUnits, "resistance"] call createCustomGroup;
	_managed_units append (units _grp);
	sleep 1;

	// get Houses nearbby
	_managed_units append (["resistance", 2, _missionPos] call F_spawnBuildingSquad);
	sleep 1;

	// create static weapons
	_veh1 = createVehicle [a3w_resistance_static, _missionPos, [], 100, "None"];
	_managed_units append ([_veh1] call F_forceCrew);
	_veh1 setVariable ["R3F_LOG_disabled", true, true];
	sleep 1;

	_veh2 = createVehicle [a3w_resistance_static, _missionPos, [], 100, "None"];
	_managed_units append ([_veh2] call F_forceCrew);
	_veh2 setVariable ["R3F_LOG_disabled", true, true];
	sleep 1;

	// enable speak
	{
		_x setVariable ["GRLIB_mission_AI", true, true];
		_x setVariable ["GRLIB_can_speak", true, true];
		_x setVariable ["GRLIB_A3W_Mission_MR1", true, true];
	} foreach _managed_units;

	GRLIB_A3W_Mission_MR_BLUFOR = _managed_units;
	publicVariable "GRLIB_A3W_Mission_MR_BLUFOR";

	// manage side
	[_missionPos] spawn {
		params ["_target_pos"];
		sleep 3;
		private _start = false;
		waitUntil {
			sleep 1;
			if (isNil "GRLIB_A3W_Mission_MR_BLUFOR") exitWith { true };
			if (!isNil "GRLIB_A3W_Mission_MR_START") exitWith { _start = true; true };
			false;
		};
		if (_start) then {
			private _location_name = [_target_pos] call F_getLocationName;
			private _grp1 = [_target_pos, false, 250] call send_paratroopers;
			sleep 20;
			["lib_reinforcements", [_location_name]] remoteExec ["bis_fnc_shownotification", 0];
			private _grp2 = [_target_pos, false, 300] call send_paratroopers;
			sleep 20;
			["lib_reinforcements", [_location_name]] remoteExec ["bis_fnc_shownotification", 0];
			private _grp3 = grpNull;
			private _nb_player = count ([_target_pos, GRLIB_sector_size] call F_getNearbyPlayers);
			if (_nb_player > 1) then {
				_grp3 = [_target_pos, false, 300] call send_paratroopers;
				sleep  5;
			};
			GRLIB_A3W_Mission_MR_OPFOR = (units _grp1 + units _grp2 + units _grp3);
			publicVariable "GRLIB_A3W_Mission_MR_OPFOR";
			sleep 3;
		};
	};

	_vehicles = [_tent1, _chair1, _chair2, _fire1, _veh1, _veh2];
	_missionHintText = ["STR_RESISTANCE_MESSAGE1", sideMissionColor, _location_name];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilSuccessCondition = {
	private _ret = false;
	if (!isNil "GRLIB_A3W_Mission_MR_OPFOR") then {
		_ret = ({ alive _x && (_x distance2D _missionPos < (GRLIB_sector_size * 2) || !isNull objectParent _x) } count GRLIB_A3W_Mission_MR_OPFOR == 0);
	};
	_ret;
 };
_waitUntilCondition = { {alive _x && _x distance2D _missionPos < GRLIB_sector_size } count _managed_units == 0 };

_failedExec = {
	// Mission failed
	{ [_x, -3] call F_addReput } forEach (AllPlayers - (entities "HeadlessClient_F"));
	if (isNil "GRLIB_A3W_Mission_MR_OPFOR") then { GRLIB_A3W_Mission_MR_OPFOR = [] };
	[_missionPos, GRLIB_A3W_Mission_MR_BLUFOR + GRLIB_A3W_Mission_MR_OPFOR] spawn {
		params ["_pos", "_list"];
		waitUntil { sleep 30; ([_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
		{ deleteVehicle _x } forEach _list;
	};
	GRLIB_A3W_Mission_MR_START = nil;
	GRLIB_A3W_Mission_MR_BLUFOR = nil;
	GRLIB_A3W_Mission_MR_OPFOR = nil;
	publicVariable "GRLIB_A3W_Mission_MR_START";
	publicVariable "GRLIB_A3W_Mission_MR_BLUFOR";
	publicVariable "GRLIB_A3W_Mission_MR_OPFOR";
	_failedHintMessage = ["STR_RESISTANCE_MESSAGE2", sideMissionColor, _location_name];
};

_successExec = {
	// Mission completed
	{ [_x, 5] call F_addReput } forEach ([_missionPos, GRLIB_capture_size] call F_getNearbyPlayers);
	[_missionPos, GRLIB_A3W_Mission_MR_BLUFOR + GRLIB_A3W_Mission_MR_OPFOR] spawn {
		params ["_pos", "_list"];
		waitUntil { sleep 30; ([_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
		{ deleteVehicle _x } forEach _list;
	};
	GRLIB_A3W_Mission_MR_START = nil;
	GRLIB_A3W_Mission_MR_BLUFOR = nil;
	GRLIB_A3W_Mission_MR_OPFOR = nil;
	publicVariable "GRLIB_A3W_Mission_MR_START";
	publicVariable "GRLIB_A3W_Mission_MR_BLUFOR";
	publicVariable "GRLIB_A3W_Mission_MR_OPFOR";
	[basic_weapon_typename, _missionPos, false] call boxSetup;
	[ammobox_i_typename, _missionPos, false] call boxSetup;
	_successHintMessage = ["STR_RESISTANCE_MESSAGE3", sideMissionColor, _location_name];
};

_this call sideMissionProcessor;
