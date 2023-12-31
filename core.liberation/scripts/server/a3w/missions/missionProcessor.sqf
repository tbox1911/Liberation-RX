// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: missionProcessor.sqf
//	@file Author: AgentRev
//	LRX Integration: pSiKO

if (!isServer) exitwith {};

private [
	"_controllerSuffix", "_missionTimeout", "_availableLocations", "_missionLocation",
	"_marker", "_marker_zone", "_time_left", "_failed", "_complete", "_startTime", "_leaderTemp", 
	"_lastPos", "_floorHeight"
];

// Variables that can be defined in the mission script :
private [
	"_missionType", "_locationsArray", "_aiGroup", "_vehicle", "_vehicles",
	"_missionPos", "_precise_marker", "_missionPicture", "_missionHintText",
	"_successHintMessage", "_failedHintMessage"
];

_controllerSuffix = param [0, "", [""]];
_aiGroup = grpNull;
_precise_marker = true;
if (!isNil "_setupVars") then { call _setupVars };

_missionTimeout = A3W_Mission_timeout;

if (!isNil "_locationsArray") then {
	while {true} do	{
		_availableLocations = [_locationsArray, {!(_x select 1) && (_x param [2, 0]) <= time }] call BIS_fnc_conditionalSelect;
		if (count _availableLocations > 0) exitWith {};
		sleep 60;
	};

	_missionLocation = (selectRandom _availableLocations) select 0;
	[_locationsArray, _missionLocation, true] call setLocationState;
};

_continue_mission = true;
if (!isNil "_setupObjects") then { _continue_mission = call _setupObjects };
if (!_continue_mission) exitWith {
	diag_log format ["--- LRX Error: A3W Side Mission%1 failed to setup: %2", _controllerSuffix, localize _missionType];
};
publicVariable "A3W_sectors_in_use";

["lib_secondary_a3w_mission", [localize _missionType]] remoteExec ["bis_fnc_shownotification", 0];
diag_log format ["A3W Side Mission% started: %2", _controllerSuffix, localize _missionType];

sleep 5;
([localize _missionType, _missionPos, _precise_marker] call createMissionMarker) params ["_marker", "_marker_zone"];
_aiGroup setVariable ["A3W_missionMarkerName", _marker, true];

if (isNil "_missionPicture") then { _missionPicture = "" };

[
	format ["%1 Objective", "Side"],
	_missionType,
	_missionPicture,
	_missionHintText,
	sideMissionColor
] remoteExec ["remote_call_showinfo", 0];

diag_log format ["A3W Side Mission%1 waiting to be finished: %2", _controllerSuffix, localize _missionType];

_failed = false;
_complete = false;
_startTime = time;
_lastPos = getPos (leader _aiGroup);

if (isNil "_ignoreAiDeaths") then { _ignoreAiDeaths = false };

waitUntil {
	sleep 1;

	_leaderTemp = leader _aiGroup;

	// Force immediate leader change if current one is dead
	if (!alive _leaderTemp) then {
		{
			if (alive _x) exitWith {
				_aiGroup selectLeader _x;
				_leaderTemp = _x;
			};
		} forEach units _aiGroup;
	} else {
		_lastPos = getPosATL _leaderTemp;
	};

	if (!isNil "_waitUntilMarkerPos") then { _marker setMarkerPos (call _waitUntilMarkerPos) };
	if (!isNil "_waitUntilExec") then { call _waitUntilExec };
	_time_left = round ((_missionTimeout - (time - _startTime)) /60);
	if (_time_left > 0) then {
		_marker setMarkerText format ["%1 - %2 min left", localize _missionType, _time_left];
	} else {
		_marker setMarkerText format ["%1 - time over", localize _missionType];
	};

	_expired = (_time_left <= 0 && ([_lastPos, GRLIB_capture_size, GRLIB_side_friendly] call F_getUnitsCount) == 0);
	_failed = ((!isNil "_waitUntilCondition" && {call _waitUntilCondition}) || _expired);

	if (!isNil "_waitUntilSuccessCondition" && {call _waitUntilSuccessCondition}) then {
		_failed = false;
		_complete = true;
	};

	(GRLIB_endgame == 1 || GRLIB_global_stop == 1 || _failed || _complete || (!_ignoreAiDeaths && {alive _x} count (units _aiGroup) == 0))
};

if (GRLIB_endgame == 1 || GRLIB_global_stop == 1) then { _failed = true };

deleteMarker _marker;
deleteMarker _marker_zone;

if (_failed) then {
	// Mission failed
	if (!isNil "_failedExec") then { call _failedExec };
	[
		"Objective Failed",
		_missionType,
		_missionPicture,
		if (!isNil "_failedHintMessage") then { _failedHintMessage } else { "Better luck next time!" },
		failMissionColor
	] remoteExec ["remote_call_showinfo", 0];
	["lib_secondary_a3w_mission_fail", [localize _missionType]] remoteExec ["bis_fnc_shownotification", 0];

	// Cleanup
	{ deleteVehicle _x } forEach (units _aiGroup);
	if (!isNil "_vehicle") then	{ [_vehicle] spawn cleanMissionVehicles };
	if (!isNil "_vehicles") then { [_vehicles] spawn cleanMissionVehicles };

	diag_log format ["A3W Side Mission%1 failed: %2", _controllerSuffix, localize _missionType];
	A3W_mission_failed = A3W_mission_failed + 1;
} else {
	// Mission completed
	if (!isNil "_successExec") then { call _successExec };

	if (!isNil "_vehicle") then {
		_vehicle setVariable ["R3F_LOG_disabled", false, true];
		[_vehicle, 300] spawn cleanMissionVehicles;
	};

	if (!isNil "_vehicles") then {
		{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach _vehicles;
		[_vehicles, 300] spawn cleanMissionVehicles;
	};

	[
		"Objective Complete",
		_missionType,
		_missionPicture,
		_successHintMessage,
		successMissionColor
	] remoteExec ["remote_call_showinfo", 0];

	["lib_secondary_a3w_mission_success", [localize _missionType]] remoteExec ["bis_fnc_shownotification", 0];
	diag_log format ["A3W Mission%1 complete: %2", _controllerSuffix, localize _missionType];
	A3W_mission_success = A3W_mission_success + 1;
};

publicVariable "A3W_sectors_in_use";
deleteGroup _aiGroup;

if (!isNil "_locationsArray") then {
	[_locationsArray, _missionLocation, false] call setLocationState;
};

sleep 20;
