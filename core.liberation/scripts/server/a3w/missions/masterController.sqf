// ******************************************************************************************
// * This project is licensed under the GNU Affero GPL v3. Copyright © 2014 A3Wasteland.com *
// ******************************************************************************************
//	@file Name: masterController.sqf
//	@file Author: AgentRev

for "_i" from 1 to 4 do {
	// Start Permanent controller
	sleep (floor random [5,10,15] * 60);
	[_i, false] spawn a3w_sideMissionController;
};
