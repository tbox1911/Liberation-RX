// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_TownInvasion.sqf

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_grp_civ", "_townName", "_tent1", "_chair1", "_chair2", "_fire1", "_civilians"];

_setupVars =
{
	_missionType = "STR_INVASION";
	_nbUnits = 16;

	// settings for this mission
	_missionLocation = [sectors_capture] call getMissionLocation;
	_townName = markerText _missionLocation;

	_locationsArray = nil;
};

_setupObjects =
{
	_missionPos = (markerpos _missionLocation) getPos [100, random 360];

	// create some atmosphere around the crates 8)
	_tent1 = createVehicle ["Land_cargo_addon02_V2_F", _missionPos, [], 3, "None"];
	_tent1 setDir random 360;
	_chair1 = createVehicle ["Land_CampingChair_V1_F", _missionPos, [], 2, "None"];
	_chair1 setDir random 90;
	_chair2 = createVehicle ["Land_CampingChair_V2_F", _missionPos, [], 2, "None"];
	_chair2 setDir random 180;
	_fire1	= createVehicle ["Campfire_burning_F", _missionPos, [], 2, "None"];

	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_tent1, _chair1, _chair2, _fire1];

	// get Houses nearbby
	_allbuildings = [ nearestObjects [_missionPos, ["House"], 100 ], { alive _x } ] call BIS_fnc_conditionalSelect;
	_buildingpositions = [];
	{
		_buildingpositions = _buildingpositions + ( [_x] call BIS_fnc_buildingPositions );
	} foreach _allbuildings;

	// spawn some enemies
	[_missionPos, 30] call createlandmines;
	[_missionLocation, 150, floor (random 6)] spawn ied_trap_manager;
	_managed_units = (["militia", (_nbUnits - 4), _buildingpositions, _missionPos] call F_spawnBuildingSquad);
	_aiGroup = [_missionPos, (_nbUnits - (count _managed_units)), "militia"] call createCustomGroup;
	_managed_units joinSilent _aiGroup;
	{ _x setVariable ["GRLIB_mission_AI", false, true] } forEach (units _aiGroup);	

	// Spawn civvies
	_grp_civ = [_missionPos, (5 + random(5))] call F_spawnCivilians;
	[_grp_civ, _missionPos] spawn add_civ_waypoints;

	_missionHintText = ["STR_INVASION_MESSAGE1", sideMissionColor, _townName, _nbUnits];
	A3W_sectors_in_use = A3W_sectors_in_use + [_missionLocation];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = { !(_missionLocation in blufor_sectors) };

_failedExec = {
	// Mission failed
	_failedHintMessage = ["STR_INVASION_FAILED", sideMissionColor, _townName];
	{ deleteVehicle _x } forEach [_tent1, _chair1, _chair2, _fire1];
	{ deleteVehicle _x } forEach (units _grp_civ);
	[_missionPos] call clearlandmines;
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_successExec = {
	// spawn some crates in the middle of town (Town marker position)
	[basic_weapon_typename, _missionPos, false] call boxSetup;

	private _rwd_ammo = (100 + floor(random 100));
	private _rwd_fuel = (10 + floor(random 10));
	private _text = format ["Reward Received: %1 Ammo and %2 Fuel", _rwd_ammo, _rwd_fuel];
	{
		if (_x distance2D _missionPos < GRLIB_capture_size) then {
			[_x, _rwd_ammo, _rwd_fuel] call ammo_add_remote_call;
			[gamelogic, _text] remoteExec ["globalChat", owner _x];
		};
	} forEach (AllPlayers - (entities "HeadlessClient_F"));

	_successHintMessage = ["STR_INVASION_MESSAGE2", sideMissionColor, _townName];
	{ deleteVehicle _x } forEach [_tent1, _chair1, _chair2, _fire1];
	{ deleteVehicle _x } forEach (units _grp_civ);
	[_missionPos] call showlandmines;
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_this call sideMissionProcessor;
