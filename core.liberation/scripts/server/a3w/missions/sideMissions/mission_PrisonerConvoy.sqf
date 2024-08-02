if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private [ "_prisoners", "_vehicle1", "_vehicle2", "_vehicle3", "_last_waypoint", "_convoy_attacked", "_disembark_troops"];

_setupVars = {
	_missionType = "STR_PRI_CONV";
	_locationsArray = nil; // locations are generated on the fly from towns
	_ignoreAiDeaths = true;
	_missionTimeout = (30 * 60);
};

_setupObjects =
{
	private _sectorlist = (sectors_military select { _x in opfor_sectors });
	_sectorlist = ((_sectorlist call BIS_fnc_arrayShuffle) select [0, 3]);
	if (count _sectorlist < 3) exitWith {
		diag_log format ["--- LRX Error: side mission Priso Convoy, cannot find spawn or path!"];
		false;
	};

	_missionPos = markerPos (_sectorlist select 0);
	_aiGroup = createGroup [GRLIB_side_enemy, true];

	// veh1
	_vehicle1 = [_missionPos, opfor_mrap_hmg] call F_libSpawnVehicle;
	(crew _vehicle1) joinSilent _aiGroup;
	(driver _vehicle1) limitSpeed 50;
	_aiGroup selectLeader (driver _vehicle1);
	sleep 1;

	// veh2 + prisoners
	_vehicle2 = [_missionPos, opfor_transport_truck] call F_libSpawnVehicle;
	_vehicle2 setConvoySeparation 50;
	(crew _vehicle2) joinSilent _aiGroup;
	sleep 1;

	// Prisoners
	_prisoners = [];
	_grp = [_missionPos, 5, "prisoner", false] call createCustomGroup;
	{
		_prisoners pushBack _x;
		removeAllWeapons _x;
		_x setSkill ["courage", 0.8];
		_x assignAsCargo _vehicle2;
        _x moveInCargo _vehicle2;
		[_x] spawn {
			params ["_unit"];
			waitUntil { sleep 1; (isNull objectParent _unit || !alive _unit) };
			if (!alive _unit) exitWith {};
			_unit setVariable ["GRLIB_mission_AI", false, true];
			[_unit, true, false] spawn prisoner_ai;
		};
		sleep 0.1;
	} forEach (units _grp);

	// veh3
	_vehicle3 = [_missionPos, opfor_transport_truck] call F_libSpawnVehicle;
	_vehicle3 setConvoySeparation 50;
	_grp = [_missionPos, 6, "infantry", false] call createCustomGroup;
	{
		_x assignAsCargo _vehicle3;
        _x moveInCargo _vehicle3;		
		sleep 0.1;
	} forEach (units _grp);
	(crew _vehicle3) joinSilent _aiGroup;

	sleep 1;
	_aiGroup setFormation "COLUMN";
	_aiGroup setBehaviourStrong "SAFE";
	_aiGroup setCombatMode "GREEN";
	_aiGroup setSpeedMode "LIMITED";
	
	// behaviour on waypoints
	[_aiGroup] call F_deleteWaypoints;
	{
		_waypoint = _aiGroup addWaypoint [markerPos _x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointFormation "COLUMN";
		_waypoint setWaypointBehaviour "SAFE";
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointSpeed "LIMITED";
		_waypoint setWaypointCompletionRadius 200;
	} forEach _sectorlist;

	_last_waypoint = waypointPosition [_aiGroup, (count _sectorlist)-1];

	_missionPos = getPosATL leader _aiGroup;
	_missionPicture = getText (configFile >> "CfgVehicles" >> (opfor_transport_truck param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (opfor_transport_truck param [0,""]) >> "displayName");
	_missionHintText = ["STR_PRI_CONV_MSG", sideMissionColor];
	_convoy_attacked = false;
	_disembark_troops = false;
	_vehicles = [_vehicle1, _vehicle2, _vehicle3];
	true;
};

_waitUntilMarkerPos = { getPosATL (_prisoners select 0) };
_waitUntilExec = nil;
_waitUntilCondition = {
	if ( !_convoy_attacked ) then {
		{
			// Attacked ?
			_killed = ({!(alive _x)} count (units _aiGroup) > 0);
			if ( !(alive _x) || (damage _x > 0.2) || _killed && (count ([_x, GRLIB_sector_size] call F_getNearbyPlayers) > 0) ) then {
				_convoy_attacked = true;
			};

			// Unflip ?
			[_x] call F_vehicleUnflip;

			// Follow
			_veh_leader = vehicle (leader _aiGroup);
			if  (speed _x < 2 && (speed _veh_leader > 5 || _x == _veh_leader) && !_convoy_attacked) then {
				if (surfaceIsWater (getPosATL _x)) exitWith {
					[_x, true, true] call clean_vehicle;
				};
				_x setFuel 1;
				_x setDamage 0;
				[_x] call F_vehicleUnflip;
				if (_x != _veh_leader) then {
					(driver _x) doFollow (leader _aiGroup);
					(driver _x) doMove getPosATL (leader _aiGroup);
				};
				sleep 10;
			};
		} foreach [_vehicle1, _vehicle2, _vehicle3];
	};

	if (_convoy_attacked && !_disembark_troops) then {
		_disembark_troops = true;
		{ doStop (driver _x) } foreach [_vehicle1, _vehicle2, _vehicle3];
		sleep 1;
		{ [_x, false] spawn F_ejectUnit; sleep 0.2 } forEach (units _aiGroup + _prisoners);
		sleep 1;
		[_aiGroup, getPosATL _vehicle2] spawn defence_ai;
	};
	(({ alive _x } count _prisoners) == 0);
};

_waitUntilSuccessCondition = { 
	(({ alive _x && side group _x == GRLIB_side_friendly } count _prisoners) == ({ alive _x } count _prisoners));
};

_failedExec = {
	// Mission failed
	_failedHintMessage = format ["The Prisoners are <br/><t color='%1'>DEAD</t>!<br/>We have lost our brothers in Arms.<br/><br/>Better luck next time!", sideMissionColor];
	{ deleteVehicle _x } foreach _prisoners;
};

_successExec = {
	// Mission completed
	_successHintMessage = "Congratulation the Prisoners has been <t color='%1'>RESCUED</t>!<br/>Bring them back to any FOB.";
};

_this call sideMissionProcessor;
