// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_TownInsurgency.sqf

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_townName", "_buildingpositions"];

_setupVars =
{
	_missionType = localize "STR_INSURGENCY";
	_nbUnits = [] call getNbUnits;

	// settings for this mission
	_missionLocation = [sectors_capture] call getMissionLocation;
	_townName = markerText _missionLocation;

	_locationsArray = nil;
};

_setupObjects =
{
	_missionPos = ([markerPos _missionLocation, 50, random 360] call BIS_fnc_relPos);

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

	_missionHintText = format [localize "STR_INSURGENCY_MESSAGE1", sideMissionColor, _townName];
	A3W_sectors_in_use = A3W_sectors_in_use + [_missionLocation];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = { !(_missionLocation in blufor_sectors) };

_failedExec = {
	// Mission failed
	[_missionPos] call clearlandmines;
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_successExec = {
	// Mission completed
	private _rwd_ammo = (100 + floor(random 100));
	private _rwd_fuel = (10 + floor(random 10));
	private _text = format ["Reward Received: %1 Ammo and %2 Fuel", _rwd_ammo, _rwd_fuel];
	{
		if (_x distance2D _missionPos < GRLIB_sector_size ) then {
			[_x, _rwd_ammo, _rwd_fuel] call ammo_add_remote_call;
			[gamelogic, _text] remoteExec ["globalChat", owner _x];
		};
	} forEach (AllPlayers - (entities "HeadlessClient_F"));

	_successHintMessage = format [localize "STR_INSURGENCY_MESSAGE2", sideMissionColor, _townName];
	[_missionPos] call showlandmines;
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_this call sideMissionProcessor;
