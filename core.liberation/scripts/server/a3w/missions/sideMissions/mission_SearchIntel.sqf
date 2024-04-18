if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_intels", "_grp_civ"];

_setupVars = {
	_missionType = "STR_SEARCH_INTEL";
	_locationsArray = [SpawnMissionMarkers] call checkSpawn;
};

_setupObjects = {
	_missionPos = (markerpos _missionLocation);

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

	private _statue = [
		"Land_Statue_03_F",
		"Land_Maroula_F",
		"Land_Statue_01_F",
		"Land_Statue_02_F"
	];

	//----- build village ---------------------------------
	_statue = createVehicle [selectRandom _statue, _missionPos, [], 1, "None"];

	private _build_list  = [];
	for "_i" from 1 to 5 do {
		_dir = random 360;
		_max = 100;
		_pos = [];
		_start_pos = _missionPos;
		while { count _pos == 0 && _max > 0 } do {
			_pos = _start_pos findEmptyPosition [10, 200, "B_Heli_Transport_01_F"];
			if (isOnRoad _pos || surfaceIsWater _pos) then {
				_pos = [];
			};
			_max = _max - 1;
			_start_pos = _missionPos getPos [100, random 360];
			sleep 0.1;
		};
		if (count _pos == 0) exitWith { };
		_build = createVehicle [selectRandom _buildings, _pos, [], 1, "None"];
		_build setVectorDirAndUp [[-cos _dir, sin _dir, 0] vectorCrossProduct surfaceNormal _pos, surfaceNormal _pos];
		_build_list pushBack _build;
		sleep 0.2;
	};
	if (count _build_list < 3) exitWith { false };

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
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach ([_statue] + _build_list + _vrac_list + _intels);
	_vehicles =  [_statue] + _build_list + _vrac_list;
	sleep 0.5;

	//----- spawn units ---------------------------------
	private _nbUnits = [] call getNbUnits;
	private _managed_units = (["infantry", _nbUnits, _missionPos] call F_spawnBuildingSquad);
	_aiGroup = group (_managed_units select 0);
	{
		_x setSkill 0.70;
		_x setSkill ["courage", 1];
		_x allowFleeing 0;
		_x setVariable ["GRLIB_mission_AI", true, true];
	} forEach (units _aiGroup);

	//----- spawn civilians ---------------------------------
	_grp_civ = [_missionPos, (5 + random(5))] call F_spawnCivilians;

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
	_ret = false;
	{
		if (_aiGroup knowsAbout _x == 4 ) then { _ret = true };
	} forEach ([_missionPos, GRLIB_sector_size] call F_getNearbyPlayers);

	if (_ret) then {
		[_missionPos] spawn {
			params ["_pos"];
			private _sound = "A3\data_f_curator\sound\cfgsounds\air_raid.wss";
			for "_i" from 0 to 1 do {
				playSound3D [_sound, _pos, false, ATLToASL _pos, 5, 1, 1000];
				sleep 5;
			};
			private _msg = ["<t color='#FFFFFF' size='2'>You have been Detected!!<br/><br/>Enemies destroy the </t><t color='#ff0000' size='3'>INTELS</t><t color='#FFFFFF' size='2'> !!</t>", "PLAIN", -1, false, true];

			{
				[_msg] remoteExec ["titleText", owner _x];
			} forEach ([_pos, GRLIB_sector_size] call F_getNearbyPlayers);

			for "_i" from 0 to 1 do {
				playSound3D [_sound, _pos, false, ATLToASL _pos, 5, 1, 1000];
				sleep 5;
			};
		};
		sleep 10;
	};
	_ret;
};

_failedExec = {
	// Mission failed
	{ deleteVehicle _x } forEach _intels;
	[_missionPos, _grp_civ] spawn {
		params ["_pos","_grp1"];
		waitUntil { sleep 30; (GRLIB_global_stop == 1 || [_pos, GRLIB_capture_size, GRLIB_side_friendly] call F_getUnitsCount == 0) };
		{ deleteVehicle _x } forEach (units _grp1);
		[_pos] call clearlandmines;
	};
};

_successExec = {
	// Mission completed
	private _rwd_xp = round (15 + random 30);
	private _text = format ["Reward Received: %1 XP", _rwd_xp];
	{
		[_x, _rwd_xp] call F_addScore;
		[gamelogic, _text] remoteExec ["globalChat", owner _x];
	} forEach ([_missionPos, GRLIB_capture_size] call F_getNearbyPlayers);

	_successHintMessage = "STR_SEARCH_INTEL_MESSAGE2";
	{ deleteVehicle _x } forEach (units _grp_civ);
	[_missionPos] spawn {
		params ["_pos"];
		[_pos] call showlandmines;
		sleep 300;
		[_pos] call clearlandmines;
	};
};

_this call sideMissionProcessor;
