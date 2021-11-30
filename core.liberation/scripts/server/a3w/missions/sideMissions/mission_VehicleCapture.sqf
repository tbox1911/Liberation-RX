// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_VehicleCapture.sqf

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_vehicle", "_vehicleName", "_vehiclePos", "_smoke"];

_setupVars =
{
	_missionType = "Vehicle Capture";
	_locationsArray = SpawnMissionMarkers;
	_nbUnits = [] call getNbUnits;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_vehiclePos = _missionPos vectorAdd ([[25 + floor(random 20), 0, 0], random 360] call BIS_fnc_rotateVector2D);

	// Class, Position, Fuel, Ammo, Damage, Special
	_vehicle = createVehicle [ (selectRandom opfor_vehicles), _vehiclePos, [], 0, "NONE"];
	_vehicle setVariable ["R3F_LOG_disabled", true, true];
	_vehicle setVariable ["GRLIB_vehicle_owner", "server", true];
	_vehicle setVehicleLock "LOCKED";
	_vehicle setFuel 0.1;
	_vehicle setVehicleAmmo 0.1;
	_vehicle setHit ["motor", 1];
	_smoke = "test_EmptyObjectForSmoke" createVehicle _vehiclePos;
	_smoke attachTo [_vehicle, [0, 1.5, 0]];

	[_missionPos, 25] call createlandmines;
	_aiGroup = createGroup [GRLIB_side_enemy, true];
	[_aiGroup, _missionPos, _nbUnits, "infantry"] call createCustomGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >>  (typeOf _vehicle) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >>  (typeOf _vehicle) >> "displayName");
	_missionHintText = format ["A <t color='%2'>%1</t> has been immobilized, go get it for your team!", _vehicleName, sideMissionColor];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec = {
	// Mission failed
	deleteVehicle _vehicle;
	deleteVehicle _smoke;
	[_missionPos] call clearlandmines;
};

_successExec = {
	// Mission completed
	_vehicle setVariable ["R3F_LOG_disabled", false, true];
	_vehicle setVariable ["GRLIB_vehicle_owner", nil, true];
	_vehicle setVehicleLock "UNLOCKED";
	deleteVehicle _smoke;
	_successHintMessage = format ["The %1 has been captured, well done.", _vehicleName];
	[_missionPos] call showlandmines;
};

_this call sideMissionProcessor;
