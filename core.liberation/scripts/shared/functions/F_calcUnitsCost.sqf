private ["_unit", "_unit_class", "_unit_mp", "_unit_cost", "_unit_rank"];
private _grp = createGroup [GRLIB_side_friendly, true];
{
	_unit_class = _x select 0;
	_unit_mp = _x select 1;
	_unit_cost = _x select 2;
	_unit_rank = _x select 4;
	if (_unit_cost == 0) then {
		_unit = _grp createUnit [_unit_class, [0,0,0], [], 0, "NONE"];
		if (typeOf _unit in units_loadout_overide) then {
			_loadouts_folder = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_west, toLower (typeOf _unit)];
			[_unit] call compileFinal preprocessFileLineNUmbers _loadouts_folder;
		};
		_unit_cost = [_unit] call F_loadoutPrice;
		deleteVehicle _unit;
	};
	infantry_units set [_forEachIndex, [_unit_class, _unit_mp, _unit_cost, 0,_unit_rank]];
} foreach infantry_units;
deleteGroup _grp;
