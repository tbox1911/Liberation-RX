if (!isServer) exitWith {};
#include "sideMissionDefines.sqf"

private ["_hvt", "_grp_hvt", "_grp_civ"];

_setupVars = {
	_missionType = "STR_HOSTILE_OFFICER";
	_locationsArray = nil; // locations are generated on the fly from towns
	_ignoreAiDeaths = true;
};

_setupObjects = {
	private _fobList = sectors_bigtown select {(_x in blufor_sectors)};
	private _nbUnits = [] call getNbUnits;

	if (count _fobList == 0) exitWith {
		diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
		false;
	};
	_missionPos = markerPos (selectRandom _fobList);
	_missionPos = ([_missionPos, 50] call F_getRandomPos);
	_vehicleClass = opfor_mrap_hmg;

	// Add guards
	_grp_hvt = [_missionPos, 3, "infantry", false] call createCustomGroup;
	_grp_hvt setCombatMode "YELLOW"; // Aggresive behaviour
	_grp_hvt setBehaviourStrong "AWARE";

	// Add HVT
	_hvt = _grp_hvt createUnit [ opfor_officer, _missionPos, [], 0, "NONE"];
	[_hvt] joinSilent _grp_hvt;
	_hvt setVariable ["GRLIB_mission_AI", true, true];
	_hvt addEventHandler ["HandleDamage", { _this call damage_manager_enemy }];
	_hvt addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
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
	private _vehicle1_pos = getPos (selectRandom _roads);
	if (isNil "_vehicle1_pos") then { _vehicle1_pos = _hvt_pos; precise = false };
	_vehicle = [_vehicle1_pos, _vehicleClass, 0, nil, nil, nil, true] call F_libSpawnVehicle;
	(crew _vehicle) joinSilent _grp_hmg;

	// Patrolgroup
	_aiGroup = [_hvt_pos, _nbUnits, "infantry", true, 40] call createCustomGroup;
	_aiGroup setCombatMode "WHITE"; // Defensive behaviour
	_aiGroup setBehaviourStrong "AWARE";
	_aiGroup setFormation "WEDGE";
	_aiGroup setSpeedMode "NORMAL";

	// Spawn civvies
	_grp_civ = [_hvt_pos, (5 + floor random 5)] call F_spawnCivilians;
	[_grp_civ, _hvt_pos] spawn add_civ_waypoints;

	_missionPos = _hvt_pos;
	_missionPicture = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0, ""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0, ""]) >> "displayName");
	_missionHintText = ["STR_HOSTILE_OFFICER_MESSAGE1", _vehicleName, sideMissionColor];
	true;
};

_waitUntilSuccessCondition = { !(alive _hvt) };

_failedExec = {
	// Mission failed
	{ deleteVehicle _x } forEach (units _grp_civ);
	{ deleteVehicle _x } forEach (units _grp_hvt);
};

_successExec = {
	// Mission completed
	_successHintMessage = "STR_HOSTILE_OFFICER_MESSAGE2";
	{ deleteVehicle _x } forEach (units _grp_civ);
	if (combat_readiness > 20) then { combat_readiness = combat_readiness - 7 };
};

_this call sideMissionProcessor;