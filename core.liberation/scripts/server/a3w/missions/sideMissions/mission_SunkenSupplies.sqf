// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_SunkenSupplies.sqf

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_box1", "_box2", "_vehicle", "_boxPos", "_aiGroup", "_unit"];

_setupVars =
{
	_missionType = "Sunken Supplies";
	_locationsArray = [SunkenMissionMarkers] call checkSpawn;
	_nbUnits = [] call getNbUnits;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_box1 = [ammobox_o_typename, _missionPos, true] call boxSetup;
	_box2 = [ammobox_o_typename, _missionPos, true] call boxSetup;
	_vehicle = [_missionPos, "O_Boat_Armed_01_hmg_F", true] call F_libSpawnVehicle;
	_aiGroup = createGroup [GRLIB_side_enemy, true];
	[_aiGroup, _missionPos, _nbUnits, "divers", false] call createCustomGroup;
	(crew _vehicle) joinSilent _aiGroup;

	private _patrolcorners = [
		[ (_missionPos select 0) - 60, (_missionPos select 1) - 60, 0 ],
		[ (_missionPos select 0) + 60, (_missionPos select 1) - 60, 0 ],
		[ (_missionPos select 0) + 60, (_missionPos select 1) + 60, 0 ],
		[ (_missionPos select 0) - 60, (_missionPos select 1) + 60, 0 ]
	];

	while {(count (waypoints _aiGroup)) != 0} do {deleteWaypoint ((waypoints _aiGroup) select 0);};
	{
		_waypoint = _aiGroup addWaypoint [_x ,0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointSpeed "LIMITED";
		_waypoint setWaypointBehaviour "SAFE";
		_waypoint setWaypointCompletionRadius 5;
	} foreach _patrolcorners;

	_waypoint = _aiGroup addWaypoint [(_patrolcorners select 0), 0];
	_waypoint setWaypointType "CYCLE";
	{_x doFollow (leader _aiGroup)} foreach units _aiGroup;

	_missionPicture = getText (configFile >> "CfgVehicles" >> "O_Boat_Armed_01_hmg_F" >> "picture");
	_missionHintText = "Sunken supplies have been spotted in the ocean near the marker, and are heavily guarded. Diving gear and an underwater weapon are recommended.";
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec = {
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _vehicle];
};

_successExec = {
	// Mission completed
	{
		_x setVariable ["R3F_LOG_disabled", false, true];
		_x setVariable ["GRLIB_vehicle_owner", nil, true];
	} forEach [_box1, _box2];
	_successHintMessage = "The sunken supplies have been collected, well done.";
};

_this call sideMissionProcessor;
