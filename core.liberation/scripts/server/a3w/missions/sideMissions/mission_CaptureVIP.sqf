if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private [ "_vip", "_vehicle1", "_vehicle2", "_vehicle3", "_last_waypoint", "_convoy_attacked", "_disembark_troops"];

_setupVars =
{
	_missionType = "STR_VIP_CAP";
	_locationsArray = nil; // locations are generated on the fly from towns
	_ignoreAiDeaths = true;
	_missionTimeout = (30 * 60);
};

_setupObjects =
{
	private _citylist = (([] call cityList) call BIS_fnc_arrayShuffle) select [0, 3];

	if (count _citylist < 3) exitWith {
		diag_log format ["--- LRX Error: side mission VIP, cannot find spawn or path!"];
		false;
	};

	_missionPos = markerPos (_citylist select 0 select 0);
	_aiGroup = createGroup [GRLIB_side_enemy, true];

	// veh1 + squad
	_vehicle1 = [_missionPos, a3w_vip_vehicle, 3, false, GRLIB_side_enemy, false] call F_libSpawnVehicle;
	private _vehicle_seat = (_vehicle1 emptyPositions "") min 5;
	if (_vehicle_seat < 3) exitWith {
		diag_log format ["--- LRX Error: side mission VIP, vehicle %1, no enough seat!", typeOf _vehicle1];
		deleteVehicle _vehicle1;
		false;
	};
	private _grp = [_missionPos, _vehicle_seat, "guard", false] call createCustomGroup;
	[_vehicle1, _grp] call F_manualCrew;
	(units _grp) joinSilent _aiGroup;
	(driver _vehicle1) limitSpeed 50;
	_aiGroup selectLeader (driver _vehicle1);
	sleep 1;

	// veh2 + vip + squad
	_vehicle2 = [_missionPos, a3w_vip_vehicle, 3, false, GRLIB_side_enemy, false] call F_libSpawnVehicle;
	_vehicle2 setConvoySeparation 30;
	_grp = [_missionPos, (_vehicle_seat-1), "guard", false] call createCustomGroup;
	[_vehicle2, _grp] call F_manualCrew;
	(units _grp) joinSilent _aiGroup;
	sleep 1;

	// VIP
	_vip = _aiGroup createUnit ["O_Officer_Parade_Veteran_F", _missionPos, [], 0, "NONE"];
	_vip addEventHandler ["HandleDamage", { private [ "_damage" ]; if ( side (_this select 3) != GRLIB_side_friendly ) then { _damage = 0 } else { _damage = _this select 2 }; _damage }];
	_vip addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
	_vip setVariable ["GRLIB_mission_AI", true, true];
	_vip assignAsCargo _vehicle2;
	_vip moveInCargo _vehicle2;
	_vip setSkill ["courage", 0.9];
	[_vip, false, true] spawn prisoner_ai;
	_vip setrank "COLONEL";

	// veh3 + squad
	_vehicle3 = [_missionPos, a3w_vip_vehicle, 3, false, GRLIB_side_enemy, false] call F_libSpawnVehicle;
	_vehicle3 setConvoySeparation 30;
	_grp = [_missionPos, _vehicle_seat, "guard", false] call createCustomGroup;
	[_vehicle3, _grp] call F_manualCrew;
	(units _grp) joinSilent _aiGroup;

	sleep 1;
	_aiGroup setFormation "COLUMN";
	_aiGroup setBehaviourStrong "SAFE";
	_aiGroup setCombatMode "GREEN";
	_aiGroup setSpeedMode "LIMITED";
	
	// behaviour on waypoints
	[_aiGroup] call F_deleteWaypoints;
	{
		_waypoint = _aiGroup addWaypoint [markerPos (_x select 0), 0];
		_waypoint setWaypointType "MOVE";
		_waypoint setWaypointFormation "COLUMN";
		_waypoint setWaypointBehaviour "SAFE";
		_waypoint setWaypointCombatMode "GREEN";
		_waypoint setWaypointSpeed "LIMITED";
		_waypoint setWaypointCompletionRadius 200;
	} forEach _citylist;

	_last_waypoint = waypointPosition [_aiGroup, count _citylist];

	_missionPos = getPosATL leader _aiGroup;
	_missionPicture = getText (configFile >> "CfgVehicles" >> (a3w_vip_vehicle param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (a3w_vip_vehicle param [0,""]) >> "displayName");
	_missionHintText = ["STR_VIP_CAP_MSG", sideMissionColor];
	_convoy_attacked = false;
	_disembark_troops = false;
	_vehicles = [_vehicle1, _vehicle2, _vehicle3];
	true;
};

_waitUntilMarkerPos = { getPosATL _vip };
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
		{ [_x, false] spawn F_ejectUnit; sleep 0.2 } forEach (units _aiGroup) + [_vip];
		sleep 1;
		[_aiGroup, getPosATL _vip] spawn defence_ai;
	};
	(!(alive _vip) || (_vip distance2D _last_waypoint) < 100);
};

_waitUntilSuccessCondition = { side group _vip == GRLIB_side_friendly };

_failedExec = {
	// Mission failed
	_failedHintMessage = format ["The V.I.P is <br/><t color='%1'>ESCAPED</t>!<br/>We have lost a valuable source of information.<br/><br/>Better luck next time!", sideMissionColor];
	deleteVehicle _vip;
};

_successExec = {
	// Mission completed
	_successHintMessage = "Congratulation the V.I.P has been <t color='%1'>CAPTURED</t>!<br/>Bring him back to any FOB for interrogation.";
};

_this call sideMissionProcessor;
