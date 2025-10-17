if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_managed_units", "_grp_civ", "_townName"];

_setupVars = {
	_missionType = "STR_INVASION";
	_locationsArray = [LRX_MissionMarkersCap] call checkSpawn;
	_missionTimeout = (30 * 60);
};

_setupObjects = {
	_townName = markerText _missionLocation;
	_missionPos = [(markerpos _missionLocation), 5, 0, 80] call F_findSafePlace;
	if (count _missionPos == 0) exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
    	false;
	};

	// create some atmosphere around the crates 8)
	_tent1 = createVehicle ["Land_cargo_addon02_V2_F", _missionPos, [], 3, "None"];
	_tent1 setDir random 360;
	_chair1 = createVehicle ["Land_CampingChair_V1_F", _missionPos, [], 2, "None"];
	_chair1 setDir random 90;
	_chair2 = createVehicle ["Land_CampingChair_V2_F", _missionPos, [], 2, "None"];
	_chair2 setDir random 180;
	_fire1	= createVehicle ["Campfire_burning_F", _missionPos, [], 2, "None"];

	_vehicles = [_tent1, _chair1, _chair2, _fire1];
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach _vehicles;

	// spawn some enemies
	[_missionPos, 30] call createlandmines;
	[markerPos _missionLocation, 150, floor (random 6)] spawn ied_trap_manager;
	_aiGroup = [_missionPos, 12, "militia"] call createCustomGroup;
	_managed_units = (["militia", 10, _missionPos] call F_buildingSquad);
	private _grp1 = [_missionPos, 12, "militia"] call createCustomGroup;
	_managed_units append (units _grp1);
	private _nb_player = count (AllPlayers - (entities "HeadlessClient_F"));
	if (_nb_player > 2) then {
		sleep 5;
		_grp1 = [_missionPos, 12, "militia"] call createCustomGroup;
		_managed_units append (units _grp1);
	};
	{ _x setVariable ["GRLIB_mission_AI", false, true] } forEach (units _aiGroup + _managed_units);

	// Spawn civvies
	_grp_civ = [_missionPos, (5 + floor random 5)] call F_spawnCivilians;
	[_grp_civ, _missionPos] spawn add_civ_waypoints;

	_missionHintText = ["STR_INVASION_MESSAGE1", sideMissionColor, _townName, (count units _aiGroup + count _managed_units)];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = { !(_missionLocation in blufor_sectors) };
_waitUntilSuccessCondition = { ({ alive _x } count (units _aiGroup + _managed_units) == 0) };

_failedExec = {
	// Mission failed
	{ [_x, -5] call F_addReput } forEach (AllPlayers - (entities "HeadlessClient_F"));
	private _msg = format [localize "STR_SIDE_FAILED_REPUT", -5];
	[gamelogic, _msg] remoteExec ["globalChat", 0];		
	_failedHintMessage = ["STR_INVASION_FAILED", sideMissionColor, _townName];
	{ deleteVehicle _x } forEach _managed_units;
	{ deleteVehicle _x } forEach (units _grp_civ);
	[_missionPos] call clearlandmines;
};

_successExec = {
	// spawn some crates in the middle of town (Town marker position)
	[basic_weapon_typename, _missionPos, false] call boxSetup;

	private _rwd_ammo = (100 + floor(random 100));
	private _rwd_fuel = (10 + floor(random 10));
	private _text = format ["Reward Received: %1 Ammo and %2 Fuel", _rwd_ammo, _rwd_fuel];
	{
		[_x, _rwd_ammo, _rwd_fuel] call ammo_add_remote_call;
		[gamelogic, _text] remoteExec ["globalChat", owner _x];
		[_x, 10] call F_addReput;
	} forEach ([_missionPos, GRLIB_capture_size] call F_getNearbyPlayers);

	_successHintMessage = ["STR_INVASION_MESSAGE2", sideMissionColor, _townName];
	{ deleteVehicle _x } forEach _managed_units;
	{ deleteVehicle _x } forEach (units _grp_civ);
	[_missionPos] spawn {
		params ["_pos"];
		[_pos] call showlandmines;
		sleep 300;
		[_pos] call clearlandmines;
	};
};

_this call sideMissionProcessor;
