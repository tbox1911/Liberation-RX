params [ "_unit" ];

GRLIB_wildlife_max = 4;
waitUntil {sleep 1; !isNil "sectors_allSectors" };

while {alive _unit} do {
	sleep (30 + random 60);
	private _fobdistance = round (_unit distance2D ([] call F_getNearestFob));
	private _wildlife = _unit getVariable ["GRLIB_Wildlife", 0];
	private _sector = [ GRLIB_sector_size, getPos _unit ] call F_getNearestSector;
	private _nbplayer = { _x distance _unit < GRLIB_sector_size} count allPlayers;
	private _wildlife_max = GRLIB_wildlife_max;

	switch (true) do
	{
		case (_nbplayer > 1): {_wildlife_max = 3};
		case (_nbplayer > 2): {_wildlife_max = 2};
		case (_nbplayer > 3): {_wildlife_max = 1};
	};

	if (_wildlife < _wildlife_max && _unit distance2D lhd >= GRLIB_sector_size && _fobdistance > GRLIB_sector_size && objectParent _unit == _unit && !(_sector in sectors_bigtown)) then {
		private _managed_units = ( [ getPos _unit ] call F_spawnWildLife );
		_wildlife = _wildlife + 1;
		_unit setVariable ["GRLIB_Wildlife", _wildlife, true];
		sleep 0.2;

		[_unit, _managed_units] spawn {
			params ["_unit", "_managed_units"];
			while { ({alive _x} count _managed_units) > 0 && alive _unit} do {
				{
					if (_unit distance2D _x > GRLIB_sector_size) then { deleteVehicle _x };
				} forEach _managed_units;
				sleep 10;
			};
			_wildlife = _unit getVariable ["GRLIB_Wildlife", 0];
			_wildlife = _wildlife - 1;
			_unit setVariable ["GRLIB_Wildlife", _wildlife, true];
		};
	};
};
