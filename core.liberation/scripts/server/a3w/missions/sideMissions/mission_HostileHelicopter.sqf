if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private [ "_citylist", "_leader", "_box1", "_box2"];

_setupVars = {
	_missionType = "STR_HOSTILE_HELI";
	_citylist = [] call cityList;
	_locationsArray = nil; // locations are generated on the fly from towns
	_missionTimeout = (30 * 60);
};

_setupObjects = {
	_missionPos = markerPos ((selectRandom _citylist) select 0);
	if (count _missionPos == 0) exitWith { 
    	diag_log format ["--- LRX Error: side mission HH, cannot find spawn point!"];
    	false;
	};	
	_vehicleClass = selectRandom opfor_troup_transports_heli;

	_aiGroup = createGroup [GRLIB_side_enemy, true];
	//_aiGroup setCombatMode "WHITE"; // Defensive behaviour
	_aiGroup setCombatMode "RED"; // Agressive behaviour
	_aiGroup setBehaviourStrong "AWARE";
	_speedMode = if (count AllPlayers > 2) then { "FULL" } else { "NORMAL" };
	_aiGroup setSpeedMode _speedMode;

	_vehicle = [_missionPos, _vehicleClass] call F_libSpawnVehicle;
	(crew _vehicle) joinSilent _aiGroup;
	_leader = driver _vehicle;
	_leader setSkill 0.70;
	_leader setSkill ["courage", 1];
	_leader allowFleeing 0;
	_aiGroup selectLeader _leader;

	// behaviour on waypoints
	[_aiGroup] call F_deleteWaypoints;
	private _path = (_citylist call BIS_fnc_arrayShuffle) select [0,5];
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointCompletionRadius 500;
		_waypoint setWaypointCombatMode "WHITE";
		_waypoint setWaypointBehaviour "AWARE";
		_waypoint setWaypointSpeed _speedMode;
	} forEach _path;
	_last_waypoint = waypointPosition [_aiGroup, count _path];
	_waypoint = _aiGroup addWaypoint [_missionPos, 0];
	_waypoint setWaypointType "CYCLE";

	_missionPos = getPosATL leader _aiGroup;
	_missionPicture = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (_vehicleClass param [0,""]) >> "displayName");
	_missionHintText = ["STR_HOSTILE_HELI_MESSAGE1", _vehicleName, sideMissionColor];
	true;
};

_waitUntilMarkerPos = { getPosATL _leader };
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec = nil;
// _vehicle is automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec = {
	// Mission completed
	// wait until heli is down to spawn crates
	[_vehicle] spawn {
		params ["_veh"];

		//Delete pilots
		{ deleteVehicle _x } forEach (crew _veh);
		waitUntil {
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
