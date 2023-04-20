params ["_list", "_pos"];

private _ret = objNull;
if (count _list == 0 ) exitWith {_ret};
private _sorted_list = _list apply {[markerPos _x distance2D _pos, _x]};
_sorted_list sort true;
_ret = _sorted_list select 0 select 1;
_ret;
