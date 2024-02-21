if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_nbUnits", "_box1", "_box2", "_box3"];

_setupVars =
{
	_missionType = "STR_AIRWRECK";
	_locationsArray = [SpawnMissionMarkers] call checkSpawn;
	_nbUnits = [] call getNbUnits;
};

_setupObjects =
{
	_missionPos = [(markerpos _missionLocation)] call F_findSafePlace;
	if (count _missionPos == 0) exitWith { 
    	diag_log format ["--- LRX Error: side mission AW, cannot find spawn point!"];
    	false;
	};
	_vehicle = createVehicle [GRLIB_sar_wreck, _missionPos, [], 0, "NONE"];
	_vehicle allowDamage false;
	_vehicle setpos (getpos _vehicle);
	_box1 = [ammobox_b_typename, _missionPos, true] call boxSetup;
	_box2 = [ammobox_b_typename, _missionPos, true] call boxSetup;
	_box3 = [basic_weapon_typename, _missionPos, true] call boxSetup;

	[_missionPos, 30] call createlandmines;
	_aiGroup = [_missionPos, _nbUnits, "infantry"] call createCustomGroup;

	_missionPicture = "\A3\Air_F\Heli_Light_02\Data\UI\Heli_Light_02_CA.paa";
	_missionHintText = "STR_AIRWRECK_MESSAGE1";
	A3W_sectors_in_use = A3W_sectors_in_use + [_missionLocation];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = nil;

_failedExec = {
	// Mission failed
	{ deleteVehicle _x } forEach [_box1, _box2, _box3];
	[_missionPos] call clearlandmines;
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_successExec = {
	// Mission completed
	{ [_x, "abandon"] call F_vehicleLock } forEach [_box1, _box2, _box3];

	_successHintMessage = "STR_AIRWRECK_MESSAGE2";
	[_missionPos] spawn {
		params ["_pos"];
		[_pos] call showlandmines;
		sleep 300;
		[_pos] call clearlandmines;
	};
	A3W_sectors_in_use = A3W_sectors_in_use - [_missionLocation];
};

_this call sideMissionProcessor;
