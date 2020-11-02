// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_WepCache.sqf
//	@file Author: [404] Deadbeat, [404] Costlyy, AgentRev
//	@file Created: 08/12/2012 15:19

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_box1", "_box2", "_box3"];

_setupVars =
{
	_missionType = "Weapon Cache";
	_locationsArray = ForestMissionMarkers;
	_nbUnits = [] call getNbUnits;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_box1 = [ammobox_o_typename, _missionPos, true] call boxSetup;
	_box2 = [A3W_BoxWps, _missionPos, true] call boxSetup;
	_box3 = [ammobox_o_typename, _missionPos, true] call boxSetup;

	_aiGroup = createGroup [GRLIB_side_enemy, true];
	[_aiGroup, _missionPos, _nbUnits, "infantry"] call createCustomGroup;
	[_missionPos, 25] call createlandmines;

	_missionPicture = "\A3\Static_f_gamma\data\ui\gear_StaticTurret_GMG_CA.paa";
	_missionHintText = "A weapon cache has been spotted near the marker.";
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
	{
		_x setVariable ["R3F_LOG_disabled", false, true];
		_x setVariable ["GRLIB_vehicle_owner", "", true];
	} forEach [_box1, _box2, _box3];
	_successHintMessage = "The supplies have been collected, well done.";
	[_missionPos] call showlandmines;
};

_this call sideMissionProcessor;
