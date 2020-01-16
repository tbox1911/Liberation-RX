// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_MeetResistance.sqf

if (!isServer) exitwith {};
if (!isNil "GRLIB_A3W_Mission_MR") exitWith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_townName",
		 "_aiGroupRes", "_putOnRoof", "_fillEvenly",
		 "_tent1", "_chair1", "_chair2", "_fire1",
		 "_box1", "_box2",
		 "_veh1", "_veh2"];

_setupVars =
{
	_missionType = "The Resistance";
	// settings for this mission
	_missionLocation = selectRandom ((blufor_sectors select {["capture_", _x] call fn_startsWith;}) apply {[_x, false]}) select 0 ;
	_townName = markerText _missionLocation;
	_ignoreAiDeaths = true;

	//randomize amount of Resistance units
	_nbUnits = 6;
	_nbUnits = _nbUnits + round(random (_nbUnits*0.5));
	GRLIB_A3W_Mission_MR = nil;
	publicVariable "GRLIB_A3W_Mission_MR";
	GRLIB_A3W_Mission_MRR = nil;
	publicVariable "GRLIB_A3W_Mission_MRR";
};

_setupObjects =
{
	_missionPos = (markerPos _missionLocation vectorAdd [([[-150,0,150], 20] call F_getRND), ([[-150,0,150], 20] call F_getRND), 0]);

	// spawn some crates in the middle of town (Town marker position)
	_box1 = ["Box_East_Wps_F", _missionPos, true] call boxSetup;
	[_box1, "mission_USLaunchers"] call fn_refillbox;
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
	// create static weapons
	_veh1 = createVehicle ["B_static_AA_F", _missionPos, [], 50, "None"];
	_veh1 setDir random 360;
	_veh2 = createVehicle ["B_static_AA_F", _missionPos, [], 50, "None"];
	_veh2 setDir random 360;
	// R3F disable
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_tent1, _chair1, _chair2, _fire1];

	// spawn some resistance
	_aiGroupRes = createGroup [GRLIB_side_friendly, true];
	[_aiGroupRes, _missionPos, _nbUnits, "resistance"] call createCustomGroup;
	// remove dead body to let the leader change
	{_x addEventHandler ["Killed", {_this spawn {sleep 20;hidebody (_this select 0);sleep 5;deleteVehicle (_this select 0)}}]} forEach units _aiGroupRes;

	// 25% change on AI not going on rooftops
	if (random 1 < 0.75) then { _putOnRoof = true } else { _putOnRoof = false };
	// 25% chance on AI trying to fit into a single building instead of spreading out
	if (random 1 < 0.75) then { _fillEvenly = true } else { _fillEvenly = false };
	// move them into buildings
	[_aiGroupRes, _missionPos, 200, _fillEvenly, _putOnRoof] call moveIntoBuildings;

	{_x setVariable ['GRLIB_can_speak', true, true]} foreach units _aiGroupRes;
	GRLIB_A3W_Mission_MRR = _aiGroupRes;
	publicVariable "GRLIB_A3W_Mission_MRR";
	_missionHintText = format ["Meet the Resistance at <br/><t size='1.25' color='%1'>%2</t><br/><br/><t color='#00F000'>Talk</t> to the <t color='#0000F0'>Leader</t> to get information.<br/>Be ready for any situation!", sideMissionColor, _townName];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilSuccessCondition = {
	_ret = false;
	if (!isnil "GRLIB_A3W_Mission_MR") then {
		private _opf = 0;
		{_opf = _opf + count (units _x select {alive _x})} forEach GRLIB_A3W_Mission_MR;
		if (_opf == 0) then {_ret = true};
	};
	_ret;
 };
_waitUntilCondition = {count (units _aiGroupRes select {alive _x && _x distance2D _missionPos < 400}) == 0};

_failedExec = {
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _tent1, _chair1, _chair2, _fire1, _veh1, _veh2];
	{ deleteVehicle _x } forEach units _aiGroupRes;
	GRLIB_A3W_Mission_MR = nil;
	publicVariable "GRLIB_A3W_Mission_MR";
	GRLIB_A3W_Mission_MRR = nil;
	publicVariable "GRLIB_A3W_Mission_MRR";
	_failedHintMessage = format ["All members of the Resistance are...<br/><t color='%1'>DEAD</t> !!<br/><br/>Better luck next time!", sideMissionColor, _townName];
};

_successExec = {
	// Mission completed
	{ _x setVariable ["R3F_LOG_disabled", false, true] } forEach [_box1, _box2];
	_successHintMessage = format ["Nice work!<br/><br/><t color='%1'>%2</t><br/>is a safe place again!<br/>Take your reward!", sideMissionColor, _townName];
	{ deleteVehicle _x } forEach [_tent1, _chair1, _chair2, _fire1, _veh1, _veh2];
	{ deleteVehicle _x } forEach units _aiGroupRes;
	GRLIB_A3W_Mission_MR = nil;
	publicVariable "GRLIB_A3W_Mission_MR";
	GRLIB_A3W_Mission_MRR = nil;
	publicVariable "GRLIB_A3W_Mission_MRR";
	[ammobox_i_typename, _missionPos, false] call boxSetup;
	[ammobox_i_typename, _missionPos, false] call boxSetup;
};

_this call sideMissionProcessor;
