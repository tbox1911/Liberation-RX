params [ "_searchposition", "_distance"];

private _players = (AllPlayers - (entities "HeadlessClient_F")) select { alive _x && _x distance2D _searchposition < _distance };
if (count _players == 0) exitWith { [] };
([_players ,[_searchposition] ,{ _x distance2D _input0 }, 'ASCEND'] call BIS_fnc_sortBy);