if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_targetPos", "_vehicleName", "_smoke"];

_setupVars = {
	_missionType = "STR_VEHICLEREP";
	_locationsArray = [LRX_MissionMarkersMil] call checkSpawn;
	_ignoreAiDeaths = true;	
	// _nbUnits = [] call getNbUnits;
	// _missionTimeout = (30 * 60);
};

_setupObjects = {
	private _opfor_tank = selectRandom (opfor_vehicles select { _x isKindOf "Tank_F" });
	if (isNil "_opfor_tank") exitWith {
		diag_log format ["--- LRX Error: side mission %1, cannot find vehicle classname!", localize _missionType];
		false;
	};

	// find road
	_missionPos = [];
	_targetPos = markerpos _missionLocation;
	private	_found = false;
	private _idx = 200;
	while {!_found && _idx > 0} do {
		private _pos_check = ([_targetPos, GRLIB_sector_size] call F_getRandomPos);
		if (isOnRoad _pos_check) then {
			_missionPos = _pos_check;
			_found = true;
		};
		_idx = _idx - 1;
	};
	if (count _missionPos == 0) exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
    	false;
	};

	_vehicle = [_missionPos, _opfor_tank, 5, false, GRLIB_side_firendly, false, true] call F_libSpawnVehicle;
	[_vehicle, "lock", "server"] call F_vehicleLock;
	_vehicle setFuel 1;
	_vehicle setVehicleAmmo 0;
	_vehicle setHitPointDamage ["HitEngine", 1, false];
	_smoke = GRLIB_sar_fire createVehicle (getPos _vehicle);
	_smoke attachTo [_vehicle, [0, 1.5, 0]];

	// [_missionPos, 30] call createlandmines;
	// _aiGroup = [_missionPos, _nbUnits, "infantry"] call createCustomGroup;

	_missionPicture = getText (configOf _vehicle >> "picture");
	_vehicleName = getText (configOf _vehicle >> "displayName");
	_missionHintText = ["STR_VEHICLECAP_MESSAGE1", _vehicleName, sideMissionColor];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = { !(alive _vehicle) };

_failedExec = {
	// Mission failed
	deleteVehicle _smoke;
	[_missionPos] call clearlandmines;
};

_successExec = {
	// Mission completed
	{deleteVehicle _x} forEach (crew _vehicle);
	[_vehicle, "abandon"] call F_vehicleLock;
	deleteVehicle _smoke;
	_successHintMessage = ["STR_VEHICLECAP_MESSAGE2", _vehicleName];
	[_missionPos] spawn {
		params ["_pos"];
		[_pos] call showlandmines;
		sleep 300;
		[_pos] call clearlandmines;
	};
};

_this call sideMissionProcessor;
