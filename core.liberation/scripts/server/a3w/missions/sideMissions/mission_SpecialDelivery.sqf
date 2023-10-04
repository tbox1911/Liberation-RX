// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_SpecialDelivery.sqf

if (!isServer) exitwith {};
if (!isNil "GRLIB_A3W_Mission_SD") exitWith {};
#include "sideMissionDefines.sqf"

private ["_missionEnd", "_house"];

_setupVars =
{
	_missionType = "STR_SPECIALDELI";
	_ignoreAiDeaths = true;
	_locationsArray = [SpawnMissionMarkers] call checkSpawn;
};

_setupObjects =
{
	_missionEnd = (markerPos _missionLocation) getPos [100, random 360];

	private _convoy_destinations = [];
	private _sector_list = (blufor_sectors - sectors_tower);
	private _max_try = 20;
	private _max_waypoints = 3;

	while { count _convoy_destinations < _max_waypoints && _max_try > 0} do {
		_start_pos = selectRandom _sector_list;
		_convoy_destinations = [_start_pos, 4000, _sector_list, _max_waypoints] call F_getSectorPath;
		_max_try = _max_try - 1;
	};

	if (count _convoy_destinations < _max_waypoints) exitWith { 
		diag_log format ["--- LRX Error: side mission SD, cannot find path"];
		GRLIB_A3W_Mission_SD = [];
		publicVariable "GRLIB_A3W_Mission_SD";
		false;
	};

	_missionPos =  markerPos (_convoy_destinations select 0) getPos [100, random 360];
	_missionPos2 = markerPos (_convoy_destinations select 1) getPos [100, random 360];
	_missionPos3 = markerPos (_convoy_destinations select 2) getPos [100, random 360];

	// create Nikos units
	private _mission_grp = createGroup [GRLIB_side_civilian, true];
	private _man1 = _mission_grp createUnit ["C_Nikos", _missionPos, [], 0, "NONE"];
	private _man2 = _mission_grp createUnit ["C_Orestes", _missionPos2, [], 0, "NONE"];
	private _man3 = _mission_grp createUnit ["C_Orestes", _missionPos3, [], 0, "NONE"];
	private _man4 = _mission_grp createUnit ["C_Nikos_aged", _missionEnd, [], 0, "NONE"];

	GRLIB_A3W_Mission_SD = [_man1, _man2, _man3, _man4];
	publicVariable "GRLIB_A3W_Mission_SD";

	{
		_x setVariable ['GRLIB_can_speak', true, true];
		_x setVariable ['GRLIB_A3W_Mission_SD', true, true];
		_x setVariable ["acex_headless_blacklist", true, true];
		_x allowDamage false;
		[_x, "LHD_krajPaluby"] spawn F_startAnimMP;
	} forEach GRLIB_A3W_Mission_SD;

	_man4 enableAI "Cover";
	_house = createVehicle ["Land_i_House_Small_01_V1_F", _missionEnd, [], 2, "None"];
	_house setVectorDirAndUp [[0, 0, 0] vectorCrossProduct surfaceNormal _missionEnd, surfaceNormal _missionEnd];
	_man4 setPosATL (getposATL _house);

	private _marker = createMarker ["side_mission_A3W_Mission_SD", _missionEnd];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "Empty";

	_missionPicture = getText (configFile >> "CfgVehicles" >> "C_Hatchback_01_F" >> "picture");
	_missionHintText = ["STR_SPECIALDELI_MESSAGE1", sideMissionColor, markerText _missionLocation];	
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = { count GRLIB_A3W_Mission_SD != 4 };

_waitUntilSuccessCondition = {
	_ret = false;
	if (!isnil "GRLIB_A3W_Mission_SD" && count GRLIB_A3W_Mission_SD == 4 ) then {
		_last_man = GRLIB_A3W_Mission_SD select (count GRLIB_A3W_Mission_SD) - 1;
		if (_last_man getVariable ["GRLIB_A3W_Mission_SD_END", false]) then { _ret = true};
	};
	_ret;
 };

_failedExec = {
	// Mission failed
	deleteMarker "side_mission_A3W_Mission_SD";
	if (!isNil "_house") then {deleteVehicle _house};
	{ deleteVehicle _x } forEach GRLIB_A3W_Mission_SD;
	GRLIB_A3W_Mission_SD = nil;
	GRLIB_A3W_Mission_SD_Spawn = nil;
	publicVariable "GRLIB_A3W_Mission_SD";
	[missionNamespace, ["GRLIB_A3W_Mission_Marker", nil]] remoteExec ["setVariable", -2];
	_failedHintMessage = ["STR_SPECIALDELI_MESSAGE2", sideMissionColor];
};

_successExec = {
	// Mission completed
	deleteMarker "side_mission_A3W_Mission_SD";
	[_house] spawn {
		params ["_house"];
		sleep 60;
		{ deleteVehicle _x } forEach GRLIB_A3W_Mission_SD;
		GRLIB_A3W_Mission_SD = nil;
		GRLIB_A3W_Mission_SD_Spawn = nil;
		publicVariable "GRLIB_A3W_Mission_SD";
		sleep 60;
		deleteVehicle _house;
	};
	_successHintMessage = ["STR_SPECIALDELI_MESSAGE3", sideMissionColor];

	for "_i" from 1 to (selectRandom [1,2]) do {
		[ammobox_i_typename, _missionEnd, false] call boxSetup;
		sleep 0.2;
	};
};

_this call sideMissionProcessor;
