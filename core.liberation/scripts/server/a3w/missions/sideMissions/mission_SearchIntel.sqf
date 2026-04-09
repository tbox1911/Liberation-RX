if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_intels", "_managed_units", "_grp_civ1", "_grp_civ2", "_mission_markers"];

_setupVars = {
	_missionType = "STR_SEARCH_INTEL";
	_locationsArray = [SpawnMissionMarkers] call checkSpawn;
	_ignoreAiDeaths = true;
};

_setupObjects = {
	private _all_possible_sectors = ([SpawnMissionMarkers] call checkSpawn) apply { _x select 0 };
	if (count _all_possible_sectors == 0) exitWith {
		diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
		false;
	};
	_missionPos = [_all_possible_sectors, 40] call F_findFlatPlace;
	if (count _missionPos == 0) exitWith {
		diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
		false;
	};

	private _buildings = [
		"Land_GH_House_1_F",
		"Land_GH_House_2_F",
		"Land_u_Addon_02_V1_F",
		"Land_u_House_Small_01_V1_F",
		"Land_i_House_Small_01_V2_F",
		"Land_i_House_Small_01_V3_F",
		"Land_u_House_Small_02_V1_F",
		"Land_i_House_Small_02_V1_F",
		"Land_i_House_Small_02_V2_F",
		"Land_i_House_Small_02_V3_F",
		"Land_i_Stone_HouseSmall_V3_F"
	];

	private _statues = [
		"Land_Statue_03_F",
		"Land_Maroula_F",
		"Land_Statue_01_F",
		"Land_Statue_02_F"
	];

	//----- build village ---------------------------------
	_vehicle = createVehicle [selectRandom _statues, _missionPos, [], 1, "None"];
	_vehicle setVariable ["R3F_LOG_disabled", true, true];
	private _town_center = getPosATL _vehicle;
	private _vrac_list = [];
	private _build_list = [];

	// Lamps
	private _lamp = createVehicle ["Land_LampStreet_02_triple_F", zeropos, [], 15, "None"];
	_lamp setPos ([_town_center, 3] call F_getRandomPos);
	_vrac_list pushBack _lamp;
	private _angle = 0;
	for "_i" from 1 to 7 do {
		_nextpos = (_town_center getPos [45, _angle]);
		_lamp = createVehicle ["Land_LampStreet_02_triple_F", zeropos, [], 15, "None"];
		_dir = floor random 360;
		_lamp setVectorDirAndUp [[sin _dir, cos _dir, 0], [0, 0, 1]];
		_lamp setPosATL _nextpos;
		_angle = _angle + 45;
		_vrac_list pushBack _lamp;
	};

	// Houses
	private ["_nextpos", "_dir"];
	private _angle = 0;
	for "_i" from 1 to 4 do {
		_nextpos = (_town_center getPos [35, _angle]);
		_nextpos = [_nextpos, 15, 0, 50] call F_findSafePlace;
		if (count _nextpos > 0) then {
			_dir = floor random 360;
			private _build = createVehicle [selectRandom _buildings, zeropos, [], 1, "None"];
			_build setVectorDirAndUp [[sin _dir, cos _dir, 0], [0, 0, 1]];
			_build setPosATL _nextpos;
			_build_list pushBack _build;
		};
		_angle = _angle + 90;
		sleep 0.1;
	};

	//----- spawn intels ---------------------------------
	_intels = [_town_center] call manage_intels;
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach (_build_list + _vrac_list + _intels);

	//----- spawn units ---------------------------------
	_managed_units = (["infantry", ([] call getNbUnits), _missionPos] call F_buildingSquad);

	//----- spawn civilians ---------------------------------
	_grp_civ1 = [_missionPos, 3] call F_spawnCivilians;
	[_grp_civ1, _missionPos] spawn add_civ_waypoints;
	_grp_civ2 = [_missionPos, 3] call F_spawnCivilians;
	[_grp_civ2, _missionPos] spawn add_civ_waypoints;

	//----- spawn mines ---------------------------------
	[_missionPos, 40] call createlandmines;
	_mission_markers = [];

	_vehicles = _build_list + _vrac_list;
	//_missionPicture = getText (configFile >> "CfgVehicles" >> "Land_i_Barracks_V1_F" >> "picture");
	_missionHintText = ["STR_SEARCH_INTEL_MESSAGE1", count _intels]; ;
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilSuccessCondition = { ({ alive _x } count _intels == 0) };

_waitUntilCondition = {
	private _ret = false;

	if ({ alive _x } count _managed_units == 0) then {
		{ deleteMarker _x } forEach _mission_markers;
		_mission_markers = [];
		{
			if (alive _x) then {
				private _marker = createMarkerLocal [format ["missionintel_%1", (_x call BIS_fnc_netId)], getPos _x];
				_marker setMarkerColorLocal "ColorOrange";
				_marker setMarkerType "loc_search";
				_mission_markers pushBack _marker;
			};
		} forEach _intels;
	};

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
	{ deleteMarker _x } forEach _mission_markers;
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
	{ deleteMarker _x } forEach _mission_markers;
	[_missionPos] spawn {
		params ["_pos"];
		[_pos] call showlandmines;
		sleep 300;
		[_pos] call clearlandmines;
	};
};

_this call sideMissionProcessor;
