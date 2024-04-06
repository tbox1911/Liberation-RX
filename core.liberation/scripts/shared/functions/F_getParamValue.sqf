params ["_param"];
private _def = 0;
private _found = false;
{
	if (_x select 0 == _param) exitWith {
		_def = _x select 1;
		_found = true;
	};
} forEach GRLIB_LRX_params;

if (!_found) then {
	{
		if (_x select 0 == _param) exitWith {
			_def = _x select 1;
		};
	} forEach LRX_Mission_Params;
};

_def;