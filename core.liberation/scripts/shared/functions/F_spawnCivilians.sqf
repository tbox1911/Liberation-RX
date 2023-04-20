params [ 
	"_sector",
	["_nbcivs", 1]
];
//diag_log format [ "Spawn %1 civilians at %2", _nbcivs, time ];

private [ "_spawnpos", "_grp"];
private _createdcivs = [];
private _sectorpos = getMarkerPos _sector;

if (isNil "_nbcivs") then {	_nbcivs = 1 };
if ((GRLIB_side_civilian countSide allUnits) >= (GRLIB_civilians_amount * 3)) exitWith {[]};

private _spread = 1;
if ( _sector in sectors_bigtown ) then {
	_spread = 2.5;
};

for "_i" from 1 to _nbcivs do {
    _spawnpos = [(((_sectorpos select 0) + (75 * _spread)) - (random (150 * _spread))),(((_sectorpos select 1) + (75 * _spread)) - (random (150 * _spread))),0.3];
    _grp = [_spawnpos, [selectRandom civilians], GRLIB_side_civilian, "civilian"] call F_libSpawnUnits;
	{
		_x setVariable ['GRLIB_can_speak', true, true];
		_x addEventHandler ["HandleDamage", {
			params ["_unit", "_selection", "_damage", "_source"];
			private _dam = 0;
			if ( side _source == GRLIB_side_friendly ) then {
				_dam = _damage;
			};
			if ( side(driver _unit) == GRLIB_side_friendly ) then {
				_dam = _damage;
			};
			_dam;
		}];
		_createdcivs pushBack _x;
	} foreach (units _grp);

	[_grp] call add_civ_waypoints;
	sleep 0.2;
};

//diag_log format [ "Done Spawning %1 civilians at %2", count _createdcivs, time ];

_createdcivs;
