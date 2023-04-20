if ( isServer ) then {
	params [ "_targetsector" ];

	_grp1 = [_targetsector] call send_paratroopers;
	sleep 5;
	["lib_reinforcements", [markertext _targetsector]] remoteExec ["bis_fnc_shownotification", 0];
	_grp2 = [_targetsector] call send_paratroopers;
	sleep 5;
	GRLIB_A3W_Mission_MR = [_grp1, _grp2];
	publicVariable "GRLIB_A3W_Mission_MR";
};