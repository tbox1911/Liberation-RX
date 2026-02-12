if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_intels", "_managed_units", "_grp_civ1", "_grp_civ2"];

_setupVars = {
	_missionType = "STR_SEARCH_INTEL";
	_locationsArray = [SpawnMissionMarkers] call checkSpawn;
	_ignoreAiDeaths = true;
};

_setupObjects = {
	_missionPos = [(markerpos _missionLocation), 5, 0] call F_findRandomPlace;
	if (count _missionPos == 0) exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
    	false;
	};

	private _buildings = [
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

	private _wrecks = [
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

	private _skel = [
		"Land_HumanSkull_F",
		"Land_HumanSkeleton_F",
		"Land_DeerSkeleton_full_01_F",
		"Land_DeerSkeleton_damaged_01_F",
		"Land_DeerSkeleton_pile_01_F",
		"Land_HumanSkull_F",
		"Land_HumanSkeleton_F"
	];

	private _statues = [
		"Land_Statue_03_F",
		"Land_Maroula_F",
		"Land_Statue_01_F",
		"Land_Statue_02_F"
	];

	//----- build village ---------------------------------
	_missionPos = ([_missionPos, 100] call F_getRandomPos);
	_vehicle = createVehicle [selectRandom _statues, _missionPos, [], 1, "None"];
	_vehicle setVariable ["R3F_LOG_disabled", true, true];

	private _build_list  = [];
	private ["_pos", "_dir"];
	for "_i" from 1 to 5 do {
		_pos = [getPosATL _vehicle, 20, 0, 150] call F_findSafePlace;
		if (count _pos > 0) then {
			_dir = random 360;
			_build = createVehicle [selectRandom _buildings, _pos, [], 1, "None"];
			_build setVectorDirAndUp [[-cos _dir, sin _dir, 0] vectorCrossProduct surfaceNormal _pos, surfaceNormal _pos];
			_build_list pushBack _build;
		};
		sleep 0.2;
	};
	if (count _build_list < 3) exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot create buildings at %2!", localize _missionType, _missionPos];
    	false;
	};
	private _vrac_list = [];
	for "_i" from 1 to 7 do {
		_pos = (getPosATL (selectRandom _build_list)) findEmptyPosition [10, 50, "B_Heli_Transport_01_F"];
		if (count _pos == 3) then {
			_wreck = createVehicle [selectRandom _wrecks, _pos, [], 1, "None"];
			_dir = random 360;
			_wreck setVectorDirAndUp [[-cos _dir, sin _dir, 0] vectorCrossProduct surfaceNormal _pos, surfaceNormal _pos];
			_wreck enableSimulationGlobal false;
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
		_wreck enableSimulationGlobal false;
		_vrac_list pushBack _wreck;
		sleep 0.2;
	};

	//----- spawn intels ---------------------------------
	_intels = [getPosATL (_build_list select 0)] call manage_intels;
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach (_build_list + _vrac_list + _intels);
	_vehicles =  _build_list + _vrac_list;
	sleep 0.5;

	//----- spawn units ---------------------------------
	_managed_units = (["infantry", ([] call getNbUnits), _missionPos] call F_buildingSquad);
	sleep 0.5;

	//----- spawn civilians ---------------------------------
	_grp_civ1 = [_missionPos, 3] call F_spawnCivilians;
	[_grp_civ1, _missionPos] spawn add_civ_waypoints;
	sleep 0.5;
	_grp_civ2 = [_missionPos, 3] call F_spawnCivilians;
	[_grp_civ2, _missionPos] spawn add_civ_waypoints;
	sleep 0.5;

	//----- spawn mines ---------------------------------
	[_missionPos, 30] call createlandmines;

	//_missionPicture = getText (configFile >> "CfgVehicles" >> "Land_i_Barracks_V1_F" >> "picture");
	_missionHintText = ["STR_SEARCH_INTEL_MESSAGE1", count _intels]; ;
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilSuccessCondition = { (count (_intels select { alive _x }) == 0) };

_waitUntilCondition = {
	private _ret = false;
	private _grp = group (_managed_units select 0);
	{
		if (_grp knowsAbout _x == 4) then { _ret = true };
	} forEach ([_missionPos, GRLIB_sector_size] call F_getNearbyPlayers);

	if (_ret) then {
		private _sound = "A3\data_f_curator\sound\cfgsounds\air_raid.wss";
		if (GRLIB_alarms_enabled) then {
			playSound3D [_sound, _missionPos, false, ATLToASL _missionPos, 5, 1, 1000];
		};
		sleep 5;
		private _msg = ["<t color='#FFFFFF' size='2'>You have been Detected!!<br/><br/>Enemies destroy the </t><t color='#ff0000' size='3'>INTELS</t><t color='#FFFFFF' size='2'> !!</t>", "PLAIN", -1, false, true];
		{
			[_msg] remoteExec ["titleText", owner _x];
		} forEach ([_missionPos, GRLIB_sector_size] call F_getNearbyPlayers);
		sleep 5;
		if (GRLIB_alarms_enabled) then {
			playSound3D [_sound, _missionPos, false, ATLToASL _missionPos, 5, 1, 1000];
		};
	};
	_ret;
};

_failedExec = {
	// Mission failed
	{ deleteVehicle _x } forEach _intels;
	{ deleteVehicle _x } forEach (units _grp_civ1) + (units _grp_civ2);
	{ deleteVehicle _x } forEach _managed_units;
	[_missionPos] call clearlandmines;
};

_successExec = {
	// Mission completed
	private _rwd_xp = round (15 + random 30);
	private _text = format ["Reward Received: %1 XP", _rwd_xp];
	{
		[_x, _rwd_xp] call F_addScore;
		[gamelogic, _text] remoteExec ["globalChat", owner _x];
	} forEach ([_missionPos, GRLIB_sector_size] call F_getNearbyPlayers);

	_successHintMessage = "STR_SEARCH_INTEL_MESSAGE2";
	{ deleteVehicle _x } forEach (units _grp_civ1) + (units _grp_civ2);
	{ deleteVehicle _x } forEach _managed_units;
	[_missionPos] spawn {
		params ["_pos"];
		[_pos] call showlandmines;
		sleep 300;
		[_pos] call clearlandmines;
	};
};

_this call sideMissionProcessor;
