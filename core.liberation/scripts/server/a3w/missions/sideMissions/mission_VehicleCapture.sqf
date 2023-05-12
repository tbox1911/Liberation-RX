// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_VehicleCapture.sqf

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_vehicleName", "_vehiclePos", "_smoke"];

_setupVars =
{
	_missionType = localize "STR_VEHICLECAP";
	_locationsArray = [SpawnMissionMarkers] call checkSpawn;
	_nbUnits = [] call getNbUnits;
};

_setupObjects =
{
	_missionPos = ([markerPos _missionLocation, 100, random 360] call BIS_fnc_relPos);
	_vehiclePos = _missionPos findEmptyPosition [1, 60, "B_Heli_Transport_03_unarmed_F"];
	_vehicle = [_vehiclePos, selectRandom opfor_vehicles, true, false, true] call F_libSpawnVehicle;
	_vehicle setVariable ["R3F_LOG_disabled", true, true];
	_vehicle setVariable ["GRLIB_vehicle_owner", "server", true];
	_vehicle setVehicleLock "LOCKED";
	_vehicle setFuel 0.1;
	_vehicle setVehicleAmmo 0.1;
	_vehicle setHit [getText (configFile >> "cfgVehicles" >> (typeOf _vehicle) >> "HitPoints" >> "HitEngine" >> "name"), 1];
	_smoke = "test_EmptyObjectForSmoke" createVehicle _vehiclePos;
	_smoke attachTo [_vehicle, [0, 1.5, 0]];

	[_missionPos, 30] call createlandmines;
	_aiGroup = createGroup [GRLIB_side_enemy, true];
	[_aiGroup, _missionPos, _nbUnits, "infantry"] call createCustomGroup;

	_missionPicture = getText (configOf _vehicle >> "picture");
	_vehicleName = getText (configOf _vehicle >> "displayName");
	_missionHintText = format [localize "STR_VEHICLECAP_MESSAGE1", _vehicleName, sideMissionColor];
	A3W_sectors_in_use = A3W_sectors_in_use + [_missionLocation];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = {!(alive _vehicle)};

_failedExec = {
	// Mission failed
	deleteVehicle _smoke;
	[_missionPos] call clearlandmines;
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_successExec = {
	// Mission completed
	_vehicle setVariable ["GRLIB_vehicle_owner", nil, true];
	_vehicle setVehicleLock "UNLOCKED";
	deleteVehicle _smoke;
	_successHintMessage = format [localize "STR_VEHICLECAP_MESSAGE2", _vehicleName];
	[_missionPos] call showlandmines;
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_this call sideMissionProcessor;
