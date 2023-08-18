// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_HostileHelicopter.sqf

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private [ "_citylist", "_leader", "_numWaypoints", "_box1", "_box2"];

_setupVars =
{
	_missionType = "STR_HOSTILE_HELI";
	_citylist = [] call cityList;
	_locationsArray = nil; // locations are generated on the fly from towns
};

_setupObjects =
{
	_missionPos = markerPos ((selectRandom _citylist) select 0);
	_vehicleClass = selectRandom opfor_troup_transports_heli;

	_aiGroup = createGroup [GRLIB_side_enemy, true];
	//_aiGroup setCombatMode "WHITE"; // Defensive behaviour
	_aiGroup setCombatMode "RED"; // Agressive behaviour
	_aiGroup setBehaviour "AWARE";
	_aiGroup setFormation "STAG COLUMN";
	_speedMode = if (count AllPlayers > 2) then { "NORMAL" } else { "LIMITED" };
	_aiGroup setSpeedMode _speedMode;

	_vehicle = [_missionPos, _vehicleClass] call F_libSpawnVehicle;
	(crew _vehicle) joinSilent _aiGroup;
	_leader = effectiveCommander _vehicle;
	_aiGroup selectLeader _leader;

	// behaviour on waypoints
	[_aiGroup] call F_deleteWaypoints;
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 50;
		_waypoint setWaypointCombatMode "WHITE";
		_waypoint setWaypointBehaviour "AWARE";
		_waypoint setWaypointFormation "STAG COLUMN";
		_waypoint setWaypointSpeed _speedMode;
	} forEach (_citylist call BIS_fnc_arrayShuffle);

	_missionPos = getPosATL leader _aiGroup;
	_missionPicture = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0,""]) >> "displayName");
	_missionHintText = ["STR_HOSTILE_HELI_MESSAGE1", _vehicleName, sideMissionColor];
	_numWaypoints = count waypoints _aiGroup;
	true;
};

_waitUntilMarkerPos = {getPosATL _leader};
_waitUntilExec = nil;
_waitUntilCondition = {currentWaypoint _aiGroup >= _numWaypoints};

_failedExec = nil;
// _vehicle is automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec =
{
	// Mission completed

	// wait until heli is down to spawn crates
	_vehicle spawn
	{
		_veh = _this;
		//Delete pilots
		{ deleteVehicle _x } forEach crew _veh;
		waitUntil
		{
			sleep 0.1;
			_pos = getPos _veh;
			(isTouchingGround _veh || _pos select 2 < 5) && {vectorMagnitude velocity _veh < [1,5] select surfaceIsWater _pos};
		};

		_wreckPos = getPosATL _veh;
		_box1 = [ammobox_o_typename, _wreckPos, false] call boxSetup;
		_box2 = [ammobox_o_typename, _wreckPos, false] call boxSetup;
	};

	_successHintMessage = "STR_HOSTILE_HELI_MESSAGE2";
};

_this call sideMissionProcessor;
