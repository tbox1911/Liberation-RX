if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_vehicleName", "_smoke"];

_setupVars = {
	_missionType = "STR_VEHICLECAP";
	_locationsArray = [SpawnMissionMarkers] call checkSpawn;
	_nbUnits = [] call getNbUnits;
	_missionTimeout = (30 * 60);
};

_setupObjects = {
	_missionPos = [(markerpos _missionLocation), 5, 0] call F_findRandomPlace;
	if (count _missionPos == 0) exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
    	false;
	};
	_vehicle = [_missionPos, selectRandom opfor_vehicles, 5, GRLIB_side_enemy, "", false, true] call F_libSpawnVehicle;
	[_vehicle, "lock", "server"] call F_vehicleLock;
	_vehicle setFuel 0.1;
	_vehicle setVehicleAmmo 0.1;
	_vehicle setHitPointDamage ["HitEngine", 1, false];
	_smoke = GRLIB_sar_fire createVehicle (getPos _vehicle);
	_smoke attachTo [_vehicle, [0, 1.5, 0]];
	[_missionPos, 30] call createlandmines;
	_aiGroup = [_missionPos, _nbUnits, "infantry"] call createCustomGroup;
	_missionPicture = getText (configOf _vehicle >> "picture");
	_vehicleName = getText (configOf _vehicle >> "displayName");
	_missionHintText = ["STR_VEHICLECAP_MESSAGE1", _vehicleName, sideMissionColor];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = { !(alive _vehicle) };

_failedExec = {
	// Mission failed
	deleteVehicle _smoke;
	[_missionPos] call clearlandmines;
};

_successExec = {
	// Mission completed
	[_vehicle, "abandon"] call F_vehicleLock;
	deleteVehicle _smoke;
	_successHintMessage = ["STR_VEHICLECAP_MESSAGE2", _vehicleName];
	[_missionPos] spawn {
		params ["_pos"];
		[_pos] call showlandmines;
		sleep 300;
		[_pos] call clearlandmines;
	};
};

_this call sideMissionProcessor;
