params ["_start_pos", "_radius"];

private _ret_pos = (_start_pos getPos [_radius, floor random 360]);
if (_ret_pos select 2 <= 0) then { _ret_pos set [2, 0.3] };

_ret_pos;
