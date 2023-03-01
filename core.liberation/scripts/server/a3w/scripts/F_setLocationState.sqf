// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: setLocationState.sqf
//	@file Author: AgentRev

#define MISSION_LOCATION_COOLDOWN (30*60)

params ["_locArray", "_locName", "_locState"];

{
	if (_x select 0 == _locName) exitWith {
		_x set [1, _locState];
		_x set [2, round (time + MISSION_LOCATION_COOLDOWN)];
	};
} forEach _locArray;
