if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_convoy_attacked", "_disembark_troops"];

_setupVars = {
	_missionType = "STR_KILL_BANDIT";
	_locationsArray = nil; // locations are generated on the fly from towns
	_ignoreAiDeaths = false;
	_missionTimeout = (40 * 60);
};

_setupObjects = {
	private _min_waypoints = 5;
	private _citylist = (sectors_capture select { _x in blufor_sectors && !(_x in active_sectors) });
	if (count _citylist < _min_waypoints) exitWith {
		diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", _missionType];
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
		diag_log format ["--- LRX Error: side mission %1, cannot find sector path!", _missionType];
		false;
	};

	_missionPos = _convoy_destinations select 0;
	_aiGroup = createGroup [GRLIB_side_enemy, true];
	//if ((tolower typeOf _vehicle) find "bicycle" > -1) exitWith {};
	private _blacklist = [
		"tractor",
		"bicycle",
		"medevac",
		"b_gen_van",
		"kart_",
		"quadbike_"
	];	
	private _allowed = {
		params ["_item", "_blaklist"];
		private _ret = true;
		{ if (_item find _x >= 0) exitWith { _ret = false } } foreach _blaklist;
		_ret;
	};
	private _bandits_car = selectRandom (civilian_vehicles select { _x isKindOf "Car" && [tolower _x, _blacklist] call _allowed });
	if (isNil "_bandits_car") exitWith {
		diag_log format ["--- LRX Error: side mission %1, cannot find vehicle classname!", _missionType];
		false;
	};	

	// veh1
	_vehicle1 = [_missionPos, _bandits_car, 0, false, GRLIB_side_enemy, false] call F_libSpawnVehicle;
	private _vehicle_seat = (_vehicle1 emptyPositions "") min 4;
	if (_vehicle_seat < 3) exitWith {
		diag_log format ["--- LRX Error: side mission %1, vehicle %2, no enough seat!", _missionType ,typeOf _vehicle1];
		deleteVehicle _vehicle1;
		false;
	};

	private _grp = [_missionPos, _vehicle_seat, "militia", false] call createCustomGroup;
	[_vehicle1, _grp] call F_manualCrew;
	(units _grp) joinSilent _aiGroup;
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

	// veh2
	_vehicle2 = [_missionPos, _bandits_car, 0, false, GRLIB_side_enemy, false] call F_libSpawnVehicle;
	_vehicle2 setConvoySeparation 50;
	_grp = [_missionPos, _vehicle_seat, "militia", false] call createCustomGroup;
	[_vehicle2, _grp] call F_manualCrew;
	(units _grp) joinSilent _aiGroup;

	// wait
	(driver _vehicle2) MoveTo (_convoy_destinations select 1);
	private _timout = round (time + (3 * 60));
	waitUntil {sleep 1; _vehicle2 distance2D _missionPos > 30 || time > _timout};

	// veh3
	_vehicle3 = [_missionPos, _bandits_car, 0, false, GRLIB_side_enemy, false] call F_libSpawnVehicle;
	_vehicle3 setConvoySeparation 50;
	_grp = [_missionPos, _vehicle_seat, "militia", false] call createCustomGroup;
	[_vehicle3, _grp] call F_manualCrew;
	(units _grp) joinSilent _aiGroup;
	(driver _vehicle3) MoveTo (_convoy_destinations select 1);
	sleep 1;

	// define final
	_missionPos = getPosATL leader _aiGroup;
	_missionPicture = getText (configFile >> "CfgVehicles" >> (_bandits_car param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (_bandits_car param [0,""]) >> "displayName");
	_missionHintText = ["STR_KILL_BANDIT_MSG", sideMissionColor];
	_convoy_attacked = false;
	_disembark_troops = false;
	_vehicles = [_vehicle1, _vehicle2, _vehicle3];
	true;
};

_waitUntilMarkerPos = { getPosATL (_vehicles select 0) };
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
		[_aiGroup, getPosATL (_vehicles select 0)] spawn defence_ai;
	};
	false;
};

//_waitUntilSuccessCondition = {};

_failedExec = {
	// Mission failed
	_failedHintMessage = format ["The Bandits are <br/><t color='%1'>ESCAPED</t>!<br/>They will still continue their crimes.<br/><br/>The local Population is unhappy...", sideMissionColor];
};

_successExec = {
	// Mission completed
	_successHintMessage = "Congratulation, the Bandits are all <t color='%1'>DEAD</t>!<br/>Bring him back to any FOB for interrogation.";
};

_this call sideMissionProcessor;
