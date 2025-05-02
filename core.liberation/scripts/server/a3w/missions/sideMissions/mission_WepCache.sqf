if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_box1", "_box2", "_box3"];

_setupVars = {
	_missionType = "STR_WEAPCACHE";
	_locationsArray = [ForestMissionMarkers] call checkSpawn;
	_nbUnits = [] call getNbUnits;
	_precise_marker = false;
};

_setupObjects = {
	_missionPos = [(markerpos _missionLocation), 5, 0] call F_findSafePlace;
	if (count _missionPos == 0) exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
    	false;
	};
	_box1 = [ammobox_o_typename, _missionPos, true] call boxSetup;
	_box2 = [ammobox_o_typename, _missionPos, true] call boxSetup;
	_box3 = [basic_weapon_typename, _missionPos, true] call boxSetup;
	[_missionPos, 30] call createlandmines;
	_aiGroup = [_missionPos, _nbUnits, "infantry"] call createCustomGroup;
	_missionPicture = "\A3\Static_f_gamma\data\ui\gear_StaticTurret_GMG_CA.paa";
	_missionHintText = "STR_WEAPCACHE_MESSAGE1";
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec = {
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _box3];
	[_missionPos] call clearlandmines;
};

_successExec = {
	// Mission completed
	{ [_x, "abandon"] call F_vehicleLock } forEach [_box1, _box2, _box3];
	_successHintMessage = "STR_WEAPCACHE_MESSAGE2";
	[_missionPos] spawn {
		params ["_pos"];
		[_pos] call showlandmines;
		sleep 300;
		[_pos] call clearlandmines;
	};
};

_this call sideMissionProcessor;
