params [ "_thispos" ];
diag_log format ["Spawn Attack FOB %1 at %2", _thispos, time];
private _max_prisonners = 4;
sleep 5;

private _ownership = [ _thispos ] call F_sectorOwnership;
if ( _ownership != GRLIB_side_enemy ) exitWith {};

private _grp = createGroup [GRLIB_side_friendly, true];

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

private _near_outpost = (count (_thispos nearObjects [FOB_outpost, 100]) > 0);
private _attacktime = GRLIB_vulnerability_timer + (5 * 60);

while { _attacktime > 0 && ( _ownership == GRLIB_side_enemy || _ownership == GRLIB_side_civilian ) } do {
	_ownership = [ _thispos ] call F_sectorOwnership;
	_attacktime = _attacktime - 1;
	if (_attacktime mod 60 == 0 && !_near_outpost) then {
		[ _thispos , 4 ] remoteExec ["remote_call_fob", 0];
	};
	sleep 1;
};

waitUntil {
	sleep 1;
	[ _thispos ] call F_sectorOwnership != GRLIB_side_civilian;
};


private _countblufor_ownership = [_thispos, GRLIB_capture_size, GRLIB_side_friendly] call F_getUnitsCount;

if ( GRLIB_endgame == 0 ) then {
	if ( _attacktime <= 1 && ( [ _thispos ] call F_sectorOwnership == GRLIB_side_enemy ) && ( _countblufor_ownership < 3 ) ) then {
		[ _thispos , 2 ] remoteExec ["remote_call_fob", 0];
		sleep 3;
		if (!_near_outpost) then {
			[_thispos, 250] remoteExec ["remote_call_penalty", 0];
			sleep 3;
		};
		GRLIB_all_fobs = GRLIB_all_fobs - [_thispos];
		publicVariable "GRLIB_all_fobs";
		reset_battlegroups_ai = true;
		[_thispos] call destroy_fob;
		trigger_server_save = true;
		[] call recalculate_caps;
		stats_fobs_lost = stats_fobs_lost + 1;
	} else {
		[ _thispos , 3 ] remoteExec ["remote_call_fob", 0];
		_enemy_left = [allUnits, {(alive _x) && (vehicle _x == _x) && (side group _x == GRLIB_side_enemy) && ((_thispos distance2D _x) < GRLIB_capture_size * 0.8)}] call BIS_fnc_conditionalSelect;
		{ 
			if ( _max_prisonners > 0 && ((random 100) < GRLIB_surrender_chance) ) then {
				[_x] spawn prisonner_ai;
				_max_prisonners = _max_prisonners - 1;
			};
		} foreach _enemy_left;
	};
};

sleep 60;

if ( GRLIB_blufor_defenders ) then {
	{
		if ( alive _x ) then { deleteVehicle _x };
	} foreach units _grp;
};