if ( isServer ) then {
	params [ "_targetsector" ];
	private _grp_list = [];
	private _grp1 = [_targetsector] call send_paratroopers;
	_grp_list = [_grp1];

	if ( combat_readiness > 55 && count AllPlayers > 1 ) then {
		private _grp2 = [_targetsector] call send_paratroopers;
		_grp_list = [_grp1, _grp2];
	};

	GRLIB_A3W_Mission_MR = _grp_list;
	publicVariable "GRLIB_A3W_Mission_MR";
	sleep 3;
	["lib_reinforcements", [markertext _targetsector]] remoteExec ["bis_fnc_shownotification", 0];
};