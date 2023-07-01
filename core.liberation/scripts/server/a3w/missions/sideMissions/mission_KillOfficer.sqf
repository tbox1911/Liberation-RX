// ******************************************************************************************
// An enemy Officer makes ready to fly to their HQ. He has vital information about us. We need to elimiate him to prevent the enemy
// of gaining intel on us!
// ******************************************************************************************
// @file name: mission_KillOfficer.sqf

if (!isServer) exitWith {};
if (!isNil "GRLIB_A3W_Mission_MR") exitWith {};
#include "sideMissionDefines.sqf"

private ["_fobList", "_aiGroup", "_hvt", "_civilians", "_nbUnits"];

_setupVars =
{
	_missionType = "STR_HOSSTILE_OFFICER";
	_fobList = [] call cityList;
	_nbUnits = [] call getNbUnits;
};

_setupObjects =
{
	_missionPos = markerPos ((selectRandom _fobList) select 0);
	_vehicleClass = opfor_mrap_hmg;

	// Spawn vehicle
	private _vehicle1 = [_missionPos, _vehicleClass, false, false, true] call F_libSpawnVehicle;
	_vehicle1 setVariable ["GRLIB_mission_AI", true, true];
	
	_aiGroup = createGroup [GRLIB_side_enemy, true];
	// Define vehicle
	_vehicle1 allowCrewInImmobile true;
	createVehicleCrew _vehicle1;
	[crew _vehicle1] joinSilent _aiGroup;

	// Spawn HVT
	_grp_hvt = createGroup [GRLIB_side_enemy, true];
	_hvt = _grp_hvt createUnit [ opfor_officer, _missionPos, [], 0, "NONE"];
	_hvt addEventHandler ["HandleDamage", { private [ "_damage" ]; if ( side (_this select 3) != GRLIB_side_friendly ) then { _damage = 0 } else { _damage = _this select 2 }; _damage }];
	_hvt addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
	[_hvt] joinSilent _grp_hvt;
	_hvt setrank "COLONEL";

	// Move HVT into Building
	_hvt_pos = getPosATL _hvt;
	_hvt move selectRandom ((nearestBuilding _hvt_pos) buildingPos -1);

	// Spawn civvies
	_civilians = [];
	for "_i" from 0 to (5 + random(5)) do {
		_civ_grp = [_hvt_pos, [selectRandom civilians], GRLIB_side_civilian, "civilian"] call F_libSpawnUnits;
		[_civ_grp, _hvt_pos, 75] call BIS_fnc_taskPatrol;
		_civilians pushBack _civ_grp;
	};

	// Spawn Patrolgroup
	// Define group
	[_aiGroup, _missionPos, _nbUnits, "infantry"] call createCustomGroup;
	_aiGroup setCombatMode "WHITE"; // Defensive behaviour
	_aiGroup setBehaviour "AWARE";
	_aiGroup setFormation "WEDGE";
	_aiGroup setSpeedMode "LIMITED";

	// Patrol around the HVT
	[_aiGroup, _hvt_pos, 50] call BIS_fnc_taskPatrol;

	_missionPos = _hvt_pos;
	_missionPicture = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0, ""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0, ""]) >> "displayName");
	_missionHintText = ["STR_HOSSTILE_OFFICER_MESSAGE1", _vehicleName, sideMissionColor];
	_vehicles = [_vehicle1];
	true;
};

_failedExec = {
	// Mission failed
	{{deleteVehicle _x} forEach (units _x)} forEach _civilians;
	deleteVehicle _hvt;
};

_successExec =
{	
	// Mission completed
	_successHintMessage = "STR_HOSSTILE_HELI_MESSAGE2";
	{{deleteVehicle _x} forEach (units _x)} forEach _civilians;
	if (combat_readiness > 20) then { combat_readiness = combat_readiness - 15 };
};

_this call sideMissionProcessor;