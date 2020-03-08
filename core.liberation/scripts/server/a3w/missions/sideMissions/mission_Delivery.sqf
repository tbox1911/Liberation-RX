// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_MeetResistance.sqf
//	"C_Orestes",
//	"C_Nikos"

/*
create 3 units
1 (city1) - give you case and direction to city2
2 (city2) - exchange case to laptop and direction to mission1
3 (mission1) - exchange laptop to XP / Ammo

create enemy squad at mission1
*/


if (!isServer) exitwith {};
if (!isNil "GRLIB_A3W_Mission_MR") exitWith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_townName",
		"_missionLocation2", "_missionLocation3", "_missionLocationEnd",
		"_mission_grp", "_case1",
		"_house", "_veh2"];

_setupVars =
{
	_missionType = "Special Delivery";
	// settings for this mission
	_missionLocation  = selectRandom ((blufor_sectors select {["capture_", _x] call fn_startsWith;}) apply {[_x, false]}) select 0;
	_missionLocation2 = selectRandom ((blufor_sectors select {["capture_", _x] call fn_startsWith;}) apply {[_x, false]}) select 0;
	_missionLocation3 = selectRandom ((blufor_sectors select {["capture_", _x] call fn_startsWith;}) apply {[_x, false]}) select 0;
	_missionLocationEnd = selectRandom (SpawnMissionMarkers apply {[_x, false]}) select 0;

	_townName = markerText _missionLocation;
	_nbUnits = if (missionDifficultyHard) then { AI_GROUP_LARGE } else { AI_GROUP_MEDIUM };
	//randomize amount of units
	_nbUnits = _nbUnits + round(random (_nbUnits*0.5));
};

_setupObjects =
{
	_missionPos  = (markerPos _missionLocation vectorAdd [([[-150,0,150], 20] call F_getRND), ([[-150,0,150], 20] call F_getRND), 0]);
	_missionPos2 = (markerPos _missionLocation2 vectorAdd [([[-150,0,150], 20] call F_getRND), ([[-150,0,150], 20] call F_getRND), 0]);
	_missionPos3 = (markerPos _missionLocation3 vectorAdd [([[-150,0,150], 20] call F_getRND), ([[-150,0,150], 20] call F_getRND), 0]);
	_missionPosEnd = (markerPos _missionLocationEnd vectorAdd [([[-150,0,150], 20] call F_getRND), ([[-150,0,150], 20] call F_getRND), 0]);

	// create Nikos units
	_mission_grp = createGroup [GRLIB_side_civilian, true];
	_mission_grp createUnit ["C_Nikos", _missionPos, [], 0, "NONE"];
	_mission_grp createUnit ["C_Orestes", _missionPos2, [], 0, "NONE"];
	_mission_grp createUnit ["C_Orestes", _missionPos3, [], 0, "NONE"];
	_nikos = _mission_grp createUnit ["C_Nikos_aged", _missionPosEnd, [], 0, "NONE"];
	GRLIB_A3W_Mission_SD = _mission_grp;
	publicVariable "GRLIB_A3W_Mission_MR";

	{
		_x setVariable ['GRLIB_can_speak', true, true];
		_x allowDamage false;
		doStop _x;

		_markername = format ["nikos_%1", _forEachIndex + 1];
		_marker = createMarkerLocal [_markername, getPos _x];
		_marker setMarkerShapeLocal "ICON";
		_marker setMarkerTypeLocal "mil_pickup";
		_marker setMarkerColorLocal "ColorPink";
		_marker setMarkerTextlocal (name _x);
	} forEach units _mission_grp;

	_nikos enableAI "Move";
	_house = createVehicle ["Land_i_House_Small_01_V1_F", _missionPos, [], 2, "None"];
	_nikos moveTo _house;

	// Enemies
	_aiGroup = createGroup [GRLIB_side_enemy, true];
	[_aiGroup, _missionPosEnd, _nbUnits, "infantry"] call createCustomGroup;

	_missionHintText = format ["Special Delivery at <br/><t size='1.25' color='%1'>%2</t><br/><br/><t color='#00F000'>Talk</t> to <t color='#0000F0'>Nikos</t> to get information.<br/>Be ready for any situation!", sideMissionColor, _townName];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
/*
_waitUntilSuccessCondition = {
	_ret = false;
	_ret;
 };
_waitUntilCondition = {count (units _aiGroupRes select {alive _x && _x distance2D _missionPos < 400}) == 0};
*/

_failedExec = {
	// Mission failed
	GRLIB_A3W_Mission_SD = nil;
	publicVariable "GRLIB_A3W_Mission_MR";
	{ deleteVehicle _x } forEach [_house];
	{ deleteVehicle _x } forEach units _mission_grp;

	_failedHintMessage = format ["Special Delivery<br/><t color='%1'>FAILED</t> !!<br/><br/>Better luck next time!", sideMissionColor];
};

_successExec = {
	// Mission completed
	GRLIB_A3W_Mission_SD = nil;
	publicVariable "GRLIB_A3W_Mission_MR";
	_successHintMessage = format ["Special Delivery<br/><t color='%1'>SUCCESS</t> !!<br/><br/>Better luck next time!", sideMissionColor];
	{ deleteVehicle _x } forEach [_house];
	{ deleteVehicle _x } forEach units _mission_grp;

	[ammobox_i_typename, _missionPosEnd, false] call boxSetup;
};

_this call sideMissionProcessor;
