// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: missionProcessor.sqf
//	@file Author: AgentRev
//	LRX Integration: pSiKO

if (!isServer) exitwith {};

private [
	"_controllerSuffix", "_availableLocations", "_missionLocation",
	"_marker", "_marker_zone", "_leaderTemp", "_lastPos"
];

// Variables that can be defined in the mission script :
private [
	"_missionType", "_locationsArray", "_vehicle", "_vehicles",
	"_missionPos", "_missionPicture", "_missionHintText",
	"_successHintMessage", "_failedHintMessage"
];

_controllerSuffix = param [0, "", [""]];
_continue_mission = true;
private _aiGroup = grpNull;
private _precise_marker = true;
private _missionTimeout = A3W_Mission_timeout;

if (!isNil "_setupVars") then { call _setupVars };

if (!isNil "A3W_debug") then { _missionTimeout = A3W_Mission_timeout };

if (!isNil "_locationsArray") then {
	_availableLocations = _locationsArray select {!(_x select 1) && ((_x select 2) <= time) };
	if (count _availableLocations == 0) exitWith { _continue_mission = false };
	_missionLocation = (selectRandom _availableLocations) select 0;
	if (isNil "_missionLocation") exitWith { _continue_mission = false };
	[_locationsArray, _missionLocation, true] call setLocationState;
};

if (!isNil "_missionlocation") then {
	A3W_sectors_in_use pushBack _missionLocation;
	publicVariable "A3W_sectors_in_use";
};

if (!isNil "_setupObjects" && _continue_mission) then { _continue_mission = call _setupObjects };
if (!_continue_mission) exitWith {
	diag_log format ["--- LRX Error: A3W Side Mission %1 failed to setup: %2", _controllerSuffix, localize _missionType];
	if (!isNil "_vehicle") then {
		[_vehicle] spawn cleanMissionVehicles;
	};
	if (!isNil "_vehicles") then {
		[_vehicles] spawn cleanMissionVehicles;
	};
};

["lib_secondary_a3w_mission", [localize _missionType]] remoteExec ["bis_fnc_shownotification", 0];
diag_log format ["A3W Side Mission %1 started: %2 timeout: %3", _controllerSuffix, localize _missionType, _missionTimeout];

sleep 5;
([_missionType, _missionPos, _precise_marker] call createMissionMarker) params ["_marker", "_marker_zone"];

if (isNil "_missionPicture") then { _missionPicture = "" };

[
	format ["%1 Objective", "Side"],
	_missionType,
	_missionPicture,
	_missionHintText,
	sideMissionColor
] remoteExec ["remote_call_showinfo", 0];

private _task = _missionType + str round time;
[true, _task, [localize _missionType, localize _missionType, _marker], markerPos _marker, "CREATED", 2, true] call BIS_fnc_taskCreate;

diag_log format ["A3W Side Mission %1 waiting to be finished: %2", _controllerSuffix, localize _missionType];

private _failed = false;
private _complete = false;
private _startTime = time;
private _lastPos = _missionPos;
private _count_blu = false;

if (isNil "_ignoreAiDeaths") then { _ignoreAiDeaths = false };

waitUntil {
	sleep 2;

	// Force immediate leader change if current one is dead
	if ( { alive _x } count (units _aiGroup) > 0) then {
		_leaderTemp = leader _aiGroup;
		if (!alive _leaderTemp) then {
			{
				if (alive _x) exitWith {
					_aiGroup selectLeader _x;
					_leaderTemp = _x;
				};
			} forEach units _aiGroup;
		};
		_lastPos = getPosATL _leaderTemp;
	};

	if (!isNil "_waitUntilMarkerPos") then {
		_marker setMarkerPos (call _waitUntilMarkerPos);
		[_task, _marker] call BIS_fnc_taskSetDestination;
	};
	if (!isNil "_waitUntilExec") then { call _waitUntilExec };
	if (!isNil "_waitUntilLastPos") then { _lastPos = call _waitUntilLastPos };

	private _time_left = round ((_missionTimeout - (time - _startTime)) /60);
	if (_time_left > 0) then {
		_marker setMarkerText format ["%1 - %2 min left", localize _missionType, _time_left];
	} else {
		_marker setMarkerText format ["%1 - time over", localize _missionType];
	};

	_count_blu = [_lastPos, (GRLIB_sector_size * 1.3), GRLIB_side_friendly] call F_getUnitsCount;
	_expired = (_time_left <= 0 && _count_blu == 0);
	_failed = ((!isNil "_waitUntilCondition" && {call _waitUntilCondition}) || _expired);
	_complete = (!isNil "_waitUntilSuccessCondition" && {call _waitUntilSuccessCondition});

	if (!_ignoreAiDeaths && {alive _x} count (units _aiGroup) == 0) then {
		if (_count_blu == 0) then {
			_failed = true;
		} else {
			_complete = true;
		};
	};

	(GRLIB_endgame == 1 || GRLIB_global_stop == 1 || _failed || _complete)
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
	[_task, "FAILED"] call BIS_fnc_taskSetState;
	diag_log format ["A3W Side Mission %1 failed: %2", _controllerSuffix, localize _missionType];
	A3W_mission_failed = A3W_mission_failed + 1;
} else {
	// Mission completed
	if (!isNil "_successExec") then { call _successExec };
	[
		"Objective Complete",
		_missionType,
		_missionPicture,
		_successHintMessage,
		successMissionColor
	] remoteExec ["remote_call_showinfo", 0];
	[_task, "SUCCEEDED"] call BIS_fnc_taskSetState;
	["lib_secondary_a3w_mission_success", [localize _missionType]] remoteExec ["bis_fnc_shownotification", 0];
	diag_log format ["A3W Mission%1 complete: %2", _controllerSuffix, localize _missionType];
	A3W_mission_success = A3W_mission_success + 1;
};

[_task] spawn {
	params ["_task"];
	sleep 120;
	[_task, true, true] call BIS_fnc_deleteTask;
};

// Cleanup
if (_count_blu == 0) then {
	{ deleteVehicle _x; sleep 0.1 } forEach (units _aiGroup);
	deleteGroup _aiGroup;
} else {
	[_lastPos, _aiGroup] spawn {
		params ["_pos", "_grp"];
		waitUntil { sleep 30; ([_pos, GRLIB_sector_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
		{ deleteVehicle _x; sleep 0.1 } forEach (units _grp);
		deleteGroup _grp;
	};
};

if (!isNil "_vehicle") then {
	[_vehicle] spawn cleanMissionVehicles;
};

if (!isNil "_vehicles") then {
	[_vehicles] spawn cleanMissionVehicles;
};

if (!isNil "_missionlocation") then {
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
	publicVariable "A3W_sectors_in_use";
};

if (!isNil "_locationsArray") then {
	[_locationsArray, _missionLocation, false] call setLocationState;
};

sleep 20;
