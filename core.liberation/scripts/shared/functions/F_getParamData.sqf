params ["_param"];
private _ret = [];
{
	if (_x select 0 == _param) exitWith { _ret = [_x select 1, _x select 2, _x select 3] };
} forEach LRX_Mission_Params_Def;
_ret;