if (!isServer) exitwith {};
if (!isNil "GRLIB_A3W_Mission_SD") exitWith {};
#include "sideMissionDefines.sqf"

private ["_missionEnd", "_house", "_quest_item"];

_setupVars =
{
	_missionType = "STR_SPECIALDELI";
	_ignoreAiDeaths = true;
	_locationsArray = [SpawnMissionMarkers] call checkSpawn;
};

_setupObjects =
{
	_missionEnd = [(markerpos _missionLocation)] call F_findSafePlace;
	if (count _missionEnd == 0) exitWith { 
    	diag_log format ["--- LRX Error: side mission SD, cannot find spawn point!"];
    	false;
	};	

	private _convoy_destinations = [];
	private _sector_list = [(blufor_sectors - sectors_tower)] call checkSpawn;
	private _max_try = 20;
	private _max_waypoints = 3;

	while { count _convoy_destinations < _max_waypoints && _max_try > 0} do {
		_start_pos = selectRandom _sector_list;
		_convoy_destinations = [_start_pos, 4000, _sector_list, _max_waypoints] call F_getSectorPath;
		_max_try = _max_try - 1;
	};

	if (count _convoy_destinations < _max_waypoints) exitWith {
		diag_log format ["--- LRX Error: side mission SD, cannot find path"];
		false;
	};
	
	_missionPos =  markerPos (_convoy_destinations select 0) getPos [100, random 360];
	_missionPos2 = markerPos (_convoy_destinations select 1) getPos [100, random 360];
	_missionPos3 = markerPos (_convoy_destinations select 2) getPos [100, random 360];

	// create units
	private _mission_grp = createGroup [GRLIB_side_civilian, true];
	private _man1 = _mission_grp createUnit ["C_Nikos", _missionPos, [], 0, "NONE"];
	_man1 allowDamage false;
	_man1 setVariable ["acex_headless_blacklist", true, true];
	_man1 setVariable ["GRLIB_A3W_Mission_SD1", true, true];
	_man1 setVariable ['GRLIB_can_speak', true, true];
	[_man1, "LHD_krajPaluby"] spawn F_startAnimMP;

	_quest_item = createVehicle [a3w_sd_item, getPosATL _man1, [], 1, "NONE"];
	_quest_item allowDamage false;

	private _man2 = _mission_grp createUnit ["C_Orestes", _missionPos2, [], 0, "NONE"];
	_man2 allowDamage false;
	_man2 setVariable ["acex_headless_blacklist", true, true];
	_man2 setVariable ["GRLIB_A3W_Mission_SD2", true, true];
	_man2 setVariable ['GRLIB_can_speak', true, true];
	[_man2, "LHD_krajPaluby"] spawn F_startAnimMP;

	private _man3 = _mission_grp createUnit ["C_Orestes", _missionPos3, [], 0, "NONE"];
	_man3 allowDamage false;
	_man3 setVariable ["acex_headless_blacklist", true, true];
	_man3 setVariable ["GRLIB_A3W_Mission_SD3", true, true];
	_man3 setVariable ['GRLIB_can_speak', true, true];
	[_man3, "LHD_krajPaluby"] spawn F_startAnimMP;

	// create final house
	_house = createVehicle ["Land_i_House_Small_01_V1_F", _missionEnd, [], 2, "None"];
	_house setVectorDirAndUp [[0, 0, 0] vectorCrossProduct surfaceNormal _missionEnd, surfaceNormal _missionEnd];

	private _man4 = _mission_grp createUnit ["C_Nikos_aged", _missionEnd, [], 0, "NONE"];
	_man4 setVariable ["acex_headless_blacklist", true, true];
	_man4 allowDamage false;
	_man4 setVariable ["GRLIB_A3W_Mission_SD4", true, true];
	_man4 setVariable ['GRLIB_can_speak', true, true];
	[_man4, "LHD_krajPaluby"] spawn F_startAnimMP;
	_man4 setPosATL (getposATL _house);
	//_man4 enableAI "Cover";

	GRLIB_A3W_Mission_SD = [0, [_man1, _man2, _man3, _man4]];  // progression
	publicVariable "GRLIB_A3W_Mission_SD";

	_vehicle = _house;
	_missionPicture = getText (configFile >> "CfgVehicles" >> "C_Hatchback_01_F" >> "picture");
	_missionHintText = ["STR_SPECIALDELI_MESSAGE1", sideMissionColor, markerText _missionLocation];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = { !alive _quest_item };
_waitUntilSuccessCondition = { ((GRLIB_A3W_Mission_SD select 0) == -1) };

_failedExec = {
	// Mission failed
	{ [_x, -3] call F_addReput } forEach (AllPlayers - (entities "HeadlessClient_F"));
	["GRLIB_A3W_Mission_SD_Marker"] remoteExec ["GRLIB_A3W_Mission_SD_Marker", 0];
	{ deleteVehicle _x} forEach [_quest_item] + (GRLIB_A3W_Mission_SD select 1);
	GRLIB_A3W_Mission_SD = nil;
	publicVariable "GRLIB_A3W_Mission_SD";
	_failedHintMessage = ["STR_SPECIALDELI_MESSAGE2", sideMissionColor];
};

_successExec = {
	// Mission completed
	{ [_x, 7] call F_addReput } forEach ([_quest_item, 10] call F_getNearbyPlayers);
	["GRLIB_A3W_Mission_SD_Marker"] remoteExec ["GRLIB_A3W_Mission_SD_Marker", 0];
	{ deleteVehicle _x} forEach [_quest_item] + (GRLIB_A3W_Mission_SD select 1);
	GRLIB_A3W_Mission_SD = nil;
	publicVariable "GRLIB_A3W_Mission_SD";	
	_successHintMessage = ["STR_SPECIALDELI_MESSAGE3", sideMissionColor];

	for "_i" from 1 to (selectRandom [1,2]) do {
		[ammobox_i_typename, _missionEnd, false] call boxSetup;
		sleep 0.2;
	};
};

_this call sideMissionProcessor;
