/*
     pSiKO AI Revive - v2.04 - SP/MP - AI

Author:

	[AKH] pSiKO

Description:

	give ablitty to ai to revive player or other ai
  unit sharing the same PAR_Grp_ID revive each others

Instructions:

	ExecVM from initclient.sqf or init.sqf in your mission directory.

Based on: AI REVIVE HEAL SCRIPT SP/MP by Pierre MGI

  at : https://forums.bohemia.net/forums/topic/207522-ai-revive-heal-script-spmp/

_________________________________________________________________________*/
if (isDedicated) exitWith {};

PAR_isDragging = false;
PAR_deathMessage = [];
PAR_tkMessage = [];

call compile preprocessFile "addons\TKP\tk_init.sqf";
call compile preprocessFile "addons\PAR\PAR_global_functions.sqf";

// Seconds until unconscious unit bleeds out and dies.
PAR_BleedOut = 300;
PAR_BleedOutExtra = 60;

// Enable info killer message
PAR_EnableDeathMessages = true;
PAR_ReviveMode = ( GRLIB_revive - 1 );
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

waituntil {sleep 0.5;!isNull player && GRLIB_player_spawned};
waituntil {sleep 0.5;!isNil {player getVariable ["GRLIB_Rank", nil]}};

[] spawn PAR_AI_Manager;
[] spawn PAR_Player_Init;

// Public event handlers
"PAR_deathMessage" addPublicVariableEventHandler PAR_public_EH;
"PAR_tkMessage" addPublicVariableEventHandler PAR_public_EH;

// Event Handlers
player addEventHandler ["Respawn", {[] spawn PAR_Player_Init}];

waitUntil {!(isNull (findDisplay 46))};
systemChat "-------- pSiKo AI Revive Initialized --------";
