// ******************************************************************************************
// An enemy Officer makes ready to fly to their HQ. He has vital information about us. We need to elimiate him to prevent the enemy
// of gaining intel on us!
// ******************************************************************************************
// @file name: mission_KillOfficer.sqf

if (!isServer) exitWith {};
if (!isNil "GRLIB_A3W_Mission_MR") exitWith {};
#include "sideMissionDefines.sqf"

private ["_fobList", "_aiGroup", "_grp_hvt", "_civilians", "_nbUnits"];

_setupVars =
{
	_missionType = "STR_HOSTILE_OFFICER";
	_fobList = sectors_bigtown select {(_x in blufor_sectors)};
	_nbUnits = [] call getNbUnits;
};

_setupObjects =
{
	if (count _fobList == 0) exitWith { false };
	_sector = selectRandom _fobList;
	_missionPos = markerPos _sector;
	_missionPos = _missionPos getPos [80, random 360];
	_vehicleClass = opfor_mrap_hmg;

	// Add guards
	_grp_hvt = [_missionPos, 3, "guard", false] call createCustomGroup;
	_grp_hvt setCombatMode "RED"; // Aggresive behaviour
	_grp_hvt setBehaviour "AWARE";

	// Add HVT
	private _hvt = _grp_hvt createUnit [ opfor_officer, _missionPos, [], 0, "NONE"];
	_hvt setVariable ["GRLIB_mission_AI", true, true];
	_hvt addEventHandler ["HandleDamage", { private [ "_damage" ]; if ( side (_this select 3) != GRLIB_side_friendly ) then { _damage = 0 } else { _damage = _this select 2 }; _damage }];
	_hvt addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
	[_hvt] joinSilent _grp_hvt;
	_hvt setrank "COLONEL";

	sleep 1;
	private _building = nearestBuilding (getPosATL _hvt) buildingPos -1;
	// Move HVT into Building
	{ 
		_x setPos selectRandom _building;
		_x setUnitPos "UP";
		_x disableAI "MOVE";
		sleep 0.3;
	} foreach (units _grp_hvt);
	_hvt_pos = getPosATL _hvt;

	// Spawn Enemy
	// Vehicle
	_grp_hmg = createGroup [GRLIB_side_enemy, true];
	private _roads = _hvt_pos nearRoads 50;
	private _precise = true;
	private _vehicle1_pos = getPos (selectRandom _roads);
	if (isNil "_vehicle1_pos") then { _vehicle1_pos = _hvt_pos; precise = false };
	private _vehicle1 = [_vehicle1_pos, _vehicleClass, _precise] call F_libSpawnVehicle;
	_vehicle1 setVariable ["GRLIB_mission_AI", true, true];
	_vehicle1 allowCrewInImmobile true;
	createVehicleCrew _vehicle1;
	sleep 1;
	(crew _vehicle1) joinSilent _grp_hmg;

	// Patrolgroup
	_aiGroup = [_hvt_pos, _nbUnits, "infantry", true, 40] call createCustomGroup;
	_aiGroup setCombatMode "WHITE"; // Defensive behaviour
	_aiGroup setBehaviour "AWARE";
	_aiGroup setFormation "WEDGE";
	_aiGroup setSpeedMode "NORMAL";

	// Spawn civvies
	_civilians = [];
	for "_i" from 0 to (5 + random(5)) do {
		_civ_grp = [_hvt_pos, [selectRandom civilians], GRLIB_side_civilian, "civilian"] call F_libSpawnUnits;
		[_civ_grp, _hvt_pos, 50] call BIS_fnc_taskPatrol;
		_civilians pushBack _civ_grp;
	};

	_missionPos = _hvt_pos;
	_missionPicture = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0, ""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0, ""]) >> "displayName");
	_missionHintText = ["STR_HOSTILE_OFFICER_MESSAGE1", _vehicleName, sideMissionColor];
	_vehicles = [_vehicle1];
	true;
};

_waitUntilSuccessCondition = { ({alive _x} count (units _grp_hvt) == 0) };

_failedExec = {
	// Mission failed
	{{deleteVehicle _x} forEach (units _x)} forEach _civilians;
	{ deleteVehicle _x } forEach units _grp_hvt;
};

_successExec =
{	
	// Mission completed
	_successHintMessage = "STR_HOSTILE_OFFICER_MESSAGE2";
	[_vehicles] spawn cleanMissionVehicles;
	//{if (alive _x) then { deleteVehicle _x }} forEach units _aiGroup;
	{{deleteVehicle _x} forEach (units _x)} forEach _civilians;
	if (combat_readiness > 20) then { combat_readiness = combat_readiness - 15 };
};

_this call sideMissionProcessor;