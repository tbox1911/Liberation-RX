params [ "_sector" ];
diag_log format ["Spawn Attack Sector %1 at %2", _sector, time];
private _max_prisonners = 4;

sleep 5;

private _ownership = [ markerpos _sector ] call F_sectorOwnership;
if ( _ownership != GRLIB_side_enemy ) exitWith {};

private _squad_type = blufor_squad_inf_light;
if ( _sector in sectors_military ) then {
	_squad_type = blufor_squad_inf;
};

private _grp = createGroup [GRLIB_side_friendly, true];
private	_is_side_sector = (count (allMapMarkers select {_x select [0,12] == "side_mission" && markerPos _x distance2D markerPos _sector <= GRLIB_capture_size}) > 0);

if ( GRLIB_blufor_defenders && !_is_side_sector) then {
	{ _x createUnit [markerpos _sector, _grp, 'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]'] } foreach _squad_type;
	{
		_x setSkill 0.65;
		_x setSkill ["courage", 1];
		_x allowFleeing 0;
		_x doFollow leader _grp
	} foreach units _grp;
	_grp setCombatMode "RED";
	_grp setBehaviourStrong "COMBAT";
};

sleep 60;

_ownership = [ markerpos _sector ] call F_sectorOwnership;
if ( _ownership == GRLIB_side_friendly ) exitWith {
	if ( GRLIB_blufor_defenders ) then {
		{
			if ( alive _x ) then { deleteVehicle _x };
		} foreach units _grp;
	};
};

[ _sector, 1 ] remoteExec ["remote_call_sector", 0];
private _attacktime = GRLIB_vulnerability_timer;
if (_sector in sectors_bigtown) then {
	_attacktime = _attacktime + (10 * 60);
};

while { _attacktime > 0 && _ownership == GRLIB_side_enemy } do {
	_ownership = [markerpos _sector] call F_sectorOwnership;
	_attacktime = _attacktime - 1;
	sleep 1;
};

private _countblufor = [markerpos _sector, GRLIB_capture_size, GRLIB_side_friendly ] call F_getUnitsCount;
while { _countblufor > 0 && _ownership == GRLIB_side_enemy } do {
	_ownership = [markerpos _sector] call F_sectorOwnership;
	_countblufor = [markerpos _sector, GRLIB_capture_size, GRLIB_side_friendly ] call F_getUnitsCount;
	sleep 1;
};

if ( GRLIB_endgame == 0 ) then {
	if ( _attacktime <= 1 && ( [markerpos _sector] call F_sectorOwnership == GRLIB_side_enemy ) ) then {
		blufor_sectors = blufor_sectors - [ _sector ];
		publicVariable "blufor_sectors";
		[ _sector, 2 ] remoteExec ["remote_call_sector", 0];
		reset_battlegroups_ai = true;
		trigger_server_save = true;
		[] call recalculate_caps;
		stats_sectors_lost = stats_sectors_lost + 1;
	} else {
		[ _sector, 3 ] remoteExec ["remote_call_sector", 0];
		_enemy_left = [allUnits, {(alive _x) && (vehicle _x == _x) && (side group _x == GRLIB_side_enemy) && (((getmarkerpos _sector) distance2D _x) < GRLIB_capture_size * 0.8)}] call BIS_fnc_conditionalSelect;
		{
			if ( _max_prisonners > 0 && ((random 100) < GRLIB_surrender_chance) ) then {
				[_x] spawn prisonner_ai;
				_max_prisonners = _max_prisonners - 1;
			} else {
				if ( ((random 100) <= 50) ) then { [_x] spawn bomber_ai };
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