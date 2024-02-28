params ["_param"];
private _def = 0;
{
	if (_x select 0 == _param) exitWith { _def = _x select 1 };
} forEach GRLIB_LRX_params;
_def;