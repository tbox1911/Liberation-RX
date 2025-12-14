params [["_source_pos", (getPosATL player)], ["_only_outpost", false], ["_check_water", false]];

private _retvalue = [999999,999999,0];
private _fob_list = GRLIB_all_fobs;

if (_only_outpost) then { _fob_list = GRLIB_all_outposts };
if (count _fob_list == 0) exitWith { _retvalue };

if (_check_water) then { _fob_list = GRLIB_all_fobs select { !([_source_pos,  _x] call F_isWaterBetween) } };
if (count _fob_list == 0) exitWith { _retvalue };

_retvalue = ([_fob_list ,[_source_pos] ,{ _x distance2D _input0 }, 'ASCEND'] call BIS_fnc_sortBy) select 0;
_retvalue;
