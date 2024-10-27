// Cleanup
{ deleteMarker _x } forEach (allMapMarkers select {_x select [0,8] == "a3w_dbg_"});

// All Available mission markers
{
    _marker = createMarkerLocal [format ["a3w_dbg_a_%1", _forEachIndex], markerPos (_x select 0)];
    _marker setMarkerColorLocal "ColorBlack";
    _marker setMarkerTypeLocal "mil_dot";
    _marker setMarkerSizeLocal [ 0.75, 0.75 ];
    _marker setMarkerTextLocal "O";
} forEach SpawnMissionMarkers;

// Check spawn markers
private _r1 = [SpawnMissionMarkers] call checkSpawn;
{
    _marker = createMarkerLocal [format ["a3w_dbg_c_%1", _forEachIndex], markerPos _x];
    _marker setMarkerColorLocal "ColorRed";
    _marker setMarkerTypeLocal "mil_dot";
    _marker setMarkerSizeLocal [ 0.75, 0.75 ];
    _marker setMarkerTextLocal "+";
} forEach _r1;