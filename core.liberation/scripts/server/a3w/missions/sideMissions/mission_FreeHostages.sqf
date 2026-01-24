if (!isServer) exitWith {};
#include "sideMissionDefines.sqf"

private ["_all_buildings", "_hostages", "_managed_units", "_grp_civ", "_detected"];

_setupVars = {
	_missionType = "STR_FREE_HOSTAGES";
	_locationsArray = nil; // locations are generated on the fly from towns
	_ignoreAiDeaths = true;
	_detected = false;
};

_setupObjects = {
	// Spawn hostages
	_missionPos = markerPos (selectRandom blufor_sectors);
	_hostages = (["hostages", 4, _missionPos] call F_buildingSquad);
	if (count _hostages == 0) exitWith {
		diag_log format ["--- LRX Error: side mission %1, cannot create hostages!", localize _missionType];
		false;
	};
	// Conf hostages
	{
		[_x, true, false] spawn prisoner_ai;
		_x addGoggles "G_Blindfold_01_black_F";
		_x setDamage 0;
	} forEach _hostages;

	// Spawn Enemy
	_aiGroup = createGroup [GRLIB_side_enemy, true];
	_missionPos = getPosATL (_hostages select 0);
	_managed_units = (["militia", 12, _missionPos] call F_buildingSquad);
	if (count _managed_units <= 5) then {
		private _grp = [_missionPos, 6, "militia"] call createCustomGroup;
		_managed_units append (units _grp);
	};
	_managed_units joinSilent _aiGroup;

	private _grp_bomber = [_missionPos, 5, "militia", false] call createCustomGroup;
	{
		_managed_units pushBack _x;
		if (_forEachIndex == 0) then {
			doStop _x;
			_x setPosATL ([_missionPos, 1] call F_getRandomPos);
			_x setDamage 0;
			[_x, 10] spawn bomber_ai;
		} else {
			[_x, 40] spawn bomber_ai;
		};
		sleep 0.5;
	} forEach (units _grp_bomber);

	// Spawn civvies
	_grp_civ = [_missionPos, (5 + floor random 5)] call F_spawnCivilians;
	[_grp_civ, _missionPos] spawn add_civ_waypoints;

	_vehicles = _managed_units;
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
		if (GRLIB_AlarmsEnabled) then {
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
		if (GRLIB_AlarmsEnabled) then {
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
	{ deleteVehicle _x } forEach (units _grp_civ);
	{ [_x, -15] call F_addReput } forEach (AllPlayers - (entities "HeadlessClient_F"));
	private _msg = format [localize "STR_SIDE_FAILED_REPUT", -15];
	[gamelogic, _msg] remoteExec ["globalChat", 0];
};

_successExec = {
	// Mission completed
	_successHintMessage = "STR_FREE_HOSTAGES_MESSAGE2";
	{ deleteVehicle _x } forEach _hostages;
	{ deleteVehicle _x } forEach (units _grp_civ);
	if (combat_readiness > 50) then { combat_readiness = combat_readiness - 7 };
	{ [_x, 10] call F_addReput } forEach (AllPlayers - (entities "HeadlessClient_F"));
};

_this call sideMissionProcessor;