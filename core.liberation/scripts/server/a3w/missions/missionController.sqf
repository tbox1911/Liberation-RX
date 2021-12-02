// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: missionController.sqf
//	@file Author: AgentRev
//	LRX Integration: pSiKO

if (!isServer) exitWith {};

private ["_controllerNum", "_tempController", "_controllerSuffix", "_missionsFolder", "_missionDelay", "_availableMissions", "_missionsList", "_nextMission", "_info"];

_controllerNum = param [0, 1, [0]];
_tempController = param [1, false, [false]];
_controllerSuffix = format ["%1", _controllerNum];

_missionsFolder = MISSION_CTRL_FOLDER;
[MISSION_CTRL_PVAR_LIST, MISSION_CTRL_FOLDER] call attemptCompileMissions;

while {true} do {
	if (count allPlayers == 0 || GRLIB_endgame == 1) exitWith {};

	// Select Mission
	_nextMission = nil;
	while {isNil "_nextMission"} do	{
		[MISSION_CTRL_PVAR_LIST] call updateMissionsList;
		_availableMissions = [MISSION_CTRL_PVAR_LIST, { !(_x select 2) }] call BIS_fnc_conditionalSelect;
		// _availableMissions = MISSION_CTRL_PVAR_LIST; // If you want to allow multiple missions of the same type running along, uncomment this line and comment the one above

		if (count _availableMissions > 0) then {
			_missionsList = _availableMissions call generateMissionWeights;
			_nextMission = _missionsList call fn_selectRandomWeighted;
		} else {
			sleep 10;
		};
	};

	// Mission start + lock
	[MISSION_CTRL_PVAR_LIST, _nextMission, true] call setMissionState;
	
	// these should be defined in the mission script
	private ["_setupVars", "_setupObjects", "_waitUntilMarkerPos", "_waitUntilExec", "_waitUntilCondition", "_waitUntilSuccessCondition", "_ignoreAiDeaths", "_failedExec", "_successExec"];
	[_controllerSuffix] call compile preprocessFileLineNumbers format ["scripts\server\a3w\missions\%1\%2.sqf", MISSION_CTRL_FOLDER, _nextMission];

	// Mission ended, wait loop
	_missionDelay = MISSION_CTRL_DELAY + ((floor random 10) * 60);
	diag_log format ["Next Side Mission Starting in %1 minutes", _missionDelay/60];

	if (GRLIB_fancy_info == 2) then {
		_msg = format
				[
					"<t color='%1' shadow='2' size='1.75'>Next Objective</t><br/>" +
					"<t color='%1'>------------------------------</t><br/>" +
					"<t color='%2' size='1.0'>Starting in %3 minutes</t>",
					MISSION_CTRL_COLOR_DEFINE,
					subTextColor,
					_missionDelay / 60
				];
		_info = [_msg, 0, 0, 6, 0, -1, 90];
	} else {
		_info = ["Next Objective", "", format ["Starting in %1 minutes", _missionDelay / 60]];
	};
	[_info] remoteExec ["remote_call_showinfo", 0];

	_timer = round (time + _missionDelay);
	waitUntil {sleep 5; (time > _timer || count allPlayers == 0)};

	// Mission unlock
	[MISSION_CTRL_PVAR_LIST, _nextMission, false] call setMissionState;
	sleep 30;
};
