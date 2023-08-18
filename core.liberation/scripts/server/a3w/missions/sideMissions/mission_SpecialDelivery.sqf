// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_SpecialDelivery.sqf

if (!isServer) exitwith {};
if (!isNil "GRLIB_A3W_Mission_SD") exitWith {};
#include "sideMissionDefines.sqf"

private ["_missionPosEnd", "_missionStart", "_house"];

_setupVars =
{
	_missionType = "STR_SPECIALDELI";
	_ignoreAiDeaths = true;
	_locationsArray = nil;
};

_setupObjects =
{
	private _missionPos2 = [];
	private _missionPos3 = [];

	private _missionEnd = selectRandom ([SpawnMissionMarkers, { ([markerpos _x, false] call F_getNearestBluforObjective) select 1 > GRLIB_sector_size }] call BIS_fnc_conditionalSelect) select 0;
	if (!isNil "_missionEnd") then {	
		private _missionLocationList = [blufor_sectors, { (_x in sectors_capture) && (markerpos _x) distance2D (markerpos _missionEnd) < (GRLIB_spawn_max*2) }] call BIS_fnc_conditionalSelect;
		if (count _missionLocationList >= 3) then {
			private _m1 = selectRandom _missionLocationList;
			_missionPos = (markerpos _m1) getPos [100, random 360];
			_missionStart = _m1;
			_missionLocationList = _missionLocationList - [ _m1 ];
			_m1 = selectRandom _missionLocationList;
			_missionPos2 = (markerpos _m1) getPos [100, random 360];
			_missionLocationList = _missionLocationList - [ _m1 ];
			_m1 = selectRandom _missionLocationList;
			_missionPos3 = (markerpos _m1) getPos [100, random 360];
			_missionPosEnd = (markerpos _missionEnd);
		};
	};

	if (isnil "_missionPos" || isnil "_missionPos2" || isnil "_missionPos3" || isnil "_missionPosEnd") exitWith {
		diag_log format ["--- LRX Error: side mission SD, cannot find location from marker %1", _missionEnd];
		GRLIB_A3W_Mission_SD = [];
		publicVariable "GRLIB_A3W_Mission_SD";
		false;
	};

	// create Nikos units
	private _mission_grp = createGroup [GRLIB_side_civilian, true];
	private _man1 = _mission_grp createUnit ["C_Nikos", _missionPos, [], 0, "NONE"];
	private _man2 = _mission_grp createUnit ["C_Orestes", _missionPos2, [], 0, "NONE"];
	private _man3 = _mission_grp createUnit ["C_Orestes", _missionPos3, [], 0, "NONE"];
	private _man4 = _mission_grp createUnit ["C_Nikos_aged", _missionPosEnd, [], 0, "NONE"];

	GRLIB_A3W_Mission_SD = [_man1, _man2, _man3, _man4];
	publicVariable "GRLIB_A3W_Mission_SD";

	{
		_x setVariable ['GRLIB_can_speak', true, true];
		_x setVariable ['GRLIB_A3W_Mission_SD', true, true];
		_x setVariable ["acex_headless_blacklist", true];
		_x allowDamage false;
		[_x, "LHD_krajPaluby"] spawn F_startAnimMP;
	} forEach GRLIB_A3W_Mission_SD;

	_man4 enableAI "Cover";
	_house = createVehicle ["Land_i_House_Small_01_V1_F", _missionPosEnd, [], 2, "None"];
	_house setVectorDirAndUp [[0, 0, 0] vectorCrossProduct surfaceNormal _missionPosEnd, surfaceNormal _missionPosEnd];
	_man4 setPosATL (getposATL _house);

	private _marker = createMarker ["side_mission_A3W_Mission_SD", _missionPosEnd];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "Empty";

	_missionPicture = getText (configFile >> "CfgVehicles" >> "C_Hatchback_01_F" >> "picture");
	_missionHintText = ["STR_SPECIALDELI_MESSAGE1", sideMissionColor, markerText _missionStart];	
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
		[ammobox_i_typename, _missionPosEnd, false] call boxSetup;
		sleep 0.2;
	};
};

_this call sideMissionProcessor;
