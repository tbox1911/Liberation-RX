params [ "_searchposition", "_distance"];

[ (AllPlayers - (entities "HeadlessClient_F")), { alive _x && _x distance2D _searchposition < _distance } ] call BIS_fnc_conditionalSelect