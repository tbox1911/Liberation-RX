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

if (!hasInterface) exitWith {};

// Init functions
[] call compile preprocessFileLineNumbers "addons\TKP\tk_init.sqf";
[] call compile preprocessFileLineNumbers "addons\PAR\PAR_global_functions.sqf";

// Seconds until unconscious unit bleeds out and dies.
// PAR_bleedout = 300;    // from settings
PAR_bleedout_extra = 60;

// Enable info killer message
PAR_EnableDeathMessages = true;

// player AI brothers
PAR_AI_bros = [];
// PAR_AI_reviveMax = 7;    // from settings
PAR_AI_recover_revive = (20*60);

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

// PAR_grave_box_typename = "Land_PlasticCase_01_small_black_F";
// PAR_Medikit = "Medikit";
// PAR_AidKit = "FirstAidKit";

// Grave Box
PAR_grave_box = createVehicle [PAR_grave_box_typename, ([] call F_getFreePos), [], 0, "NONE"];
[PAR_grave_box, playerbox_cargospace] remoteExec ["setMaxLoad", 2];
PAR_grave_box allowDamage false;
PAR_grave_box enableSimulationGlobal false;
PAR_grave_box setVariable ["R3F_LOG_disabled", true, true];
PAR_grave_box setVariable ["GRLIB_vehicle_owner", PAR_Grp_ID, true];
player setvariable ["PAR_grave_box", PAR_grave_box, true];
PAR_backup_loadout = [];
PAR_weapons_state = ["", "", ""];

// Grave Marker
_marker = createMarkerLocal ["PAR_grave_box_marker", markers_reset];
_marker setMarkerShapeLocal "ICON";
_marker setMarkerTypeLocal "KIA";
_marker setMarkerTextlocal format ["%1's Grave.", name player];

// Init player
[player] call PAR_Player_Init;

// Init player EH
[player] call PAR_EventHandler;

waituntil {sleep 1; !isNil {player getVariable ["GRLIB_Rank", nil]}};

// AI Manager
[] spawn PAR_AI_Manager;

// Action Manager
[] spawn PAR_ActionManager;

// Grave Name
addMissionEventHandler ["Draw3D",{
	private _near_grave = nearestObjects [player, PAR_graves, 2];
	if (count (_near_grave) > 0) then {
		private _grave = _near_grave select 0;
		private _grave_pos = ASLToAGL getPosASL _grave;
		drawIcon3D [getMissionPath "res\skull.paa", [1,1,1,1], _grave_pos vectorAdd [0, 0, 1], 2, 2, 0, (_grave getVariable ["PAR_grave_message", ""]), 2, 0.05, "RobotoCondensed", "center"];
	};
}];

waitUntil {!(isNull (findDisplay 46))};
systemChat localize "STR_PAR_AI_REVIVE_INITIALIZED";
