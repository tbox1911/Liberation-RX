params ["_sectors", "_radius", ["_gradian", 0.25]];

private _pos = [];
private _is_flat = false;
private _found = false;

{
	_pos = [(markerpos _x), 40, 0] call F_findSafePlace;
	if (count _pos != 0) then {
		_is_flat = !(_pos isFlatEmpty  [-1, -1, _gradian, _radius, 0, false] isEqualTo []);
	};
	if (_is_flat) exitWith { _found = true };
	sleep 0.1;
} forEach (_sectors call BIS_fnc_arrayShuffle);

if (_found) exitWith { _pos };

[];
