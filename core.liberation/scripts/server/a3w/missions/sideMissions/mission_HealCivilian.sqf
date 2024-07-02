if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_location_name", "_objects", "_grp_medic", "_grp_wnded"];

_setupVars = {
	_missionType = "STR_HEAL_CIV";
	_missionLocation = [sectors_capture] call getMissionLocation;
	_locationsArray = nil;
	_ignoreAiDeaths = true;
	//_nbUnits = AI_GROUP_MEDIUM;
};

_setupObjects = {
	_missionPos = [(markerpos _missionLocation)] call F_findSafePlace;
	if (count _missionPos == 0) exitWith {
    	diag_log format ["--- LRX Error: side mission HCiv, cannot find spawn point!"];
    	false;
	};
	_location_name = [_missionPos] call F_getLocationName;

	private _medic = [
		"C_IDAP_Man_AidWorker_06_F",
		"C_IDAP_Man_AidWorker_07_F",
		"C_IDAP_Man_AidWorker_09_F",
		"C_IDAP_Man_Paramedic_01_F",
		"C_scientist_F"
	];

	private _garbage = [
		"Land_PaperBox_01_small_closed_white_IDAP_F",
		"Land_PaperBox_01_small_closed_brown_IDAP_F",
		"Land_PortableCabinet_01_medical_F",
		"Land_GarbageBags_F",
        "Land_GarbagePallet_F",
		"Land_CampingChair_V1_F",
		"Land_CampingChair_V1_folded_F",
		"Land_CampingTable_white_F",
		"Land_CampingTable_small_F",
		"MedicalGarbage_01_Bandage_F",
		"MedicalGarbage_01_Injector_F",
		"MedicalGarbage_01_Packaging_F",
		"MedicalGarbage_01_Gloves_F",
		"MedicalGarbage_01_FirstAidKit_F",
		"MedicalGarbage_01_1x1_v3_F",
		"MedicalGarbage_01_3x3_v1_F",
		"MedicalGarbage_01_3x3_v2_F",
		"MedicalGarbage_01_5x5_v1_F"
	];

	//----- build medical Tent ---------------------------------
	private _dir = random 360;
	private _max = 100;
	private _pos = [];
	private _start_pos = _missionPos;
	while { count _pos == 0 && _max > 0 } do {
		_pos = _start_pos findEmptyPosition [10, 200, "B_Heli_Transport_01_F"];
		if (isOnRoad _pos || surfaceIsWater _pos) then {
			_pos = [];
		};
		_max = _max - 1;
		_start_pos = _missionPos getPos [100, random 360];
		sleep 0.1;
	};
	if (count _pos == 0) exitWith {
		diag_log format ["--- LRX Error: side mission HC, cannot find spawn point!"];
		false;
	};

	_missionPos = _pos;
	_tent = createVehicle [a3w_heal_tent, _missionPos, [], 1, "None"];
	_tent allowDamage false;
	_tent setVectorDirAndUp [[-cos _dir, sin _dir, 0] vectorCrossProduct surfaceNormal _missionPos, surfaceNormal _missionPos];
	_vehicle = _tent;
	sleep 0.2;

	_tent_pos = getPosATL _tent;
	// add garbage
	_objects = [];
	for "_i" from 1 to 12 do {
		_grbg = createVehicle [selectRandom _garbage, _tent_pos, [], 15, "None"];
		_dir = random 360;
		_grbg setVectorDirAndUp [[-cos _dir, sin _dir, 0] vectorCrossProduct surfaceNormal _missionPos, surfaceNormal _missionPos];
		_grbg setVariable ["R3F_LOG_disabled", true, true];
		_grbg enableSimulationGlobal false;
		_objects pushBack _grbg;
		sleep 0.2;
	};

	// add medic + patrol
	_grp_medic = [_tent_pos, 3, "medics", true, 20] call createCustomGroup;
	{
		_x setVariable ["GRLIB_can_speak", true, true];
		_x setVariable ["GRLIB_A3W_Mission_HC1", true, true];
		_x setVariable ["GRLIB_vehicle_owner", "server", true];
		_x setVariable ["acex_headless_blacklist", true, true];
	} forEach (units _grp_medic);

	// add wounded
	_grp_wnded = createGroup [GRLIB_side_civilian, true];
	for "_i" from 1 to 5 do {
		_unit = _grp_wnded createUnit [(selectRandom civilians), _missionPos, [], 100, "NONE"];
		[_unit] joinSilent _grp_wnded;
		_unit setVariable ["GRLIB_can_speak", true, true];
		_unit setVariable ["GRLIB_A3W_Mission_HC2", true, true];
		_unit setVariable ["GRLIB_vehicle_owner", "server", true];
		_unit setVariable ["acex_headless_blacklist", true, true];
		_unit addMPEventHandler ["MPKilled", {_this spawn kill_manager}];
		removeAllAssignedItems _unit;
		_unit addHeadgear "H_HeadBandage_bloody_F";
		_unit addGoggles "G_Respirator_white_F";
		_unit setDamage 0.50;
		_unit stop true;
		_unit disableAI "ANIM";
		_unit disableAI "MOVE";
		_anim = "AmovPercMstpSnonWnonDnon_AmovPsitMstpSnonWnonDnon_ground";
		_unit switchMove _anim;
		_unit playMoveNow _anim;
		sleep 0.2;
	};
	_grp_wnded setSpeedMode "LIMITED";
	_grp_wnded setBehaviourStrong "CARELESS";
	_grp_wnded setCombatMode "GREEN";

	_missionHintText = ["STR_HEAL_CIV_MESSAGE1", sideMissionColor, _location_name];
	true;
};

_waitUntilMarkerPos = nil;
_waitUntilExec = nil;
_waitUntilCondition = { ({ alive _x } count (units _grp_wnded) == 0) };
_waitUntilSuccessCondition = {
	private _alive_wnded = { alive _x } count (units _grp_wnded);
	if (_alive_wnded == 0) exitWith { false };
	private _rescued = { alive _x && isNil {_x getVariable "GRLIB_A3W_Mission_HC2"} } count (units _grp_wnded);
	(_rescued == _alive_wnded);
};

_failedExec = {
	// Mission failed
	{ [_x, -5] call F_addReput } forEach (AllPlayers - (entities "HeadlessClient_F"));
	{ deleteVehicle _x } forEach (units _grp_medic);
	{ deleteVehicle _x } forEach (units _grp_wnded);
	{ deleteVehicle _x } forEach (_objects);
	_successHintMessage = "STR_HEAL_CIV_MESSAGE3";
};

_successExec = {
	// Mission complete
	{ deleteVehicle _x } forEach (units _grp_medic);
	{ deleteVehicle _x } forEach (units _grp_wnded);
	{ deleteVehicle _x } forEach (_objects);
	{ [_x, 5] call F_addReput } forEach (AllPlayers - (entities "HeadlessClient_F"));
	_successHintMessage = "STR_HEAL_CIV_MESSAGE2";
};

_this call sideMissionProcessor;
