// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: masterController.sqf
//	@file Author: AgentRev

// Compile mission processors
missionNamespace setVariable ["sideMissionProcessor",  compileFinal preprocessFileLineNumbers ("scripts\server\a3w\missions\sideMissionProcessor.sqf")];

for "_i" from 1 to 3 do {
	// Start Permanent controller
	uiSleep (floor random [10,15,20]);
	[_i, false] execVM "scripts\server\a3w\missions\sideMissionController.sqf";
};
