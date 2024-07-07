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

// selected mission markers when fob only check
private _r1 = [SpawnMissionMarkers, true] call checkSpawn;
{
    _marker = createMarkerLocal [format ["a3w_dbg_b_%1", _forEachIndex], markerPos _x];
    _marker setMarkerColorLocal "ColorGreen";
    _marker setMarkerTypeLocal "mil_dot";
    _marker setMarkerSizeLocal [ 0.75, 0.75 ];
    _marker setMarkerTextLocal "X";
} forEach _r1;

// selected mission markers when blufor sectors + fob check
private _r1 = [SpawnMissionMarkers, false] call checkSpawn;
{
    _marker = createMarkerLocal [format ["a3w_dbg_c_%1", _forEachIndex], markerPos _x];
    _marker setMarkerColorLocal "ColorRed";
    _marker setMarkerTypeLocal "mil_dot";
    _marker setMarkerSizeLocal [ 0.75, 0.75 ];
    _marker setMarkerTextLocal "+";
} forEach _r1;