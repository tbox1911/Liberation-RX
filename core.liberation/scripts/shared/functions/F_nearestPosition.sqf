params ["_list", "_pos"];

if (count _list == 0 ) exitWith {""};
private _sorted_list = _list apply {[markerPos _x distance2D _pos, _x]};
_sorted_list sort true;
(_sorted_list select 0 select 1);
