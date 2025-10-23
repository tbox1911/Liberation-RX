if (!isServer) exitwith {};
#include "sideMissionDefines.sqf"

private ["_location_name", "_grp_wnded"];

_setupVars = {
	_missionType = "STR_HEAL_CIV";
	_locationsArray = [LRX_MissionMarkersCap] call checkSpawn;
	_ignoreAiDeaths = true;
};

_setupObjects = {
	_missionPos = [(markerpos _missionLocation), 5, 0] call F_findRandomPlace;
	if (count _missionPos == 0) exitWith {
    	diag_log format ["--- LRX Error: side mission %1, cannot find spawn point!", localize _missionType];
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
	_missionPos = ([_missionPos, 100] call F_getRandomPos);
	private _pos = [_missionPos, 7, 0, 80] call F_findSafePlace;
	if (count _pos == 0) exitWith {
		diag_log format ["--- LRX Error: side mission %1, cannot create buildings at %2!", localize _missionType, _missionPos];
		false;
	};

	private _dir = random 360;
	_vehicle = createVehicle [a3w_heal_tent, _pos, [], 0, "None"];
	_vehicle allowDamage false;
	_vehicle setVectorDirAndUp [[-cos _dir, sin _dir, 0] vectorCrossProduct surfaceNormal _pos, surfaceNormal _pos];
	_missionPos = _pos;
	sleep 0.2;

	// add garbage
	_vehicles = [];
	for "_i" from 1 to 12 do {
		_grbg = createVehicle [selectRandom _garbage, _pos, [], 15, "None"];
		_dir = random 360;
		_grbg setVectorDirAndUp [[-cos _dir, sin _dir, 0] vectorCrossProduct surfaceNormal _missionPos, surfaceNormal _missionPos];
		_grbg setVariable ["R3F_LOG_disabled", true, true];
		_grbg enableSimulationGlobal false;
		_vehicles pushBack _grbg;
		sleep 0.2;
	};

	// add medic + patrol
	_aiGroup = [_pos, 3, "medics", true, 20] call createCustomGroup;
	{
		_x setVariable ["GRLIB_can_speak", true, true];
		_x setVariable ["GRLIB_A3W_Mission_HC1", true, true];
	} forEach (units _aiGroup);

	// add wounded
	_grp_wnded = createGroup [GRLIB_side_civilian, true];
	for "_i" from 1 to 5 do {
		_unit = _grp_wnded createUnit [(selectRandom civilians), _missionPos, [], 100, "NONE"];
		[_unit] joinSilent _grp_wnded;
		if (_unit distance2D _pos <= 30) then {
			_unit setPos ([_pos, 50] call F_getRandomPos);
		};
		_unit setVariable ["GRLIB_can_speak", true, true];
		_unit setVariable ["GRLIB_A3W_Mission_HC2", true, true];
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
	private _msg = format [localize "STR_SIDE_FAILED_REPUT", -5];
	[gamelogic, _msg] remoteExec ["globalChat", 0];
	{ deleteVehicle _x } forEach (units _grp_wnded);
	_failedHintMessage = "STR_HEAL_CIV_MESSAGE3";
};

_successExec = {
	// Mission complete
	{ deleteVehicle _x } forEach (units _grp_wnded);
	{ [_x, 5] call F_addReput } forEach (AllPlayers - (entities "HeadlessClient_F"));
	_successHintMessage = "STR_HEAL_CIV_MESSAGE2";
};

_this call sideMissionProcessor;
