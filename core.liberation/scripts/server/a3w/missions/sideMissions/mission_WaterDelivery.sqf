if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_townName", "_marker_mission"];

_setupVars = {
	_missionType = "STR_WATERDELI";
	_locationsArray = [LRX_MissionMarkersCap] call checkSpawn;
	_ignoreAiDeaths = true;
};

_setupObjects = {
	_townName = markerText _missionLocation;	
	_missionPos = [(markerpos _missionLocation), 5, 0] call F_findSafePlace;
	if (count _missionPos == 0) exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
    	false;
	};
	_man1 = createAgent ["C_Marshal_F", _missionPos, [], 5, "NONE"];
	_man1 allowDamage false;
	_man1 setVariable ['GRLIB_can_speak', true, true];
	_man1 setVariable ["GRLIB_A3W_Mission_DL2", true, true];
	doStop _man1;
	[_man1, "LHD_krajPaluby"] spawn F_startAnimMP;
	_marker_mission = ["DEL4", _missionPos] call createMissionMarkerCiv;
	_missionHintText = ["STR_WATERDELI_MESSAGE1", sideMissionColor, _townName];
	_vehicles = [_man1];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;
_waitUntilSuccessCondition = { ([_missionPos, waterbarrel_typename, 3] call checkMissionItems) };

_failedExec = {
	// Mission failed
	{ [_x, -2] call F_addReput } forEach (AllPlayers - (entities "HeadlessClient_F"));
	private _msg = format [localize "STR_SIDE_FAILED_REPUT", -2];
	[gamelogic, _msg] remoteExec ["globalChat", 0];		
	deleteMarker _marker_mission;
	_failedHintMessage = ["STR_WATERDELI_MESSAGE2", sideMissionColor, _townName];
	A3W_delivery_failed = A3W_delivery_failed + 1;
};

_successExec = {
	// Mission completed
	private _winner = ([_missionPos, 50] call F_getNearbyPlayers) select 0;
	if (!isNil "_winner") then {
		private _bonus = round (22 + random 25);
        [_bonus] remoteExec ["remote_call_a3w_info", owner _winner];
        [_winner, _bonus] call F_addScore;
		[_winner, 5] call F_addReput;
	};
	_successHintMessage = ["STR_WATERDELI_MESSAGE3", sideMissionColor];
	deleteMarker _marker_mission;
	A3W_delivery_failed = 0;
};

_this call sideMissionProcessor;
