// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_SpecialDelivery.sqf

if (!isServer) exitwith {};
if (!isNil "GRLIB_A3W_Mission_SD") exitWith {};
#include "sideMissionDefines.sqf"

private ["_townName",
		"_missionPos2", "_missionPos3", "_missionPosEnd",
		"_missionPosEnd", "_mission_grp", "_house"];

_setupVars =
{
	_missionType = "Special Delivery";
	_ignoreAiDeaths = true;
	_locationsArray = nil;
};

_setupObjects =
{
	// settings for this mission
	_missionLocation  = selectRandom ((blufor_sectors select {["capture_", _x] call F_startsWith}) apply {[_x, false]}) select 0;
	if (!isNil "_missionLocation") then {
		_missionPos  = (markerPos _missionLocation vectorAdd [([[-100,0,100], 20] call F_getRND), ([[-100,0,100], 20] call F_getRND), 0]);
		_townName = markerText _missionLocation;
		_missionPicture = getText (configFile >> "CfgVehicles" >> "C_Hatchback_01_F" >> "picture");
		_missionHintText = format ["Special Delivery at <br/><t size='1.25' color='%1'>%2</t><br/><br/><t color='#00F000'>Talk</t> to <t color='#0000F0'>Nikos</t> to get information.<br/>Be ready for any situation!", sideMissionColor, _townName];
		_missionLocation2 = selectRandom ((blufor_sectors select {["capture_", _x] call F_startsWith && (markerPos _x) distance2D (markerPos _missionLocation) > 500 && (markerPos _x) distance2D (markerPos _missionLocation) < 3000 }) apply {[_x, false]}) select 0;
		if (!isNil "_missionLocation2") then {
			_missionPos2 = (markerPos _missionLocation2 vectorAdd [([[-100,0,100], 20] call F_getRND), ([[-100,0,100], 20] call F_getRND), 0]);
			_missionLocation3 = selectRandom ((blufor_sectors select {["capture_", _x] call F_startsWith && (markerPos _x) distance2D (markerPos _missionLocation2) > 500 && (markerPos _x) distance2D (markerPos _missionLocation2) < 3000}) apply {[_x, false]}) select 0;
			if (!isNil "_missionLocation3") then {
				_missionPos3 = (markerPos _missionLocation3 vectorAdd [([[-100,0,100], 20] call F_getRND), ([[-100,0,100], 20] call F_getRND), 0]);
				_missionLocationEnd = (selectRandom ((SpawnMissionMarkers select {(markerPos (_x select 0)) distance2D (markerPos _missionLocation3) > 500 && (markerPos (_x select 0)) distance2D (markerPos _missionLocation3) < 4000}) apply {[_x, false]}) select 0) select 0;
				if (!isNil "_missionLocationEnd") then {
					_missionPosEnd = (markerPos _missionLocationEnd vectorAdd [([[-100,0,100], 20] call F_getRND), ([[-100,0,100], 20] call F_getRND), 0]);
				};
			};
		};
	};

	if (isnil "_missionPos" || isnil "_missionPos2" || isnil "_missionPos3" || isnil "_missionPosEnd") exitWith {
		gamelogic globalChat "Initialize Side Mission Error !!";
		GRLIB_A3W_Mission_SD = [];
		publicVariable "GRLIB_A3W_Mission_SD";
	};

	// create Nikos units
	_mission_grp = createGroup [GRLIB_side_civilian, true];
	_man1 = _mission_grp createUnit ["C_Nikos", _missionPos, [], 0, "NONE"];
	_man2 = _mission_grp createUnit ["C_Orestes", _missionPos2, [], 0, "NONE"];
	_man3 = _mission_grp createUnit ["C_Orestes", _missionPos3, [], 0, "NONE"];
	_man4 = _mission_grp createUnit ["C_Nikos_aged", _missionPosEnd, [], 0, "NONE"];

	GRLIB_A3W_Mission_SD = [_man1, _man2, _man3, _man4];
	publicVariable "GRLIB_A3W_Mission_SD";

	{
		_x setVariable ['GRLIB_can_speak', true, true];
		_x setVariable ['GRLIB_A3W_Mission_SD', true, true];
		_x allowDamage false;
		_x disableAI "MOVE";
		_x disableAI "ANIM";
		_x removeAllEventHandlers "AnimDone";
		_x addEventHandler [ "AnimDone", {
		params[ "_unit", "_anim" ];
			if ( _anim == "LHD_krajPaluby" ) then { _unit switchMove "LHD_krajPaluby" };
		}];
		sleep 1;
		[_x,"LHD_krajPaluby"] remoteExec ["switchMove"];
	} forEach GRLIB_A3W_Mission_SD;

	_man4 enableAI "Cover";
	_house = createVehicle ["Land_i_House_Small_01_V1_F", _missionPosEnd, [], 2, "None"];
	_man4 setPosATL (getposATL _house);

	_marker = createMarker ["side_mission_A3W_Mission_SD", _missionPosEnd];
	_marker setMarkerShape "ICON";
	_marker setMarkerType "Empty";

};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = { count GRLIB_A3W_Mission_SD != 4 };

_waitUntilSuccessCondition = {
	_ret = false;
	if (!isnil "GRLIB_A3W_Mission_SD" && count GRLIB_A3W_Mission_SD == 4 ) then {
		_last_man = GRLIB_A3W_Mission_SD select (count GRLIB_A3W_Mission_SD) - 1;
		if (_last_man getVariable ["GRLIB_A3W_Mission_SD_END", false]) then { _ret = true};
	};
	_ret;
 };

_failedExec = {
	// Mission failed
	deleteMarker "side_mission_A3W_Mission_SD";
	if (!isNil "_house") then {deleteVehicle _house};
	{ deleteVehicle _x } forEach GRLIB_A3W_Mission_SD;
	GRLIB_A3W_Mission_SD = nil;
	publicVariable "GRLIB_A3W_Mission_SD";
	[player, ["GRLIB_A3W_Mission_Marker", nil]] remoteExec ["setVariable", -2];
	_failedHintMessage = format ["Special Delivery<br/><t color='%1'>FAILED</t> !!<br/><br/>Better luck next time!", sideMissionColor];
};

_successExec = {
	// Mission completed
	deleteMarker "side_mission_A3W_Mission_SD";
	[_house] spawn {
		params ["_house"];
		sleep 60;
		{ deleteVehicle _x } forEach GRLIB_A3W_Mission_SD;
		GRLIB_A3W_Mission_SD = nil;
		publicVariable "GRLIB_A3W_Mission_SD";
		sleep 60;
		deleteVehicle _house;
	};
	_successHintMessage = format ["Special Delivery<br/><t color='%1'>SUCCESS</t> !!<br/><br/>The information have been collected, Well done.", sideMissionColor];

	private _nb = selectRandom [1,2];
	for "_i" from 1 to _nb do {
		[ammobox_i_typename, _missionPosEnd, false] call boxSetup;
		sleep 0.2;
	};
};

_this call sideMissionProcessor;
