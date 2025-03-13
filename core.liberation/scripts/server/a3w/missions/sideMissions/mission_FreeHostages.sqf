if (!isServer) exitWith {};
#include "sideMissionDefines.sqf"

private ["_hostages", "_managed_units", "_grp_civ", "_detected"];

_setupVars = {
	_missionType = "STR_FREE_HOSTAGES";
	_locationsArray = nil; // locations are generated on the fly from towns
	_ignoreAiDeaths = true;
	_detected = false;
};

_setupObjects = {
	private _building_classname = [
		"Land_i_Shed_Ind_F",
		"Land_i_House_Big_01_V2_F",
		"Land_i_House_Big_01_V3_F",
		"Land_i_House_Big_02_V2_F",
		"Land_Unfinished_Building_01_F"
	];
	private _all_buildings = [];
	{
		private _buildings = (nearestObjects [markerPos _x, _building_classname, 300]) select {alive _x};
		{
			_nb = count ([_x] call BIS_fnc_buildingPositions);
			if (_nb >= 9) then { _all_buildings pushBack _x };
		} foreach _buildings;
		if (count _all_buildings > 0) exitWith {};
	} forEach (blufor_sectors call BIS_fnc_arrayShuffle);

	if (count _all_buildings == 0) exitWith {
		diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
		false;
	};

	_vehicleClass = "C_man_1_1_F";
	_missionBuilding = (selectRandom _all_buildings);
	_missionPos = getPos _missionBuilding;

	// Spawn Enemy
	_managed_units = ["militia", 10, _missionPos, 0, _missionBuilding] call F_spawnBuildingSquad;
	_aiGroup = group (_managed_units select 0);

	private _grp_bomber = [_missionPos, 4, "militia", false] call createCustomGroup;
	{ 
		_managed_units pushBack _x;
		if (_forEachIndex == 0) then {			
			doStop _x;
			_x setPosATL _missionPos;
			_x addGoggles "G_Blindfold_01_white_F";
			[_x, 10] spawn bomber_ai;
		} else {
			[_x, 40] spawn bomber_ai;
		};
	} forEach (units _grp_bomber);

	{ _x setVariable ["GRLIB_mission_AI", true, true] } forEach _managed_units;

	// Spawn hostages
	_grp_hostages = [_missionPos, 4] call F_spawnCivilians;
	_hostages = units _grp_hostages;
	{
		doStop _x;
		private _pos = (_missionPos getPos [4, 360]);
		_pos set [2, 0.3];
		_x setPosATL _pos;
		[_x, true, false] spawn prisoner_ai;
		_x addGoggles "G_Blindfold_01_black_F";
		sleep 0.1;
	} forEach _hostages;

	// Spawn civvies
	_grp_civ = [_missionPos, (5 + floor random 5)] call F_spawnCivilians;
	[_grp_civ, _missionPos] spawn add_civ_waypoints;

	_missionPicture = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0, ""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0, ""]) >> "displayName");
	_missionHintText = ["STR_FREE_HOSTAGES_MESSAGE1", sideMissionColor];
	true;
};

_waitUntilExec = {
	private _ret = false;
	{
		if (_aiGroup knowsAbout _x == 4 ) then { _ret = true };
	} forEach ([_missionPos, GRLIB_sector_size] call F_getNearbyPlayers);

	if (_ret && !_detected) then {
		_detected = true;
		// private _sound = "A3\data_f_curator\sound\cfgsounds\air_raid.wss";
		//playSound3D [_sound, _missionPos, false, ATLToASL _missionPos, 5, 1, 1000];
		// sleep 5;
		private _msg = ["<t color='#FFFFFF' size='2'>You have been Detected!!<br/><br/>Enemies call for </t><t color='#ff0000' size='3'>Reinforcements</t><t color='#FFFFFF' size='2'> !!</t>", "PLAIN", -1, false, true];
		{
			[_msg] remoteExec ["titleText", owner _x];
		} forEach ([_missionPos, GRLIB_sector_size] call F_getNearbyPlayers);
		// // Patrolgroup
		// _aiGroup = [_hvt_pos, _nbUnits, "infantry", true, 40] call createCustomGroup;
		// _aiGroup setCombatMode "WHITE"; // Defensive behaviour
		// _aiGroup setBehaviourStrong "AWARE";
		// _aiGroup setFormation "WEDGE";
		// _aiGroup setSpeedMode "NORMAL";


		// [_missionPos] spawn send_paratroopers;
		// playSound3D [_sound, _missionPos, false, ATLToASL _missionPos, 5, 1, 1000];
	};
};

_waitUntilCondition = {	(({ alive _x } count _hostages) == 0) };

_waitUntilSuccessCondition = {
	private _alive_units = { alive _x } count _hostages;
	private _free_units = { alive _x && side group _x == GRLIB_side_friendly } count _hostages;
	(_alive_units > 0 && _free_units == _alive_units);
};

_failedExec = {
	// Mission failed
	_failedHintMessage = ["STR_FREE_HOSTAGES_MESSAGE3", sideMissionColor];
	{ deleteVehicle _x } forEach _hostages;
	{ deleteVehicle _x } forEach _managed_units;
	{ deleteVehicle _x } forEach (units _grp_civ);
	//{ deleteVehicle _x } forEach (units _grp_hvt);
};

_successExec = {
	// Mission completed
	_successHintMessage = "STR_FREE_HOSTAGES_MESSAGE2";
	{ deleteVehicle _x } forEach _hostages;
	{ deleteVehicle _x } forEach _managed_units;
	{ deleteVehicle _x } forEach (units _grp_civ);
	//if (combat_readiness > 20) then { combat_readiness = combat_readiness - 7 };
};

_this call sideMissionProcessor;