params [ "_fobpos" ];
diag_log format ["Spawn Attack FOB %1 at %2", _fobpos, time];
private _max_prisonners = 4;

sleep 60;
private _ownership = [ _fobpos ] call F_sectorOwnership;
if ( _ownership != GRLIB_side_enemy ) exitWith {};

private _grp = grpNull;
if ( GRLIB_blufor_defenders ) then {
	_grp = [_fobpos, blufor_squad_mix, GRLIB_side_friendly, "defender"] call F_libSpawnUnits;
	_grp setCombatMode "RED";
	_grp setCombatBehaviour  "COMBAT";
	{
		_x setSkill 0.65;
		_x setSkill ["courage", 1];
		_x allowFleeing 0;
	} foreach (units _grp);
	_grp setCombatMode "GREEN";
	_grp setBehaviour "COMBAT";
	[_grp, _fobpos] spawn add_defense_waypoints;
	sleep 120;
};

sleep 30;

_ownership = [ _fobpos ] call F_sectorOwnership;
if ( _ownership == GRLIB_side_friendly ) exitWith {
	if ( count (units _grp) > 0 ) then {
		{ if ( alive _x ) then { deleteVehicle _x } } foreach units _grp;
		deleteGroup _grp;
	};
};

[ _fobpos , 1 ] remoteExec ["remote_call_fob", 0];

private _sector_timer = GRLIB_vulnerability_timer + (5 * 60);
private _near_outpost = (count (_fobpos nearObjects [FOB_outpost, 100]) > 0);
private _activeplayers = 0;
while { (_sector_timer > 0 || _activeplayers > 0) && _ownership == GRLIB_side_enemy } do {
	_ownership = [_fobpos] call F_sectorOwnership;
	_activeplayers = count ([allPlayers, {alive _x && (_x distance2D (_fobpos)) < GRLIB_sector_size}] call BIS_fnc_conditionalSelect);
	_sector_timer = _sector_timer - 1;
	if (_sector_timer mod 60 == 0 && !_near_outpost) then {
		[ _fobpos , 4 ] remoteExec ["remote_call_fob", 0];
	};	
	sleep 1;
};

if ( GRLIB_endgame == 0 ) then {
	if ( _ownership == GRLIB_side_enemy ) then {
		[ _fobpos , 2 ] remoteExec ["remote_call_fob", 0];
		sleep 3;
		if (!_near_outpost) then {
			[_fobpos, 250] remoteExec ["remote_call_penalty", 0];
			sleep 3;
		};
		GRLIB_all_fobs = GRLIB_all_fobs - [_fobpos];
		publicVariable "GRLIB_all_fobs";
		[_fobpos] call destroy_fob;
		stats_fobs_lost = stats_fobs_lost + 1;
	} else {
		[ _fobpos , 3 ] remoteExec ["remote_call_fob", 0];
		_enemy_left = [allUnits, {(alive _x) && (vehicle _x == _x) && (side group _x == GRLIB_side_enemy) && ((_fobpos distance2D _x) < GRLIB_capture_size * 0.8)}] call BIS_fnc_conditionalSelect;
		{ 
			if ( _max_prisonners > 0 && ((random 100) < GRLIB_surrender_chance) ) then {
				[_x] spawn prisonner_ai;
				_max_prisonners = _max_prisonners - 1;
			};
		} foreach _enemy_left;
	};
};

sleep 60;

if ( count (units _grp) > 0 ) then {
	[_grp] spawn {
		params ["_grp"];
		sleep 60;
		{ if ( alive _x ) then { deleteVehicle _x } } foreach units _grp;
		deleteGroup _grp;
	};
};
