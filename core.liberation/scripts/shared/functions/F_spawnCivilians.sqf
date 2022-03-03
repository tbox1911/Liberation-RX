diag_log format [ "Spawning civilians at %1", time ];

params [ "_sector", "_nbcivs" ];
private [ "_spread", "_spawnpos", "_grp", "_nextciv" ];
private _createdcivs = [];
private _sectorpos = getMarkerPos _sector;

if (isNil "_nbcivs") then {	_nbcivs = 1 };
if ((GRLIB_side_civilian countSide allUnits) >= (GRLIB_civilians_amount * 3)) exitWith {_createdcivs};

_spread = 1;
if ( _sector in sectors_bigtown ) then {
	_spread = 2.5;
};

for "_i" from 1 to _nbcivs do {
	_grp = createGroup [GRLIB_side_civilian, true];
	_spawnpos = [(((_sectorpos select 0) + (75 * _spread)) - (random (150 * _spread))),(((_sectorpos select 1) + (75 * _spread)) - (random (150 * _spread))),0.3];
	( selectRandom civilians ) createUnit [_spawnpos, _grp, 'this addMPEventHandler ["MPKilled", {_this spawn kill_manager}]', 0.5, "PRIVATE"];
	_nextciv = ((units _grp) select 0);
	_nextciv addEventHandler ["HandleDamage", { private [ "_damage" ]; if (( side (_this select 3) != GRLIB_side_friendly ) && ( side (_this select 3) != GRLIB_side_enemy )) then { _damage = 0 } else { _damage = _this select 2 }; _damage } ];
	_nextciv setVariable ['GRLIB_can_speak', true, true];
	_nextciv disableAI "FSM";
	_nextciv disableAI "AUTOCOMBAT";
	_nextciv switchMove "amovpknlmstpsraswrfldnon";
	_createdcivs pushBack _nextciv;
	[_grp] call add_civ_waypoints;
};

diag_log format [ "Done Spawning %1 civilians at %2", count (_createdcivs), time ];

_createdcivs
