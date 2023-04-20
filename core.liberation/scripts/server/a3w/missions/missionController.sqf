// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: missionController.sqf
//	@file Author: AgentRev

if (!isServer) exitWith {};

private ["_controllerNum", "_tempController", "_controllerSuffix", "_missionsFolder", "_missionDelay", "_availableMissions", "_missionsList", "_nextMission", "_info"];

_controllerNum = param [0, 1, [0]];
_tempController = param [1, false, [false]];
_controllerSuffix = format [" %1", _controllerNum];

_missionsFolder = MISSION_CTRL_FOLDER;
[MISSION_CTRL_PVAR_LIST, MISSION_CTRL_FOLDER] call attemptCompileMissions;

while {true} do {
	_nextMission = nil;

	while {isNil "_nextMission"} do	{
		_availableMissions = [MISSION_CTRL_PVAR_LIST, { !(_x select 2) }] call BIS_fnc_conditionalSelect;
		// _availableMissions = MISSION_CTRL_PVAR_LIST; // If you want to allow multiple missions of the same type running along, uncomment this line and comment the one above

		if (count _availableMissions > 0) then {
			_missionsList = _availableMissions call generateMissionWeights;

			// Limit Town capture
			_opfor_sectors = (count sectors_allSectors) - (count blufor_sectors);
			_opfor_factor = round ((_opfor_sectors / (count sectors_allSectors)) * 100);

			if (_opfor_factor <= 40 && count allPlayers > 1) then {
				_missionsList = ["mission_TownInvasion", false, _missionsList, 1] call updateMissionsList;
			} else {
				_missionsList = ["mission_TownInvasion", true, _missionsList] call updateMissionsList;
			};

			// Disable HostileHelicopter if no more bigcity
			_opfor_city = count ([(call cityList)] call checkSpawn);
			if (_opfor_city <= 1) then {
				_missionsList = ["mission_HostileHelicopter", true, _missionsList] call updateMissionsList;
			} else {
				_missionsList = ["mission_HostileHelicopter", false, _missionsList, 1] call updateMissionsList;
			};

			// MeetRes
			if (count blufor_sectors >= 7 && _opfor_factor >= 50) then {
				_missionsList = ["mission_MeetResistance", false, _missionsList, 1] call updateMissionsList;
			} else {
				_missionsList = ["mission_MeetResistance", true, _missionsList] call updateMissionsList;
			};

			// Special Delivery
			if (count blufor_sectors >= 10) then {
				_missionsList = ["mission_SpecialDelivery", false, _missionsList, 1] call updateMissionsList;
			} else {
				_missionsList = ["mission_SpecialDelivery", true, _missionsList] call updateMissionsList;
			};

			// Water Delivery
			if (count blufor_sectors >= 5 && {_x in sectors_tower} count blufor_sectors >= 3) then {
				_missionsList = ["mission_WaterDelivery", false, _missionsList, 1] call updateMissionsList;
			} else {
				_missionsList = ["mission_WaterDelivery", true, _missionsList] call updateMissionsList;
			};

			// Food Delivery
			if (count blufor_sectors >= 5 && {_x in sectors_bigtown} count blufor_sectors >= 1) then {
				_missionsList = ["mission_FoodDelivery", false, _missionsList, 1] call updateMissionsList;
			} else {
				_missionsList = ["mission_FoodDelivery", true, _missionsList] call updateMissionsList;
			};

			// Fuel Delivery
			if (count blufor_sectors >= 5 && {_x in sectors_factory} count blufor_sectors >= 3) then {
				_missionsList = ["mission_FuelDelivery", false, _missionsList, 1] call updateMissionsList;
			} else {
				_missionsList = ["mission_FuelDelivery", true, _missionsList] call updateMissionsList;
			};

			_nextMission = _missionsList call fn_selectRandomWeighted;
		} else {
			sleep 10;
		};
	};

	[MISSION_CTRL_PVAR_LIST, _nextMission, true] call setMissionState;

	_missionDelay = MISSION_CTRL_DELAY + ((floor random 10) * 60);
	diag_log format ["%1 Mission%2 waiting to run: %3 in %4min", MISSION_CTRL_TYPE_NAME, _controllerSuffix, _nextMission, _missionDelay/60];

	if (GRLIB_fancy_info == 2) then {
		_msg = format
				[
					"<t color='%1' shadow='2' size='1.75'>%2 Objective</t><br/>" +
					"<t color='%1'>------------------------------</t><br/>" +
					"<t color='%3' size='1.0'>Starting in %4 minutes</t>",
					MISSION_CTRL_COLOR_DEFINE,
					MISSION_CTRL_TYPE_NAME,
					subTextColor,
					_missionDelay / 60
				];
		_info = [_msg, 0, 0, 3, 0, -1, 90];
	} else {
		_info = [
			format ["%1 Objective", MISSION_CTRL_TYPE_NAME],
			"",
			format ["Starting in %1 minutes", _missionDelay / 60]
		];
	};
	[_info] remoteExec ["remote_call_showinfo", 0];

	_timer = time;
	waitUntil {sleep 5; ( time > (_timer + _missionDelay) || count allPlayers == 0)};
	if (count allPlayers == 0) exitWith {};

	// these should be defined in the mission script
	private ["_setupVars", "_setupObjects", "_waitUntilMarkerPos", "_waitUntilExec", "_waitUntilCondition", "_waitUntilSuccessCondition", "_ignoreAiDeaths", "_failedExec", "_successExec"];

	[_controllerSuffix] call compile preprocessFileLineNumbers format ["scripts\server\a3w\missions\%1\%2.sqf", MISSION_CTRL_FOLDER, _nextMission];

	[MISSION_CTRL_PVAR_LIST, _nextMission, false] call setMissionState;

	if (_tempController || count allPlayers == 0 || GRLIB_endgame == 1 ) exitWith {};
	sleep 10;
};
