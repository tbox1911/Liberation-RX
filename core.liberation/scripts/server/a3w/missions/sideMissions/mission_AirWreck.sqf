// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_AirWreck.sqf

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_wreckPos", "_box1", "_box2", "_box3"];

_setupVars =
{
	_missionType = "Aircraft Wreck";
	_locationsArray = [SpawnMissionMarkers] call checkSpawn;
	_nbUnits = [] call getNbUnits;
};

_setupObjects =
{
	_missionPos = markerPos _missionLocation;
	_wreckPos = _missionPos vectorAdd ([[5 + floor(random 20), 0, 0], random 360] call BIS_fnc_rotateVector2D);
	_vehicle = createVehicle [GRLIB_sar_wreck, _wreckPos, [], 0, "NONE"];
	_vehicle setpos (getpos _vehicle);
	_box1 = [ammobox_b_typename, _missionPos, true] call boxSetup;
	_box2 = [ammobox_b_typename, _missionPos, true] call boxSetup;
	_box3 = [A3W_BoxWps, _missionPos, true] call boxSetup;

	[_missionPos, 30] call createlandmines;
	_aiGroup = createGroup [GRLIB_side_enemy, true];
	[_aiGroup, _missionPos, _nbUnits, "infantry"] call createCustomGroup;

	_missionPicture = "\A3\Air_F\Heli_Light_02\Data\UI\Heli_Light_02_CA.paa";
	_missionHintText = "A helicopter has come down under enemy fire!";
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
	{
		_x setVariable ["R3F_LOG_disabled", false, true];
		_x setVariable ["GRLIB_vehicle_owner", nil, true];
	} forEach [_box1, _box2, _box3];

	_successHintMessage = "The airwreck supplies have been collected, well done.";
	[_missionPos] call showlandmines;

};

_this call sideMissionProcessor;
