// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: missionController.sqf
//	@file Author: AgentRev
//	LRX Integration: pSiKO

if (!isServer) exitWith {};

params ["_controllerNum", ["_tempController", false]];
private ["_missionDelay", "_availableMissions", "_missionsList", "_nextMission", "_info"];

private _controllerSuffix = format ["%1", _controllerNum];
private _missionsFolder = "sideMissions";
[SideMissions, _missionsFolder] call attemptCompileMissions;

while {true} do {
	if (GRLIB_endgame == 1 || GRLIB_global_stop == 1) exitWith {};

	// Select Mission
	_nextMission = nil;
	while {isNil "_nextMission"} do	{
		[SideMissions] call updateMissionsList;
		_availableMissions = [SideMissions, { !(_x select 2) }] call BIS_fnc_conditionalSelect;
		// _availableMissions = SideMissions; // If you want to allow multiple missions of the same type running along, uncomment this line and comment the one above

		if (count _availableMissions > 0 && diag_fps > 35.0) then {
			if (A3W_delivery_failed > 3) then {
				_nextMission = "mission_TownInsurgency";
				A3W_delivery_failed = 0;
			} else {
				_missionsList = [_availableMissions] call generateMissionWeights;
				_nextMission = _missionsList call fn_selectRandomWeighted;
			};

			if (!isNil "A3W_debug") then {
				diag_log "--- A3W Missions Debug ---";
				if (!isNil "A3W_mission") then { _nextMission = A3W_mission };
				{ diag_log format ["    %1", _x] } foreach SideMissions;
				diag_log format ["DBG: A3W mission selected: %1", _nextMission];
				diag_log format ["DBG: A3W mission success: %1 / failed: %2", A3W_mission_success, A3W_mission_failed];
				diag_log format ["DBG: A3W mission timer: delay: %1 - timeout: %2", A3W_Mission_delay, A3W_Mission_timeout];
			};
		} else {
			sleep 30;
		};
	};

	// Mission start + lock
	[SideMissions, _nextMission, true] call setMissionState;
	
	// these should be defined in the mission script
	private ["_setupVars", "_setupObjects", "_waitUntilMarkerPos", "_waitUntilExec", "_waitUntilCondition", "_waitUntilSuccessCondition", "_ignoreAiDeaths", "_failedExec", "_successExec"];
	[_controllerSuffix] call compile preprocessFileLineNumbers format ["scripts\server\a3w\missions\%1\%2.sqf", _missionsFolder, _nextMission];

	// Mission ended, wait loop
	_missionDelay = A3W_Mission_delay + ((floor random 11) * 60);
	if (!isNil "A3W_debug") then { _missionDelay = A3W_Mission_delay };

	diag_log format ["Next Side Mission Starting in %1 minutes", _missionDelay/60];

	[
		"Next Objective",
		"",
		"",
		format ["Starting in %1 minutes", _missionDelay / 60],
		sideMissionColor
	] remoteExec ["remote_call_showinfo", 0];

	_timer = round (time + _missionDelay);
	waitUntil {sleep 5; (time > _timer)};

	// Mission unlock
	[SideMissions, _nextMission, false] call setMissionState;
	sleep 30;
};
