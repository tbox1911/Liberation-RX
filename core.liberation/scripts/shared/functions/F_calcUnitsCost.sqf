private ["_unit", "_unit_class", "_unit_mp", "_unit_cost", "_unit_rank"];

infantry_units = [];
{
	_unit_class = _x select 0;
	_unit_mp = _x select 1;
	_unit_cost = _x select 2;
	_unit_rank = _x select 4;
	if (_unit_cost == 0) then {
		_unit = _unit_class createVehicle zeropos;
		_unit allowDamage false;
		[_unit, configOf _unit] call BIS_fnc_loadInventory;
		if (_unit_class in units_loadout_overide) then {
			_loadouts_folder = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_west, toLower _unit_class];
			[_unit] call compileFinal preprocessFileLineNUmbers _loadouts_folder;
		};
		deleteVehicle _unit;
		sleep 0.1;
	};
	infantry_units pushBack [_unit_class, _unit_mp, _unit_cost, 0, _unit_rank];
} foreach infantry_units_west;
