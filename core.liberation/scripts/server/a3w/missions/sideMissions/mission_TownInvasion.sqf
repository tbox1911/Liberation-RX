// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_TownInvasion.sqf

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_townName", "_buildingpositions", "_tent1", "_chair1", "_chair2", "_fire1"];

_setupVars =
{
	_missionType = localize "STR_INVASION";
	_nbUnits = [] call getNbUnits;

	// settings for this mission
	_missionLocation = [sectors_capture] call getMissionLocation;
	_townName = markerText _missionLocation;

	_locationsArray = nil;
};

_setupObjects =
{
	_missionPos = ([markerPos _missionLocation, 50, random 360] call BIS_fnc_relPos);

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
	[_missionPos, 150, floor (random 6)] spawn ied_trap_manager;
	_aiGroup = createGroup [GRLIB_side_enemy, true];
	_managed_units = (["militia", (_nbUnits - 4), _buildingpositions, _missionPos] call F_spawnBuildingSquad);
	_managed_units joinSilent _aiGroup;

	[_aiGroup, _missionPos, (_nbUnits - (count _managed_units)) , "militia"] call createCustomGroup;

	{
		_x setSkill ["courage", 1];
		_x setVariable ["GRLIB_mission_AI", nil];
	} forEach (units _aiGroup);

	_missionHintText = format [localize "STR_INVASION_MESSAGE1", sideMissionColor, _townName, _nbUnits];
	A3W_sectors_in_use = A3W_sectors_in_use + [_missionLocation];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = { !(_missionLocation in blufor_sectors) };

_failedExec = {
	// Mission failed
	{ deleteVehicle _x } forEach [_tent1, _chair1, _chair2, _fire1];
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
		if (_x distance2D _missionPos < GRLIB_sector_size ) then {
			[_x, _rwd_ammo, _rwd_fuel] call ammo_add_remote_call;
			[gamelogic, _text] remoteExec ["globalChat", owner _x];
		};
	} forEach (AllPlayers - (entities "HeadlessClient_F"));

	_successHintMessage = format [localize "STR_INVASION_MESSAGE2", sideMissionColor, _townName];
	{ deleteVehicle _x } forEach [_tent1, _chair1, _chair2, _fire1];
	[_missionPos] call showlandmines;
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_this call sideMissionProcessor;
