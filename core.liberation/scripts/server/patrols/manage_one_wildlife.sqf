params [ "_unit" ];

GRLIB_wildlife_max = 4;

while {true} do {
	sleep (30 + random 60);
	private _fobdistance = round (_unit distance2D ([] call F_getNearestFob));
	private _wildlife = _unit getVariable ["GRLIB_Wildlife", 0];

	if (_wildlife < GRLIB_wildlife_max && (_unit distance2D lhd >= 1000) && _fobdistance > GRLIB_sector_size && vehicle _unit == _unit) then {
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
