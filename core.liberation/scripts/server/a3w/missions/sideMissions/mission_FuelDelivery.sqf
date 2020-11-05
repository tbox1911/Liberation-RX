// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: mission_FuelDelivery.sqf

if (!isServer) exitwith {};
if (!isNil "GRLIB_A3W_Mission_MR") exitWith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_townName","_buildingpositions", "_man1", "_marker_zone"];

_setupVars =
{
	_missionType = "Fuel Delivery";
	_missionLocation = selectRandom ((blufor_sectors select {["capture_", _x] call fn_startsWith;}) apply {[_x, false]}) select 0 ;
	_townName = markerText _missionLocation;
	_ignoreAiDeaths = true;
	_locationsArray = nil;
};

_setupObjects =
{
	_missionPos = (markerPos _missionLocation vectorAdd [([[-50,0,50], 20] call F_getRND), ([[-50,0,50], 20] call F_getRND), 0]);
	_mission_grp = createGroup [GRLIB_side_civilian, true];
	_man1 = _mission_grp createUnit ["C_Story_Mechanic_01_F", _missionPos, [], 0, "NONE"];
	_man1 setVariable ['GRLIB_can_speak', true, true];
	_man1 setVariable ['GRLIB_A3W_Mission_DF', true, true];
	_man1 allowDamage false;
	_man1 disableAI "Move";

	_marker_zone = createMarker ["A3W_Mission_DF", _missionPos];
	_marker_zone setMarkerColor "ColorCivilian";
	_marker_zone setMarkerShape "ELLIPSE";
	_marker_zone setMarkerBrush "FDiagonal";
	_marker_zone setMarkerSize [20,20];

	_missionHintText = format ["Fuel Delivery at <br/><t size='1.25' color='%1'>%2</t><br/><br/><t color='#00F000'>Talk</t> to the <t color='#0000F0'>Marshal</t> to get information.", sideMissionColor, _townName];
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_waitUntilSuccessCondition = {
	_ret = false;
	private _barrels = [_man1 nearEntities [fuelbarrel_typename, 20], {isNull R3F_LOG_joueur_deplace_objet && isNil {_x getVariable "R3F_LOG_objets_charges"} && !(_x getVariable ['R3F_LOG_disabled', false])}] call BIS_fnc_conditionalSelect;
	if (count _barrels == 3) then {
		{ deleteVehicle _x } forEach _barrels;
		_ret = true;
	};
	_ret;
 };

_failedExec = {
	// Mission failed
	deleteVehicle _man1;
	deleteMarker _marker_zone;
	_failedHintMessage = format ["Fuel Delivery has...<br/><t color='%1'>FAILED</t> !!<br/><br/>Better luck next time!", sideMissionColor, _townName];
};

_successExec = {
	// Mission completed
	_successHintMessage = format ["Fuel Delivery<br/><t color='%1'>SUCCESS</t> !!<br/><br/>The Barrels of Fuel have been delivered, Well done.", sideMissionColor];
	[ammobox_i_typename, _missionPos, false] call boxSetup;
	deleteVehicle _man1;
	deleteMarker _marker_zone;
};

_this call sideMissionProcessor;
