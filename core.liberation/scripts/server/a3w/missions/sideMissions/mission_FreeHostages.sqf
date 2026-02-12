if (!isServer) exitWith {};
#include "sideMissionDefines.sqf"

private ["_all_buildings", "_hostages", "_managed_units", "_civ_units", "_detected"];

_setupVars = {
	_missionType = "STR_FREE_HOSTAGES";
	_locationsArray = nil; // locations are generated on the fly from towns
	_ignoreAiDeaths = true;
	_detected = false;
};

_setupObjects = {
	// Spawn hostages
	_missionPos = markerPos (selectRandom blufor_sectors);
	_managed_units = (["militia", 12, _missionPos] call F_buildingSquad);
	if (count _managed_units < 8) exitWith {
		diag_log format ["--- LRX Error: side mission %1, cannot create hostages!", localize _missionType];
		{ deleteVehicle _x } forEach _managed_units;
		false;
	};

	// Conf hostages
	_hostages = [];
	for "_i" from 0 to round (3 + floor random 4) do {
		_unit = selectRandom (_managed_units - _hostages);
		_loadout = getUnitLoadout (selectRandom civilians);
		_unit setUnitLoadout _loadout;
		if (_i == 0) then {
			[_unit, 10] spawn bomber_ai;
			sleep 3;
			[_unit, "init"] remoteExec ["remote_call_prisoner", 0];
			_unit addGoggles selectRandom ["G_Bandanna_shades","G_Bandanna_CandySkull","G_Balaclava_Halloween_01"];
		} else {
			[_unit, true, false] spawn prisoner_ai;
			_unit addGoggles "G_Blindfold_01_black_F";
		};
		_hostages pushBack _unit;
		sleep 0.1;
	};
	_managed_units = _managed_units - _hostages;

	// Spawn Enemy
	_missionPos = getPosATL (_hostages select 0);
	_managed_units append (["militia", 6, _missionPos] call F_buildingSquad);

	// Spawn bombers
	private _grp_bomber = [_missionPos, (3 + floor random 5), "militia", false] call createCustomGroup;
	_managed_units append (units _grp_bomber);
	{
		[_x, 40] spawn bomber_ai;
		sleep 0.5;
	} forEach (units _grp_bomber);

	_aiGroup = createGroup [GRLIB_side_enemy, true];
	_managed_units joinSilent _aiGroup;

	// Spawn civvies
	private _grp_civ = [_missionPos, (5 + floor random 5)] call F_spawnCivilians;
	[_grp_civ, _missionPos] spawn add_civ_waypoints;
	_civ_units = (units _grp_civ);

	_missionPicture = "\a3\Ui_F_Curator\Data\Displays\RscDisplayCurator\modeGroups_ca.paa";
	_missionHintText = ["STR_FREE_HOSTAGES_MESSAGE1", sideMissionColor];
	true;
};

_waitUntilExec = {
	private _ret = false;
	{
		if (_aiGroup knowsAbout _x == 4 ) then { _ret = true };
	} forEach ([_missionPos, GRLIB_sector_size] call F_getNearbyPlayers);

	if (_ret && !_detected) then {
		_detected = true;
		private _sound = "A3\data_f_curator\sound\cfgsounds\air_raid.wss";
		if (GRLIB_alarms_enabled) then {
			playSound3D [_sound, _missionPos, false, ATLToASL _missionPos, 5, 1, 1000];
		};
		sleep 5;
		private _msg = ["<t color='#FFFFFF' size='2'>You have been Detected!!<br/><br/>Enemies call for </t><t color='#ff0000' size='3'>Reinforcements</t><t color='#FFFFFF' size='2'> !!</t>", "PLAIN", -1, false, true];
		{
			[_msg] remoteExec ["titleText", owner _x];
		} forEach ([_missionPos, GRLIB_sector_size] call F_getNearbyPlayers);
		private _grp = [([_missionPos, 120] call F_getRandomPos), 6, "militia", false] call createCustomGroup;
		[_grp, _missionPos] spawn battlegroup_ai;
		sleep 5;
		private _grp = [([_missionPos, 120] call F_getRandomPos), 6, "militia", false] call createCustomGroup;
		[_grp, _missionPos] spawn battlegroup_ai;
		if (GRLIB_alarms_enabled) then {
			playSound3D [_sound, _missionPos, false, ATLToASL _missionPos, 5, 1, 1000];
		};
	};
};

_waitUntilCondition = {	(({ alive _x } count _hostages) == 0) };

_waitUntilSuccessCondition = {
	private _alive_units = { alive _x } count _hostages;
	private _free_units = { alive _x && !(_x getVariable ["GRLIB_is_prisoner", false]) } count _hostages;
	(_alive_units > 0 && _free_units == _alive_units);
};

_failedExec = {
	// Mission failed
	_failedHintMessage = ["STR_FREE_HOSTAGES_MESSAGE3", sideMissionColor];
	{ deleteVehicle _x } forEach _hostages;
	{ deleteVehicle _x } forEach _managed_units;
	{ deleteVehicle _x } forEach _civ_units;
	{ [_x, -15] call F_addReput } forEach (AllPlayers - (entities "HeadlessClient_F"));
	private _msg = format [localize "STR_SIDE_FAILED_REPUT", -15];
	[gamelogic, _msg] remoteExec ["globalChat", 0];
};

_successExec = {
	// Mission completed
	_successHintMessage = "STR_FREE_HOSTAGES_MESSAGE2";
	{ deleteVehicle _x } forEach _hostages;
	{ deleteVehicle _x } forEach _civ_units;
	if (combat_readiness > 50) then { combat_readiness = combat_readiness - 7 };
	{ [_x, 10] call F_addReput } forEach (AllPlayers - (entities "HeadlessClient_F"));
};

_this call sideMissionProcessor;