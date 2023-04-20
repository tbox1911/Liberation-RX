// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: sideMissionProcessor.sqf
//	@file Author: AgentRev
//	LRX Integration: pSiKO

#define MISSION_PROC_TYPE_NAME "Side"
#define MISSION_PROC_TIMEOUT 60*60  // Time in seconds that a Side Mission will run for, unless completed
#define MISSION_PROC_COLOR_DEFINE sideMissionColor

#include "sideMissions\sideMissionDefines.sqf"
#include "missionProcessor.sqf";
