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
	_missionPos = [(markerpos _missionLocation), 5, 0] call F_findSafePlace;
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

	// create static weapons
	private _veh1 = objNull;
	private _pos = [_missionPos, 3, 0, 80] call F_findSafePlace;
	if (count _pos > 0) then {
		private _static_units = [_pos, 1, GRLIB_side_friendly, true, "resistance"] call spawn_static;
		_veh1 = _static_units select 0;
		_managed_units append _static_units;
		sleep 1;
	};
	
	private _veh2 = objNull;
	private _pos = [_missionPos, 3, 0, 80] call F_findSafePlace;
	if (count _pos > 0) then {
		private _static_units = [_pos, 1, GRLIB_side_friendly, true, "resistance"] call spawn_static;
		_veh2 = _static_units select 0;
		_managed_units append _static_units;
		sleep 1;
	};

	// enable speak
	{
		_x setCaptive true;
		_x setVariable ["GRLIB_can_speak", true, true];
		_x setVariable ["GRLIB_A3W_Mission_MR1", true, true];
	} foreach _managed_units;

	GRLIB_A3W_Mission_MR_BLUFOR = _managed_units;
	publicVariable "GRLIB_A3W_Mission_MR_BLUFOR";

	// manage mission
	[_missionPos, _managed_units] spawn {
		params ["_target_pos", "_managed_units"];
		sleep 3;
		private _start = false;
		waitUntil {
			sleep 1;
			if (isNil "GRLIB_A3W_Mission_MR_BLUFOR") exitWith { true };
			if (!isNil "GRLIB_A3W_Mission_MR_START") exitWith { _start = true; true };
			false;
		};
		if (_start) then {
			private _troops = [];
			private _location_name = [_target_pos] call F_getLocationName;
			private _grp1 = [_target_pos, false, 250] call send_paratroopers;
			_troops = (units _grp1);
			sleep 10;
			["lib_reinforcements", [_location_name]] remoteExec ["bis_fnc_shownotification", 0];
			_grp1 = [_target_pos, false, 300] call send_paratroopers;
			_troops append (units _grp1);
			sleep 10;
			["lib_reinforcements", [_location_name]] remoteExec ["bis_fnc_shownotification", 0];
			private _nb_player = count (AllPlayers - (entities "HeadlessClient_F"));
			if (_nb_player > 2) then {
				_grp1 = [_target_pos, false, 300] call send_paratroopers;
				_troops append (units _grp1);
				sleep  10;
			};
			{ _x setCaptive false } foreach _managed_units;

			GRLIB_A3W_Mission_MR_OPFOR = _troops;
			publicVariable "GRLIB_A3W_Mission_MR_OPFOR";
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
	private _msg = format [localize "STR_SIDE_FAILED_REPUT", -3];
	[gamelogic, _msg] remoteExec ["globalChat", 0];
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
	{ [_x, 25] call F_addReput } forEach ([_missionPos, GRLIB_sector_size] call F_getNearbyPlayers);
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
