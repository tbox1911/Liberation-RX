// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_TownInvasion.sqf

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_box1", "_box2", "_townName", "_buildingpositions", "_tent1", "_chair1", "_chair2", "_fire1"];

_setupVars =
{
	_missionType = "Town Invasion";
	_nbUnits = [] call getNbUnits;

	// settings for this mission
	_missionLocation = selectRandom ((blufor_sectors select {["capture_", _x] call F_startsWith;}) apply {[_x, false]}) select 0;
	_townName = markerText _missionLocation;

	_locationsArray = nil;
};

_setupObjects =
{
	_missionPos = (markerPos _missionLocation vectorAdd [([[-50,0,50], 20] call F_getRND), ([[-50,0,50], 20] call F_getRND), 0]);

	// spawn some crates in the middle of town (Town marker position)
	_box1 = [A3W_BoxWps, _missionPos, true] call boxSetup;
	_box2 = [A3W_BoxWps, _missionPos, true] call boxSetup;

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
	[_missionPos, 25] call createlandmines;
	_aiGroup = createGroup [GRLIB_side_enemy, true];
	_managed_units = (["militia", (_nbUnits - 4), _buildingpositions, _missionPos] call F_spawnBuildingSquad);
	{ _x setVariable ["mission_AI", true] } forEach _managed_units;
	_managed_units joinSilent _aiGroup;

	[_aiGroup, _missionPos, (_nbUnits - (count _managed_units)) , "militia"] call createCustomGroup;

	_missionHintText = format ["Hostiles have taken over <br/><t size='1.25' color='%1'>%2</t><br/><br/>There seem to be <t color='%1'>%3 enemies</t> hiding inside or on top of buildings. Get rid of them all, and take their supplies!<br/>Watch out for those windows!", sideMissionColor, _townName, _nbUnits];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;

_waitUntilCondition = { _missionLocation in (sectors_allSectors - blufor_sectors) };

_failedExec = {
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _tent1, _chair1, _chair2, _fire1];
	[_missionPos] call clearlandmines;
};

_successExec = {
	// Mission completed
	{
		_x setVariable ["R3F_LOG_disabled", false, true];
		_x setVariable ["GRLIB_vehicle_owner", nil, true];
	} forEach [_box1, _box2];

	_successHintMessage = format ["Nice work!<br/><br/><t color='%1'>%2</t><br/>is a safe place again!<br/>Their belongings are now yours to take!", sideMissionColor, _townName];
	{ deleteVehicle _x } forEach [_tent1, _chair1, _chair2, _fire1];
	[_missionPos] call showlandmines;
};

_this call sideMissionProcessor;
