// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Version: 1.0
//	@file Name: mission_SearchIntel.sqf

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_intels"];

_setupVars =
{
	_missionType = localize "STR_SEARCH_INTEL";
	_locationsArray = [SpawnMissionMarkers] call checkSpawn;
	_nbUnits = [] call getNbUnits;
};

_setupObjects =
{
	//_missionPos = (markerpos _missionLocation) getPos [100, random 360];
	_missionPos = (markerpos _missionLocation);

	_buildings = [
		"Land_i_Barracks_V1_F",
		"Land_i_Barracks_V2_F",
		"Land_u_Barracks_V2_F",
		"Land_GH_House_1_F",
		"Land_GH_House_2_F",
		"Land_u_Addon_02_V1_F",
		"Land_u_House_Small_01_V1_F",
		"Land_u_House_Small_02_V1_F",
		"Land_i_Stone_HouseSmall_V3_F"
	];

	_wrecks = [
		"Land_Wreck_UAZ_F",
		"Land_Wreck_Ural_F",
		"Land_Wreck_Truck_dropside_F",
		"Land_Wreck_Truck_F",
		"Land_Wreck_HMMWV_F",
		"Land_Wreck_Hunter_F",
		"Land_Wreck_Skodovka_F",
		"Land_V3S_wreck_F",
		"Land_Wreck_Van_F",
		"Land_Wreck_Car2_F",
		"Land_Wreck_Car3_F",
		"Land_Wreck_Car_F",
		"Land_Wreck_Offroad_F",
		"Land_Wreck_Offroad2_F"
	];

	_skel = [
		"Land_HumanSkull_F",
		"Land_HumanSkeleton_F",
		"Land_DeerSkeleton_full_01_F",
		"Land_DeerSkeleton_damaged_01_F",
		"Land_DeerSkeleton_pile_01_F",
		"Land_HumanSkull_F",
		"Land_HumanSkeleton_F"
	];

	_statue = [
		"Land_Statue_03_F",
		"Land_Maroula_F",
		"Land_Statue_01_F",
		"Land_Statue_02_F"
	];

	//----- build village ---------------------------------
	_statue = createVehicle [selectRandom _statue, _missionPos, [], 1, "None"];

	_build_list  = [];
	for "_i" from 1 to 5 do {
		_dir = random 360;
		_max = 100;
		_pos = [];
		while { count _pos == 0 && _max > 0 } do {
			_pos = _missionPos findEmptyPosition [20, 200, "B_Heli_Transport_01_F"];
			if (isOnRoad _missionPos || surfaceIsWater _missionPos) then {
				_pos = [];
			};
			_max = _max - 1;
			sleep 0.1;
		};
		if (count _pos == 3) then {
		_build = createVehicle [selectRandom _buildings, _pos, [], 1, "None"];
		_build setVectorDirAndUp [[-cos _dir, sin _dir, 0] vectorCrossProduct surfaceNormal _pos, surfaceNormal _pos];
		_build_list pushBack _build;
		sleep 0.2;
		};
	};
	if (count _build_list < 3) exitWith { false };

	_vrac_list = [];
	for "_i" from 1 to 7 do {
		_pos = (getPosATL (selectRandom _build_list)) findEmptyPosition [10, 50, "B_Heli_Transport_01_F"];
		if (count _pos == 3) then {
			_wreck = createVehicle [selectRandom _wrecks, _pos, [], 1, "None"];
			_dir = random 360;
			_wreck setVectorDirAndUp [[-cos _dir, sin _dir, 0] vectorCrossProduct surfaceNormal _pos, surfaceNormal _pos];
			_vrac_list pushBack _wreck;
			sleep 0.2;
		};
	};

	for "_i" from 1 to 8 do {
		_lamp = createVehicle ["Land_LampStreet_02_triple_F", (getPosATL (selectRandom _build_list)), [], 15, "None"];
		_lamp setDir (random 360);
		_vrac_list pushBack _lamp;
		sleep 0.2;
	};

	for "_i" from 1 to 10 do {
		_wreck = createVehicle [selectRandom _skel, (getPosATL (selectRandom _build_list)), [], 30, "None"];
		_wreck setDir (random 360);
		_vrac_list pushBack _wreck;
		sleep 0.2;
	};

	//----- spawn intels ---------------------------------
	_intels = [getPosATL (_build_list select 0)] call manage_intels;
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach ([_statue] + _build_list + _vrac_list);
	_vehicles =  [_statue] + _build_list + _vrac_list + _intels;
	sleep 0.5;

	//----- spawn units ---------------------------------
	_allbuildings = [ nearestObjects [_missionPos, ["House"], 200 ], { alive _x } ] call BIS_fnc_conditionalSelect;
	_buildingpositions = [];
	{
		_buildingpositions = _buildingpositions + ([_x] call BIS_fnc_buildingPositions);
	} foreach _allbuildings;

	_nbUnits = [] call getNbUnits;
	_managed_units = (["infantry", _nbUnits, _buildingpositions, _missionPos] call F_spawnBuildingSquad);
	_aiGroup = group (_managed_units select 0);
	{
		_x setSkill 0.70;
		_x setSkill ["courage", 1];
		_x allowFleeing 0;
		_x setVariable ["GRLIB_mission_AI", true, true];
	} forEach (units _aiGroup);

	[_missionPos, 30] call createlandmines;

	//_missionPicture = getText (configFile >> "CfgVehicles" >> "Land_i_Barracks_V1_F" >> "picture");
	_missionHintText = format [localize "STR_SEARCH_INTEL_MESSAGE1", count _intels]; ;
	A3W_sectors_in_use = A3W_sectors_in_use + [_missionLocation];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilSuccessCondition = {
	_ret = false;
	_intel_left = count (_intels select { alive _x });
	if (_intel_left == 0) then { _ret = true };
	_ret;
};

_waitUntilCondition = {
	_ret = false;
	{
		if (_x distance2D _missionPos < GRLIB_capture_size) then {
			if (_aiGroup knowsAbout _x == 4 ) then {
				_msg = ["<t color='#FFFFFF' size='2'>You have been Detected!!<br/><br/>Enemies destroy the </t><t color='#ff0000' size='3'>INTELS</t><t color='#FFFFFF' size='2'> !!</t>", "PLAIN", -1, false, true];
				[_msg] remoteExec ["titleText", owner _x];
				sleep 10;
				_ret = true;
			};
		};
	} forEach (AllPlayers - (entities "HeadlessClient_F"));
	_ret;
};

_failedExec = {
	// Mission failed
	[_missionPos] call clearlandmines;
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_successExec = {
	// Mission completed
	private _rwd_xp = round (15 + random 30);
	private _text = format ["Reward Received: %1 XP", _rwd_xp];
	{
		if (_x distance2D _missionPos < GRLIB_capture_size) then {
			[_x, _rwd_xp] call F_addScore;
			[gamelogic, _text] remoteExec ["globalChat", owner _x];
		};
	} forEach (AllPlayers - (entities "HeadlessClient_F"));

	_successHintMessage = localize "STR_SEARCH_INTEL_MESSAGE2";
	[_missionPos] call showlandmines;
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_this call sideMissionProcessor;
