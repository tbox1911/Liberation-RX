params ["_vehicle"];
if (isNil "_vehicle") exitWith {};

private _cargo = [_vehicle, true] call F_getCargo;
private _arsenal = [];
private _count = 0;
{
	if (typeName (_x select 1) == "ARRAY") then {
		{
			_count = (_x select 1);
			{
				_arsenal pushBack [_x, (_count select _foreachIndex)];
			} forEach (_x select 0);
		} forEach (_x select 1);
	} else {
		_count = 1;
		if (typeName (_x select 1) == "SCALAR") then {
			_arsenal pushBack [(_x select 0), (_x select 1)];
		} else {
			_arsenal pushBack _x;
		};
	};
} forEach _cargo;

[_vehicle] call F_clearCargo;
[_vehicle, _arsenal] call F_setCargo;