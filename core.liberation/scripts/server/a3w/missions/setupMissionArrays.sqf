// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: setupMissionArrays.sqf
//	@file Author: AgentRev
//	LRX Integration: pSiKO

SideMissions = [
	// Mission filename, weight
	["mission_CaptureVIP", 1],
	["mission_SpecialDelivery", 1],
	["mission_AmmoDelivery", 1],
	["mission_WaterDelivery", 1],
	["mission_FoodDelivery", 1],
	["mission_FuelDelivery", 1],
	["mission_TownInvasion", 1],
	["mission_HostileHelicopter", 1],
	["mission_MeetResistance", 1],
	["mission_VehicleCapture", 1],
	["mission_HeliCapture", 1],
	["mission_Outpost", 1],
	["mission_RoadBlock", 1],
	["mission_SearchIntel", 1],
	["mission_KillOfficer", 1],
	["mission_BaronRouge", 1],
	["mission_HealCivilian", 1],
	["mission_PrisonerConvoy", 1],
	["mission_RessourceConvoy", 1],
	["mission_KillBandits", 1],
	["mission_RepairVehicle", 1],
	["mission_DefendPatrol", 1],
	["mission_FreeHostages", 1]
];

A3W_mission_sectors = [];
A3W_mission_sectors = sectors_opforSpawn + (allMapMarkers select {["Mission_", _x] call F_startsWith});
SpawnMissionMarkers = A3W_mission_sectors apply {[_x, false, 0]};
ForestMissionMarkers = (allMapMarkers select {["ForestMission_", _x] call F_startsWith}) apply {[_x, false, 0]};
SunkenMissionMarkers = (allMapMarkers select {["SunkenMission_", _x] call F_startsWith}) apply {[_x, false, 0]};

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

LRX_MissionMarkersCap = sectors_capture apply {[_x, false, 0]};
LRX_MissionMarkersMil = sectors_military apply {[_x, false, 0]};
