if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_townName"];

_setupVars = {
	_missionType = "STR_INSURGENCY";
	_nbUnits = 16;
	// settings for this mission
	_missionLocation = [sectors_capture] call getMissionLocation;
	_townName = markerText _missionLocation;
	_locationsArray = nil;
	_missionTimeout = (30 * 60);
};

_setupObjects = {
	_missionPos = [(markerpos _missionLocation)] call F_findSafePlace;
	if (count _missionPos == 0) exitWith { 
    	diag_log format ["--- LRX Error: side mission TIns, cannot find spawn point!"];
    	false;
	};

	// spawn some enemies
	[_missionPos, 30] call createlandmines;
	[_missionLocation, 150, floor (random 6)] spawn ied_trap_manager;
	private _managed_units = (["militia", (_nbUnits - 4), _missionPos] call F_spawnBuildingSquad);
	_aiGroup = [_missionPos, (_nbUnits - (count _managed_units)), "militia"] call createCustomGroup;
	_managed_units joinSilent _aiGroup;
	{ _x setVariable ["GRLIB_mission_AI", false, true] } forEach (units _aiGroup);
	_missionHintText = ["STR_INSURGENCY_MESSAGE1", sideMissionColor, _townName];
	A3W_sectors_in_use = A3W_sectors_in_use + [_missionLocation];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = { !(_missionLocation in blufor_sectors) };

_failedExec = {
	// Mission failed
	{ [_x, -5] call F_addReput } forEach (AllPlayers - (entities "HeadlessClient_F"));
	_failedHintMessage = ["STR_INVASION_FAILED", sideMissionColor, _townName];
	[_missionPos] call clearlandmines;
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_successExec = {
	// Mission completed
	private _rwd_ammo = (100 + floor(random 100));
	private _rwd_fuel = (10 + floor(random 10));
	private _text = format ["Reward Received: %1 Ammo and %2 Fuel", _rwd_ammo, _rwd_fuel];
	{
		[_x, _rwd_ammo, _rwd_fuel] call ammo_add_remote_call;
		[_x, 10] call F_addReput;
		[gamelogic, _text] remoteExec ["globalChat", owner _x];
	} forEach ([_missionPos, GRLIB_capture_size] call F_getNearbyPlayers);

	_successHintMessage = ["STR_INSURGENCY_MESSAGE2", sideMissionColor, _townName];
	[_missionPos] spawn {
		params ["_pos"];
		[_pos] call showlandmines;
		sleep 300;
		[_pos] call clearlandmines;
	};
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_this call sideMissionProcessor;
