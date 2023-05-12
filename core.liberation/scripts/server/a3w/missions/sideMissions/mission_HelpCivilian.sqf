// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_helpCivilian.sqf

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_outpost", "_objects"];

_setupVars =
{
	_missionType = "Help Civilians";
	_locationsArray = MissionSpawnMarkers;
	_nbUnits = AI_GROUP_MEDIUM;
};

_setupObjects =
{
	_missionPos = ([markerPos _missionLocation, 100, random 360] call BIS_fnc_relPos);

	//_missionHintText = format ["An armed <t color='%1'>outpost</t> containing weapon crates has been spotted near the marker, go capture it!", sideMissionColor]
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec =
{
	// Mission failed
	//{ deleteVehicle _x } forEach _objects;
};

_successExec =
{
	// Mission complete

	_successHintMessage = "All the civilians has been helped, good work.";
};

_this call sideMissionProcessor;
