// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_MeetResistance.sqf

if (!isServer) exitwith {};
if (!isNil "GRLIB_A3W_Mission_MR") exitWith {};
#include "sideMissionDefines.sqf"

private [
	"_nbUnits", "_townName", "_aiGroupRes", "_buildingpositions",
	"_tent1", "_chair1", "_chair2", "_fire1",
	"_box1", "_box2",
	"_veh1", "_veh2", "_gunner"
];

_setupVars =
{
	_missionType = localize "STR_RESISTANCE";
	_nbUnits = 10;

	// settings for this mission
	_missionLocation = [sectors_capture] call getMissionLocation;
	_townName = markerText _missionLocation;
	_ignoreAiDeaths = true;

	_locationsArray = nil;
	GRLIB_A3W_Mission_MR = nil;
	publicVariable "GRLIB_A3W_Mission_MR";
	GRLIB_A3W_Mission_MRR = nil;
	publicVariable "GRLIB_A3W_Mission_MRR";
};

_setupObjects =
{
	_missionPos = ([markerPos _missionLocation, 100, random 360] call BIS_fnc_relPos);

	// spawn some crates in the middle of town (Town marker position)
	_box1 = [basic_weapon_typename, _missionPos, true] call boxSetup;
	_box2 = [basic_weapon_typename, _missionPos, true] call boxSetup;

	// create some atmosphere around the crates 8)
	_tent1 = createVehicle ["Land_cargo_addon02_V2_F", _missionPos, [], 3, "None"];
	_tent1 setDir random 360;
	_chair1 = createVehicle ["Land_CampingChair_V1_F", _missionPos, [], 2, "None"];
	_chair1 setDir random 90;
	_chair2 = createVehicle ["Land_CampingChair_V2_F", _missionPos, [], 2, "None"];
	_chair2 setDir random 180;
	_fire1	= createVehicle ["Campfire_burning_F", _missionPos, [], 2, "None"];

	// R3F disable
	{ _x setVariable ["R3F_LOG_disabled", true, true] } forEach [_tent1, _chair1, _chair2, _fire1];

	// get Houses nearbby
	_allbuildings = [ nearestObjects [_missionPos, ["House"], 100 ], { alive _x } ] call BIS_fnc_conditionalSelect;
	_buildingpositions = [];
	{
		_buildingpositions = _buildingpositions + ( [_x] call BIS_fnc_buildingPositions );
	} foreach _allbuildings;

	// spawn some resistance
	_managed_units = (["resistance", 4, _buildingpositions, _missionPos] call F_spawnBuildingSquad);
	if (count _managed_units > 0) then {
		_aiGroupRes = group leader (_managed_units select 0);
	} else {
		_aiGroupRes = createGroup [GRLIB_side_resistance, true];
	};
	[_aiGroupRes, _missionPos, (_nbUnits - (count _managed_units)), "resistance"] call createCustomGroup;

	// create static weapons + crew
	_veh1 = createVehicle [resistance_squad_static, _missionPos, [], 100, "None"];
	_veh1 setDir random 360;
	sleep 0.5;
	_gunner = (units _aiGroupRes) select ((count (units _aiGroupRes)) -1);
	_gunner assignAsGunner _veh1;
	_gunner moveInGunner _veh1;
	[_gunner] orderGetIn true;
	_veh1 setVariable ["GRLIB_vehicle_gunner", [_gunner]];
	sleep 1;

	_veh2 = createVehicle [resistance_squad_static, _missionPos, [], 100, "None"];
	_veh2 setDir random 360;
	sleep 0.5;
	_gunner = (units _aiGroupRes) select ((count (units _aiGroupRes)) -2);
	_gunner assignAsGunner _veh2;
	_gunner moveInGunner _veh2;
	[_gunner] orderGetIn true;
	_veh2 setVariable ["GRLIB_vehicle_gunner", [_gunner]];

	// remove dead body to let the leader change
	//{_x addEventHandler ["Killed", {_this spawn {sleep 20;hidebody (_this select 0);sleep 5;deleteVehicle (_this select 0)}}]} forEach units _aiGroupRes;
	{_x setVariable ['GRLIB_can_speak', true, true]} foreach units _aiGroupRes;

	GRLIB_A3W_Mission_MRR = _aiGroupRes;
	publicVariable "GRLIB_A3W_Mission_MRR";
	_missionHintText = format [localize "STR_RESISTANCE_MESSAGE1", sideMissionColor, _townName];
	A3W_sectors_in_use = A3W_sectors_in_use + [_missionLocation];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilSuccessCondition = {
	_ret = false;
	if (!isnil "GRLIB_A3W_Mission_MR") then {
		private _opf = 0;
		{
			_opf = _opf + count (units _x select { alive _x && (_x distance2D _missionPos < (GRLIB_sector_size * 2) || !isNull objectParent _x) })
		} forEach GRLIB_A3W_Mission_MR;
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
	_failedHintMessage = format [localize "STR_RESISTANCE_MESSAGE2", sideMissionColor, _townName];
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_successExec = {
	// Mission completed
	{ 	_x setVariable ["R3F_LOG_disabled", false, true];
		_x setVariable ["GRLIB_vehicle_owner", nil, true];
	} forEach [_box1, _box2];
	_successHintMessage = format [localize "STR_RESISTANCE_MESSAGE3", sideMissionColor, _townName];
	{ deleteVehicle _x } forEach [_tent1, _chair1, _chair2, _fire1, _veh1, _veh2];
	{ deleteVehicle _x } forEach units _aiGroupRes;
	GRLIB_A3W_Mission_MR = nil;
	publicVariable "GRLIB_A3W_Mission_MR";
	GRLIB_A3W_Mission_MRR = nil;
	publicVariable "GRLIB_A3W_Mission_MRR";

	for "_i" from 1 to (selectRandom [1,2]) do {
		_pos = _missionPos vectorAdd [([[-50,0,50], 20] call F_getRND), ([[-50,0,50], 20] call F_getRND), 0];
		[ammobox_i_typename, _pos, false] call boxSetup;
	};
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_this call sideMissionProcessor;
