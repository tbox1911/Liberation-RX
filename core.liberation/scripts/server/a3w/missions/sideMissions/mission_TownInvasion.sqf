// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_TownInvasion.sqf

if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_box1", "_box2", "_townName", "_putOnRoof", "_fillEvenly", "_tent1", "_chair1", "_chair2", "_fire1"];

_setupVars =
{
	_missionType = "Town Invasion";
	_nbUnits = if (count AllPlayers > 2) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
	//randomize amount of units
	_nbUnits = _nbUnits + round(random (_nbUnits*0.5));

	// settings for this mission
	_missionLocation = selectRandom ((blufor_sectors select {["capture_", _x] call fn_startsWith;}) apply {[_x, false]}) select 0;
	_townName = markerText _missionLocation;

	// 25% change on AI not going on rooftops
	if (random 1 < 0.75) then { _putOnRoof = true } else { _putOnRoof = false };
	// 25% chance on AI trying to fit into a single building instead of spreading out
	if (random 1 < 0.75) then { _fillEvenly = true } else { _fillEvenly = false };
	_locationsArray = nil;
};

_setupObjects =
{
	_missionPos = (markerPos _missionLocation vectorAdd [([[-100,0,100], 20] call F_getRND), ([[-100,0,100], 20] call F_getRND), 0]);

	// spawn some crates in the middle of town (Town marker position)
	_box1 = ["Box_East_Wps_F", _missionPos, true] call boxSetup;
	[_box1, "mission_Main_A3snipers"] call fn_refillbox;

	_box2 = ["Box_East_Wps_F", _missionPos, true] call boxSetup;
	[_box2, "mission_USSpecial"] call fn_refillbox;

	// create some atmosphere around the crates 8)
	_tent1 = createVehicle ["Land_cargo_addon02_V2_F", _missionPos, [], 3, "None"];
	_tent1 setDir random 360;
	_chair1 = createVehicle ["Land_CampingChair_V1_F", _missionPos, [], 2, "None"];
	_chair1 setDir random 90;
	_chair2 = createVehicle ["Land_CampingChair_V2_F", _missionPos, [], 2, "None"];
	_chair2 setDir random 180;
	_fire1	= createVehicle ["Campfire_burning_F", _missionPos, [], 2, "None"];

	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_tent1, _chair1, _chair2, _fire1];

	_aiGroup = createGroup [GRLIB_side_enemy, true];
	[_aiGroup, _missionPos, _nbUnits] call createCustomGroup;
	[_aiGroup, _missionPos, 200, _fillEvenly, _putOnRoof] call moveIntoBuildings;
	[_missionPos, 25] call createlandmines;

	_missionHintText = format ["Hostiles have taken over <br/><t size='1.25' color='%1'>%2</t><br/><br/>There seem to be <t color='%1'>%3 enemies</t> hiding inside or on top of buildings. Get rid of them all, and take their supplies!<br/>Watch out for those windows!", sideMissionColor, _townName, _nbUnits];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec = {
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _tent1, _chair1, _chair2, _fire1];
	[_missionPos] call clearlandmines;
};

_successExec = {
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];

	_successHintMessage = format ["Nice work!<br/><br/><t color='%1'>%2</t><br/>is a safe place again!<br/>Their belongings are now yours to take!", sideMissionColor, _townName];
	{ deleteVehicle _x } forEach [_tent1, _chair1, _chair2, _fire1];
	[_missionPos] call showlandmines;
};

_this call sideMissionProcessor;
