params [ "_thispos" ];
private [ "_attacktime", "_ownership", "_grp" ];

sleep 5;

_ownership = [ _thispos ] call F_sectorOwnership;
if ( _ownership != GRLIB_side_enemy ) exitWith {};

_grp = createGroup [GRLIB_side_friendly, true];

if ( GRLIB_blufor_defenders ) then {
	{ _x createUnit [ _thispos, _grp,'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]']; } foreach blufor_squad_inf;
};

sleep 3;

_grp setCombatMode "GREEN";
_grp setBehaviour "COMBAT";

sleep 60;

_ownership = [ _thispos ] call F_sectorOwnership;
if ( _ownership == GRLIB_side_friendly ) exitWith {
	if ( GRLIB_blufor_defenders ) then {
		{
			if ( alive _x ) then { deleteVehicle _x };
		} foreach units _grp;
	};
};

[ _thispos , 1 ] remoteExec ["remote_call_fob", 0];

_attacktime = GRLIB_vulnerability_timer;

while { _attacktime > 0 && ( _ownership == GRLIB_side_enemy || _ownership == GRLIB_side_resistance ) } do {
	_ownership = [ _thispos ] call F_sectorOwnership;
	_attacktime = _attacktime - 1;
	if (_attacktime mod 60 == 0) then {
		[ _thispos , 4 ] remoteExec ["remote_call_fob", 0];
	};
	sleep 1;
};

waitUntil {
	sleep 1;
	[ _thispos ] call F_sectorOwnership != GRLIB_side_resistance;
};

if ( GRLIB_endgame == 0 ) then {
	if ( _attacktime <= 1 && ( [ _thispos ] call F_sectorOwnership == GRLIB_side_enemy ) ) then {
		[ _thispos , 2 ] remoteExec ["remote_call_fob", 0];
		sleep 3;
		[_thispos, 250] remoteExec ["remote_call_penalty", 0];
		sleep 3;
		GRLIB_all_fobs = GRLIB_all_fobs - [_thispos];
		publicVariable "GRLIB_all_fobs";
		reset_battlegroups_ai = true;
		[_thispos] call destroy_fob;
		trigger_server_save = true;
		[] call recalculate_caps;
		stats_fobs_lost = stats_fobs_lost + 1;
	} else {
		[ _thispos , 3 ] remoteExec ["remote_call_fob", 0];
		{ [_x] spawn prisonner_ai; } foreach ( _thispos nearEntities [ ["Man"], GRLIB_capture_size * 0.8 ] );
	};
};

sleep 60;

if ( GRLIB_blufor_defenders ) then {
	{
		if ( alive _x ) then { deleteVehicle _x };
	} foreach units _grp;
};