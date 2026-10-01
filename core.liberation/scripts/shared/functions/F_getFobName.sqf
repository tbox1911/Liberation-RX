params ["_fob"];
waitUntil { !isNil "military_alphabet" };

private _fob_name = "";
private _fob_index = -1;
private _idx = 0;

{
	if ((_x distance2D _fob) < GRLIB_fob_range) then {
		_fob_index = _idx;
	};
	_idx = _idx + 1;
} foreach GRLIB_all_fobs;

if (_fob_index != -1) then {
	_fob_name = military_alphabet select _fob_index;
};

_fob_name
