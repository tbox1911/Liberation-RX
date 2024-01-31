/*
  pSiKO AI Revive - v3.05 - SP/MP - AI
  aka: PAR Revive

Author:

	[AKH] pSiKO

Description:

	give ablitty to ai to revive player or other ai
  unit sharing the same PAR_Grp_ID revive each others

Instructions:

	ExecVM from init.sqf in your mission directory.
  [] execVM "addons\PAR\PAR_AI_Revive.sqf";

Based on:
  AI REVIVE HEAL SCRIPT SP/MP by Pierre MGI
  at : https://forums.bohemia.net/forums/topic/207522-ai-revive-heal-script-spmp/

  Farooq's Revive by farooqaaa
  at : https://forums.bohemia.net/forums/topic/146926-farooqs-revive/
_________________________________________________________________________*/

if (!isDedicated && !hasInterface && isMultiplayer) exitWith {};
if (isDedicated) exitWith {
  // PAR Remote Call - Server Side
  PAR_remote_bounty = compileFinal preprocessFileLineNumbers "addons\PAR\server\PAR_remote_bounty.sqf";
  PAR_remote_sortie = compileFinal preprocessFileLineNumbers "addons\PAR\server\PAR_remote_sortie.sqf";
};

// Init functions
[] call compile preprocessFile "addons\TKP\tk_init.sqf";
[] call compile preprocessFile "addons\PAR\PAR_global_functions.sqf";

// Seconds until unconscious unit bleeds out and dies.
PAR_BleedOut = 300;
PAR_BleedOutExtra = 60;

// Enable info killer message
PAR_EnableDeathMessages = true;

// player AI brothers
PAR_AI_bros = [];

//------------------------------------------//
PAR_BloodSplat = [
  "BloodPool_01_Large_New_F",
  "BloodPool_01_Medium_New_F",
  "BloodSplatter_01_Large_New_F",
  "BloodSplatter_01_Medium_New_F",
  "BloodSplatter_01_Small_New_F"
];

PAR_MedGarbage = [
  "MedicalGarbage_01_3x3_v1_F",
  "MedicalGarbage_01_3x3_v2_F"
];

PAR_graves = [
	"Land_Grave_rocks_F",
	"Land_Grave_forest_F",
	"Land_Grave_dirt_F"
];

PAR_grave_box = "Land_PlasticCase_01_small_black_F";

waituntil {sleep 1; !isNil "GRLIB_player_spawned"};
waituntil {sleep 1; GRLIB_player_spawned};
waituntil {sleep 1; !isNil {player getVariable ["GRLIB_Rank", nil]}};

// Init player
[] call PAR_Player_Init;

// Init player EH
[player] call PAR_EventHandler;

// Grave Marker
_marker = createMarkerLocal ["player_grave_box", markers_reset];
_marker setMarkerShapeLocal "ICON";
_marker setMarkerTypeLocal "KIA";
_marker setMarkerTextlocal format ["%1's Grave.", name player];

// Grave Box
PAR_grave_box = createVehicle [PAR_grave_box, ([] call F_getFreePos), [], 0, "NONE"];
[PAR_grave_box, playerbox_cargospace] remoteExec ["setMaxLoad", 2];
PAR_grave_box allowDamage false;
PAR_grave_box enableSimulationGlobal false;
PAR_grave_box setVariable ["R3F_LOG_disabled", true, true];
PAR_grave_box setVariable ["GRLIB_vehicle_owner", PAR_Grp_ID, true];
player setvariable ["PAR_grave_box", PAR_grave_box, true];

// Grave Name
addMissionEventHandler ["Draw3D",{
	private _near_grave = nearestObjects [player, PAR_graves, 2];
	if (count (_near_grave) > 0) then {
		private _grave = _near_grave select 0;
		private _grave_pos = ASLToAGL getPosASL _grave;
		drawIcon3D [getMissionPath "res\skull.paa", [1,1,1,1], _grave_pos vectorAdd [0, 0, 1], 2, 2, 0, (_grave getVariable ["PAR_grave_message", ""]), 2, 0.05, "RobotoCondensed", "center"];
	};
}];

// AI Manager
[] spawn PAR_AI_Manager;

// Action Manager
[] spawn PAR_ActionManager;

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- pSiKo AI Revive Initialized --------";
