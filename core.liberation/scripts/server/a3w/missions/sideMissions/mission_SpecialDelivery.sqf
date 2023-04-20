// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_SpecialDelivery.sqf

if (!isServer) exitwith {};
if (!isNil "GRLIB_A3W_Mission_SD") exitWith {};
#include "sideMissionDefines.sqf"

private ["_missionPos", "_missionPos2", "_missionPos3", "_missionPosEnd", "_mission_grp"];

_setupVars =
{
	_missionType = "Special Delivery";
	_ignoreAiDeaths = true;
	_locationsArray = nil;
};

_setupObjects =
{
	private _missionEnd = selectRandom ([SpawnMissionMarkers, { ([markerpos _x] call F_getNearestBluforObjective) select 1 > GRLIB_sector_size }] call BIS_fnc_conditionalSelect) select 0;
	if (!isNil "_missionEnd") then {	
		private _missionLocationList = [blufor_sectors, {(_x select [0,8]) == "capture_" && (markerpos _x) distance2D (markerpos _missionEnd) < 5000 }] call BIS_fnc_conditionalSelect;
		if (count _missionLocationList >= 3) then {
			_m1 = selectRandom _missionLocationList;
			_missionPicture = getText (configFile >> "CfgVehicles" >> "C_Hatchback_01_F" >> "picture");
			_missionHintText = format ["Special Delivery at <br/><t size='1.25' color='%1'>%2</t><br/><br/><t color='#00F000'>Talk</t> to <t color='#0000F0'>Nikos</t> to get information.<br/>Be ready for any situation!", sideMissionColor, markerText _m1];
			_missionPos = (markerPos _m1 vectorAdd [([[-100,0,100], 20] call F_getRND), ([[-100,0,100], 20] call F_getRND), 0]);
			_missionLocationList = _missionLocationList - [ _m1 ];

			_m1 = selectRandom _missionLocationList;
			_missionPos2 = (markerPos _m1 vectorAdd [([[-100,0,100], 20] call F_getRND), ([[-100,0,100], 20] call F_getRND), 0]);
			_missionLocationList = _missionLocationList - [ _m1 ];

			_m1 = selectRandom _missionLocationList;
			_missionPos3 = (markerPos _m1 vectorAdd [([[-100,0,100], 20] call F_getRND), ([[-100,0,100], 20] call F_getRND), 0]);

			_missionPosEnd = (markerpos _missionEnd);
		};
	};

	if (isnil "_missionPos" || isnil "_missionPos2" || isnil "_missionPos3" || isnil "_missionPosEnd") exitWith {
		diag_log format ["--- LRX Error: side mission SD, cannot find location from marker %1", _missionEnd];
		GRLIB_A3W_Mission_SD = [];
		publicVariable "GRLIB_A3W_Mission_SD";
	};

	// create Nikos units
	private _mission_grp = createGroup [GRLIB_side_civilian, true];
	private _man1 = _mission_grp createUnit ["C_Nikos", _missionPos, [], 0, "NONE"];
	private _man2 = _mission_grp createUnit ["C_Orestes", _missionPos2, [], 0, "NONE"];
	private _man3 = _mission_grp createUnit ["C_Orestes", _missionPos3, [], 0, "NONE"];
	private _man4 = _mission_grp createUnit ["C_Nikos_aged", _missionPosEnd, [], 0, "NONE"];

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
	private _house = createVehicle ["Land_i_House_Small_01_V1_F", _missionPosEnd, [], 2, "None"];
	_man4 setPosATL (getposATL _house);

	private _marker = createMarker ["side_mission_A3W_Mission_SD", _missionPosEnd];
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

	for "_i" from 1 to (selectRandom [1,2]) do {
		[ammobox_i_typename, _missionPosEnd, false] call boxSetup;
		sleep 0.2;
	};
};

_this call sideMissionProcessor;
