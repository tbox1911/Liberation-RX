if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private [ "_citylist", "_leader"];

_setupVars = {
	_missionType = "STR_HOSTILE_HELI";
	_citylist = [] call cityList;
	_locationsArray = nil; // locations are generated on the fly from towns
	_missionTimeout = (35 * 60);
	_ignoreAiDeaths = true;
};

_setupObjects = {
	_missionPos = markerPos ((selectRandom _citylist) select 0);
	if (count _missionPos == 0) exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", _missionType];
    	false;
	};
	_vehicleClass = selectRandom opfor_troup_transports_heli;
	_vehicle = [_missionPos, _vehicleClass] call F_libSpawnVehicle;
	_aiGroup = createGroup [GRLIB_side_enemy, true];
	(crew _vehicle) joinSilent _aiGroup;
	_leader = driver _vehicle;
	_leader setSkill 0.70;
	_leader setSkill ["courage", 1];
	_leader allowFleeing 0;
	_aiGroup selectLeader _leader;

	//_aiGroup setCombatMode "WHITE"; // Defensive behaviour
	_aiGroup setCombatMode "RED"; // Agressive behaviour
	_aiGroup setBehaviourStrong "AWARE";
	_speedMode = if (count AllPlayers > 2) then { "FULL" } else { "NORMAL" };
	_aiGroup setSpeedMode _speedMode;

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

	_wp0 = waypointPosition [_aiGroup, 0];
	_waypoint = _aiGroup addWaypoint [_wp0, 0];
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
_waitUntilSuccessCondition = { !(alive _vehicle) };

_failedExec = nil;
// _vehicle is automatically deleted or unlocked in missionProcessor depending on the outcome

_successExec = {
	// Mission completed
	// wait until heli is down to spawn crates
	[_vehicle] spawn {
		params ["_veh"];

		{ deleteVehicle _x } forEach (crew _veh);

		waitUntil {
			sleep 0.5;
			(isTouchingGround _veh || (getPosATL _veh) select 2 < 5)
		};

		sleep 2;
		private _sea_deep = round ((getPosATL _veh select 2) - (getPosASL _veh select 2));
		if (_sea_deep <= 20) then {
			[ammobox_o_typename, getPos _veh, false] call boxSetup;
			[ammobox_o_typename, getPos _veh, false] call boxSetup;
		};
	};

	_successHintMessage = "STR_HOSTILE_HELI_MESSAGE2";
};

_this call sideMissionProcessor;
