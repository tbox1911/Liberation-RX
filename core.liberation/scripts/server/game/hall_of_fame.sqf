if (!isServer) exitWith {};
if (GRLIB_fancy_info == 0) exitWith {};

while {true} do {
	sleep (10 * 60);
	[3] remoteExec ["remote_call_showtext", 0];
	
	sleep (5 * 60);
	[2] remoteExec ["remote_call_showtext", 0];

	sleep (35 * 60);
	[(selectRandom [4,5,6,7])] remoteExec ["remote_call_showtext", 0];
};