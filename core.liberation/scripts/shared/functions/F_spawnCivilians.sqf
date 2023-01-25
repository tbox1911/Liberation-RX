params [ "_sector" ];
private _sectorpos = getMarkerPos _sector;
private _units_civ = { alive _x && !(typeOf _x in [SHOP_Man, SELL_Man])} count units GRLIB_side_civilian;
if (_units_civ >= (GRLIB_civilians_amount * 3)) exitWith {};

private _spread = 1;
if ( _sector in sectors_bigtown ) then {
	_spread = 2.5;
};

private _spawnpos = [(((_sectorpos select 0) + (75 * _spread)) - (random (150 * _spread))),(((_sectorpos select 1) + (75 * _spread)) - (random (150 * _spread))),0.3];
private _grp = [_spawnpos, [selectRandom civilians], GRLIB_side_civilian, "civilian"] call F_libSpawnUnits;
private _civ_unit = (units _grp) select 0;
if (!isNil "_civ_unit") then {
	_civ_unit setVariable ['GRLIB_can_speak', true, true];
	_civ_unit addEventHandler ["HandleDamage", {
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

	//diag_log format [ "Done Spawning civilian %1 at %2", typeOf _civ_unit, time ];
	_civ_unit;
};
