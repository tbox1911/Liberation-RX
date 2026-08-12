private ["_unit", "_unit_class", "_unit_mp", "_unit_cost", "_unit_rank", "_unit_desc"];

infantry_units = [];
{
	_unit_class = _x select 0;
	_unit_mp = _x select 1;
	_unit_cost = _x select 2;
	_unit_rank = _x select 4;
	_unit_desc = _x select 5;
	if (isNil "_unit_desc") then { _unit_desc = "" };
	if (_unit_cost == 0) then {
		_unit = _unit_class createVehicle zeropos;
		_unit allowDamage false;
		[_unit, configOf _unit] call BIS_fnc_loadInventory;
		private _class_overide = toLower _unit_class;
		if (_class_overide in units_loadout_overide) then {
			private _path = format ["mod_template\%1\loadout\%2.sqf", GRLIB_mod_west, _class_overide];
			[_path, _unit] call F_getTemplateFile;
		};
		_unit_cost = [_unit] call F_loadoutPrice;
		deleteVehicle _unit;
		sleep 0.1;
	};
	infantry_units pushBack [_unit_class, _unit_mp, _unit_cost, 0, _unit_rank, _unit_desc];
} foreach infantry_units_west;
