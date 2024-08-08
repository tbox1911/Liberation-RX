if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private [ "_ressources", "_convoy_attacked", "_disembark_troops"];

_setupVars = {
	_missionType = "STR_RSC_CONV";
	_locationsArray = nil; // locations are generated on the fly from towns
	_ignoreAiDeaths = true;
	_missionTimeout = (45 * 60);
};

_setupObjects = {
	// Check Box
	private _boxes_amount = 0;
	{
		if ( _x select 0 == a3w_truck_open ) exitWith { _boxes_amount = (count _x) - 2 };
	} foreach box_transport_config;
	if ( _boxes_amount == 0 ) exitWith {
		diag_log format ["Opfor ammobox truck (%1) doesn't allow for ammobox transport, correct your classnames!",  a3w_truck_open];
		false;
	};

	private _min_waypoints = 4;
	private _citylist = ((sectors_military + sectors_factory) select { _x in opfor_sectors && !(_x in active_sectors) });
	if (count _citylist < _min_waypoints) exitWith {
		diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
		false;
	};

	private _convoy_destinations_markers = [6000, _citylist, _min_waypoints] call F_getSectorPath;
	private _convoy_destinations = [_convoy_destinations_markers] call F_getPathRoadFilter;
	if (count _convoy_destinations < _min_waypoints) exitWith {
		diag_log format ["--- LRX Error: side mission %1, cannot find sector path!", localize _missionType];
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
	[_aiGroup, _convoy_destinations] call add_convoy_waypoints;

	// wait
	(driver _vehicle1) MoveTo (_convoy_destinations select 1);
	private _timout = round (time + (3 * 60));
	waitUntil {sleep 1; _vehicle1 distance2D _missionPos > 30 || time > _timout};

	// veh2 + ressources
	_vehicle2 = [_missionPos, a3w_truck_open, 0] call F_libSpawnVehicle;
	_vehicle2 setConvoySeparation 50;
	(crew _vehicle2) joinSilent _aiGroup;

	// Ressources
	for "_n" from 1 to _boxes_amount do {
		private _boxclass = selectRandom [ammobox_o_typename, waterbarrel_typename, fuelbarrel_typename, repairbox_typename, basic_weapon_typename];
		[_vehicle2, _boxclass] call attach_object_direct;
	};
	_ressources = _vehicle2 getVariable ["GRLIB_ammo_truck_load", []];

	// wait
	(driver _vehicle2) MoveTo (_convoy_destinations select 1);
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
	(driver _vehicle3) MoveTo (_convoy_destinations select 1);

	// define final
	_missionPos = getPosATL leader _aiGroup;
	_missionPicture = getText (configFile >> "CfgVehicles" >> (a3w_truck_open param [0,""]) >> "picture");
	_vehicleName = getText (configFile >> "CfgVehicles" >> (a3w_truck_open param [0,""]) >> "displayName");
	_missionHintText = ["STR_RSC_CONV_MESSAGE1", sideMissionColor];
	_convoy_attacked = false;
	_disembark_troops = false;
	_vehicles = [_vehicle1, _vehicle2, _vehicle3];
	true;
};

_waitUntilMarkerPos = { getPosATL (_ressources select 0) };
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
	(({ alive _x } count _ressources) == 0);
};

_waitUntilSuccessCondition = {
	private _free_box = { alive _x && isNull (attachedTo _x) } count _ressources;
	private _truck = attachedTo (_ressources select 0);
	(_free_box > 0 || (side group _truck == GRLIB_side_friendly));
};

_failedExec = {
	// Mission failed
	_failedHintMessage = ["STR_RSC_CONV_MESSAGE2", sideMissionColor];
	{ deleteVehicle _x } foreach _ressources;
};

_successExec = {
	// Mission completed
	_successHintMessage = ["STR_RSC_CONV_MESSAGE3", sideMissionColor];
};

_this call sideMissionProcessor;
