// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_FuelDelivery.sqf

if (!isServer) exitwith {};
if (!isNil "GRLIB_A3W_Mission_MR") exitWith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_townName","_buildingpositions", "_man1", "_marker_zone"];

_setupVars =
{
	_missionType = localize "STR_FUELDELI";
	_missionLocation = [sectors_capture] call getMissionLocation;
	_townName = markerText _missionLocation;
	_ignoreAiDeaths = true;
	_locationsArray = nil;
};

_setupObjects =
{
	_missionPos = ([markerPos _missionLocation, 100, random 360] call BIS_fnc_relPos);
	_mission_grp = createGroup [GRLIB_side_civilian, true];
	_man1 = _mission_grp createUnit ["C_Marshal_F", _missionPos, [], 0, "NONE"];
	_man1 setVariable ['GRLIB_can_speak', true, true];
	_man1 setVariable ['GRLIB_A3W_Mission_DF', true, true];
	_man1 allowDamage false;
	[_man1, "LHD_krajPaluby"] spawn F_startAnimMP;
	_marker_zone = createMarker ["A3W_Mission_DF", _missionPos];
	_marker_zone setMarkerColor "ColorCivilian";
	_marker_zone setMarkerShape "ELLIPSE";
	_marker_zone setMarkerBrush "FDiagonal";
	_marker_zone setMarkerSize [20,20];

	_missionHintText = format [localize "STR_FUELDELI_MESSAGE1", sideMissionColor, _townName];
	A3W_sectors_in_use = A3W_sectors_in_use + [_missionLocation];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_waitUntilSuccessCondition = {
	_ret = false;
	private _barrels = [_man1 nearEntities [fuelbarrel_typename, 20], {isNil {_x getVariable "R3F_LOG_objets_charges"} && !(_x getVariable ['R3F_LOG_disabled', false])}] call BIS_fnc_conditionalSelect;
	if (count _barrels == 3) then {
		sleep 1;
		[_missionType, _man1] remoteExec ["remote_call_a3w_info", 0];
		{ deleteVehicle _x } forEach _barrels;
		_ret = true;
	};
	_ret;
 };

_failedExec = {
	// Mission failed
	deleteVehicle _man1;
	deleteMarker _marker_zone;
	_failedHintMessage = format [localize "STR_FUELDELI_MESSAGE2", sideMissionColor, _townName];
	A3W_delivery_failed = A3W_delivery_failed + 1;
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_successExec = {
	sleep 3;
	// Mission completed
	_successHintMessage = format [localize "STR_FUELDELI_MESSAGE3", sideMissionColor];
	deleteVehicle _man1;
	deleteMarker _marker_zone;
	A3W_delivery_failed = 0;
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_this call sideMissionProcessor;
