if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_townName", "_man1", "_marker_mission"];

_setupVars = {
	_missionType = "STR_FUELDELI";
	_missionLocation = [sectors_capture] call getMissionLocation;
	_townName = markerText _missionLocation;
	_ignoreAiDeaths = true;
	_locationsArray = nil;
};

_setupObjects = {
	_missionPos = [(markerpos _missionLocation)] call F_findSafePlace;
	if (count _missionPos == 0) exitWith { 
    	diag_log format ["--- LRX Error: side mission FD2, cannot find spawn point!"];
    	false;
	};	
	_mission_grp = createGroup [GRLIB_side_civilian, true];
	_man1 = _mission_grp createUnit ["C_Marshal_F", _missionPos, [], 0, "NONE"];
	_man1 setVariable ['GRLIB_can_speak', true, true];
	_man1 setVariable ["GRLIB_A3W_Mission_DL1", true, true];
	_man1 setVariable ["acex_headless_blacklist", true, true];
	_man1 setVariable ["GRLIB_vehicle_owner", "server", true];
	_man1 allowDamage false;
	[_man1, "LHD_krajPaluby"] spawn F_startAnimMP;
	_marker_mission = ["DEL3", _missionPos] call createMissionMarkerCiv;

	_missionHintText = ["STR_FUELDELI_MESSAGE1", sideMissionColor, _townName];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_waitUntilSuccessCondition = {
	_ret = false;
	private _barrels = (_man1 nearEntities [fuelbarrel_typename, 20]) select {
		isNil {_x getVariable "R3F_LOG_objets_charges"} &&
		!(_x getVariable ['R3F_LOG_disabled', false])
	};
	if (count _barrels == 3) then {
		{ deleteVehicle _x } forEach _barrels;
		sleep 1;
		private _bonus = round (32 + random 10);
		private _winner = ([_man1, 30] call F_getNearbyPlayers) select 0;
		if (!isNil "_winner") then {
			[_bonus] remoteExec ["remote_call_a3w_info", owner _winner];
			[_winner, _bonus] call F_addScore;
		};
		_ret = true;
	};
	_ret;
 };

_failedExec = {
	// Mission failed
	{ [_x, -2] call F_addReput } forEach (AllPlayers - (entities "HeadlessClient_F"));
	deleteVehicle _man1;
	deleteMarker _marker_mission;
	_failedHintMessage = ["STR_FUELDELI_MESSAGE2", sideMissionColor, _townName];
	A3W_delivery_failed = A3W_delivery_failed + 1;
};

_successExec = {
	sleep 3;
	// Mission completed
	private _winner = ([_man1, 50] call F_getNearbyPlayers) select 0;
	if (!isNil "_winner") then { [_winner, 5] call F_addReput };
	_successHintMessage = ["STR_FUELDELI_MESSAGE3", sideMissionColor];
	deleteVehicle _man1;
	deleteMarker _marker_mission;
	A3W_delivery_failed = 0;
};

_this call sideMissionProcessor;
