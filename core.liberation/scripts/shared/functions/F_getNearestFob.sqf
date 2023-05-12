params [["_source_position", (getPosATL player)], ["_only_outpost", false]];

private _retvalue = [0,0,0];
private _fob_list = GRLIB_all_fobs;
if (_only_outpost) then { _fob_list = GRLIB_all_outposts };
if (count _fob_list == 0) exitWith { _retvalue };
_retvalue = ([_fob_list ,[] ,{ _source_position distance2D _x }, 'ASCEND'] call BIS_fnc_sortBy) select 0;
_retvalue;
