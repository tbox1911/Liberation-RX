if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private [ "_prisoners", "_convoy_attacked", "_disembark_troops"];

_setupVars = {
	_missionType = "STR_PRI_CONV";
	_locationsArray = nil; // locations are generated on the fly from towns
	_ignoreAiDeaths = true;
	_missionTimeout = (30 * 60);
};

_setupObjects = {
	private _min_waypoints = 4;
	private _citylist = (sectors_military select { _x in opfor_sectors && !(_x in active_sectors) });
	if (count _citylist < _min_waypoints) exitWith {
		diag_log format ["--- LRX Error: side mission Priso Convoy, no enough City!"];
		false;
	};

	private _convoy_destinations_markers = [6000, _citylist, _min_waypoints] call F_getSectorPath;
	private _convoy_destinations = [];
	private ["_pos", "_nearestroad", "_land"];
	{
		_pos = (markerPos _x);
		_nearestroad = [_pos, 100] call BIS_fnc_nearestRoad;
		_land = !(surfaceIsWater _pos);
		if (_land) then {
			if (isNull _nearestroad) then {
				_convoy_destinations pushback _pos;
			} else {
				_convoy_destinations pushback (getpos _nearestroad);
			};
		};
	} foreach _convoy_destinations_markers;

	if (count _convoy_destinations < _min_waypoints) exitWith {
		diag_log format ["--- LRX Error: side mission Priso Convoy, cannot find path!"];
		false;
	};

	_missionPos = _convoy_destinations select 0;
	_aiGroup = createGroup [GRLIB_side_enemy, true];

	// veh1
	_vehicle1 = [_missionPos, opfor_mrap_hmg, 0] call F_libSpawnVehicle;
	(crew _vehicle1) joinSilent _aiGroup;
	(driver _vehicle1) limitSpeed 50;
	_aiGroup selectLeader (driver _vehicle1);
	sleep 1;

	// Waypoints
	_aiGroup setFormation "COLUMN";
	_aiGroup setBehaviourStrong "SAFE";
	_aiGroup setCombatMode "GREEN";
	_aiGroup setSpeedMode "LIMITED";

	// behaviour on waypoints
	[_aiGroup] call F_deleteWaypoints;
	{
		_waypoint = _aiGroup addWaypoint [_x, 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointFormation "COLUMN";
		_waypoint setWaypointBehaviour "SAFE";
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointSpeed "LIMITED";
		_waypoint setWaypointCompletionRadius 200;
	} forEach _convoy_destinations;

	_wp0 = waypointPosition [_aiGroup, 0];
	_waypoint = _aiGroup addWaypoint [_wp0, 0];
	_waypoint setWaypointType "CYCLE";

	// wait
	(driver _vehicle1) MoveTo (_convoy_destinations select 1);
	private _timout = round (time + (3 * 60));
	waitUntil {sleep 1; _vehicle1 distance2D _missionPos > 30 || time > _timout};

	// veh2 + prisoners
	_vehicle2 = [_missionPos, a3w_truck_covered, 0] call F_libSpawnVehicle;
	_vehicle2 setConvoySeparation 50;
	(crew _vehicle2) joinSilent _aiGroup;

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

	private _timout = round (time + (3 * 60));
	waitUntil {sleep 1; _vehicle2 distance2D _missionPos > 30 || time > _timout};

	// veh3
	_vehicle3 = [_missionPos, a3w_truck_covered, 0] call F_libSpawnVehicle;
	_vehicle3 setConvoySeparation 50;
	_grp = [_missionPos, 8, "infantry", false] call createCustomGroup;
	{
		_x assignAsCargo _vehicle3;
        _x moveInCargo _vehicle3;
		sleep 0.1;
	} forEach (units _grp);
	(crew _vehicle3) joinSilent _aiGroup;

	// define final
	_missionPos = getPosATL leader _aiGroup;
	_missionPicture = getText (configFile >> "CfgVehicles" >> (a3w_truck_covered param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (a3w_truck_covered param [0,""]) >> "displayName");
	_missionHintText = ["STR_PRI_CONV_MSG", sideMissionColor];
	_convoy_attacked = false;
	_disembark_troops = false;
	_vehicles = [_vehicle1, _vehicle2, _vehicle3];
	true;
};

_waitUntilMarkerPos = { getPosATL (_prisoners select 0) };
_waitUntilExec = nil;
_waitUntilCondition = {
	if (!_convoy_attacked) then {
		// Attacked ?
		{
			_veh_cur = _x;
			_killed = ({ !alive _x } count (units _aiGroup) > 0);
			if ( !(alive _veh_cur) || (damage _veh_cur > 0.2) || _killed && (count ([_veh_cur, GRLIB_sector_size] call F_getNearbyPlayers) > 0) ) then {
				_convoy_attacked = true;
			};
		} foreach _vehicles;
	};

	if (!_convoy_attacked && !_disembark_troops) then {
		// Drivers Follow
		{
			_veh_cur = _x;
			_veh_leader = vehicle (leader _aiGroup);
			if (speed _veh_cur < 2 && (_veh_cur distance2D _veh_leader > 50 || _veh_cur == _veh_leader)) then {
				_veh_cur setFuel 1;
				_veh_cur setDamage 0;
				[_veh_cur] call F_vehicleUnflip;
				_veh_cur setPos (getPos _veh_cur);
				if (_veh_cur != _veh_leader) then {
					(driver _veh_cur) doFollow (leader _aiGroup);
					(driver _veh_cur) doMove getPosATL (leader _aiGroup);
				};
			};
			sleep 1;
		} foreach _vehicles;
	};

	if (_convoy_attacked && !_disembark_troops) then {
		// Eject Troop
		_disembark_troops = true;
		{
			_veh_cur = _x;
			doStop (driver _veh_cur);
			sleep 2;
			{
				[_x, false] spawn F_ejectUnit;
				sleep 0.2
			} forEach (crew _veh_cur);
		} foreach _vehicles;
		sleep 5;
		[_aiGroup, getPosATL (_vehicles select 1)] spawn defence_ai;
	};
	(({ alive _x } count _prisoners) == 0);
};

_waitUntilSuccessCondition = {
	private _alive_units = { alive _x } count _prisoners;
	private _free_units = { alive _x && side group _x == GRLIB_side_friendly } count _prisoners;
	(_alive_units > 0 && _free_units == _alive_units);
};

_failedExec = {
	// Mission failed
	_failedHintMessage = format ["All Prisoners in the convoy are <br/><t color='%1'>DEAD</t>!<br/>We have lost our brothers in Arms.<br/><br/>Better luck next time!", sideMissionColor];
	{ deleteVehicle _x } foreach _prisoners;
};

_successExec = {
	// Mission completed
	_successHintMessage = "Congratulation, the Prisoners has been <t color='%1'>RESCUED</t>!<br/>Bring them back to any FOB.";
};

_this call sideMissionProcessor;
