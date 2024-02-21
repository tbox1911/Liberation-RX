if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_vehicleName", "_smoke"];

_setupVars =
{
	_missionType = "STR_VEHICLECAP";
	_locationsArray = [SpawnMissionMarkers] call checkSpawn;
	_nbUnits = [] call getNbUnits;
};

_setupObjects =
{
	_missionPos = [(markerpos _missionLocation)] call F_findSafePlace;
	if (count _missionPos == 0) exitWith { 
    	diag_log format ["--- LRX Error: side mission VC, cannot find spawn point!"];
    	false;
	};
	_vehiclePos = _missionPos findEmptyPosition [1, 60, "B_Heli_Transport_03_unarmed_F"];
	_vehicle = [_vehiclePos, selectRandom opfor_vehicles, true, false, GRLIB_side_enemy, false] call F_libSpawnVehicle;
	[_vehicle, "lock", "server"] call F_vehicleLock;
	_vehicle setFuel 0.1;
	_vehicle setVehicleAmmo 0.1;
	_vehicle setHit [getText (configFile >> "cfgVehicles" >> (typeOf _vehicle) >> "HitPoints" >> "HitEngine" >> "name"), 1];
	_vehicle setDamage 0.15;
	_smoke = GRLIB_sar_fire createVehicle _vehiclePos;
	_smoke attachTo [_vehicle, [0, 1.5, 0]];
	[_missionPos, 30] call createlandmines;
	_aiGroup = [_missionPos, _nbUnits, "infantry"] call createCustomGroup;
	_missionPicture = getText (configOf _vehicle >> "picture");
	_vehicleName = getText (configOf _vehicle >> "displayName");
	_missionHintText = ["STR_VEHICLECAP_MESSAGE1", _vehicleName, sideMissionColor];
	A3W_sectors_in_use = A3W_sectors_in_use + [_missionLocation];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = { !(alive _vehicle) };

_failedExec = {
	// Mission failed
	deleteVehicle _smoke;
	[_missionPos] call clearlandmines;
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
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
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_this call sideMissionProcessor;
