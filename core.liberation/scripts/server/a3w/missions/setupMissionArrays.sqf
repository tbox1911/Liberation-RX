// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: setupMissionArrays.sqf
//	@file Author: AgentRev
//	LRX Integration: pSiKO

if (!isServer) exitWith {};

SideMissions = [
	// Mission filename, weight
	["mission_SpecialDelivery", 1],
	["mission_WaterDelivery", 1],
	["mission_FoodDelivery", 1],
	["mission_FuelDelivery", 1],
	["mission_TownInvasion", 1],
	["mission_HostileHelicopter", 1],
	["mission_MeetResistance", 1],
	["mission_VehicleCapture", 1]
];

SpawnMissionMarkers = (allMapMarkers select {["Mission_", _x] call F_startsWith;}) apply {[_x, false]};
ForestMissionMarkers = (allMapMarkers select {["ForestMission_", _x] call F_startsWith;}) apply {[_x, false]};
SunkenMissionMarkers = (allMapMarkers select {["SunkenMission_", _x] call F_startsWith}) apply {[_x, false]};

// Filters BLU sectors
SpawnMissionMarkers = [SpawnMissionMarkers] call checkSpawn;
ForestMissionMarkers = [ForestMissionMarkers] call checkSpawn;
SunkenMissionMarkers = [SunkenMissionMarkers] call checkSpawn;

if !(ForestMissionMarkers isEqualTo []) then {
	SideMissions append
	[
		["mission_AirWreck", 1],
		["mission_WepCache", 1]
	];
};

if !(SunkenMissionMarkers isEqualTo []) then {
	SideMissions append
	[
		["mission_SunkenSupplies", 1]
	];
};

{ _x set [2, false] } forEach SideMissions;

GRLIB_A3W_Init = true;