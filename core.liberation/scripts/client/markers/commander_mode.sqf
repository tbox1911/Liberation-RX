if !(GRLIB_Commander_mode) exitWith {};

waituntil {sleep 1; GRLIB_player_spawned};
sleep 5;

private _availableMarkers = [];
private _availAttackSectors = [];

while {true} do {
    waitUntil { sleep 0.1; visibleMap };
    if (count GRLIB_AvailAttackSectors == 0 && count _availableMarkers > 0) then {
        { deleteMarkerLocal _x } forEach _availableMarkers;
        _availableMarkers = [];
        _availAttackSectors = [];
        waitUntil {sleep 0.5; (count GRLIB_AvailAttackSectors != 0 && count active_sectors == 0)};
    };

    if (count GRLIB_AvailAttackSectors > 0 && !(GRLIB_AvailAttackSectors isEqualTo _availAttackSectors)) then {
        { deleteMarkerLocal _x } forEach _availableMarkers;
        _availableMarkers = [];
        {
            _marker = createMarkerLocal [_x + "av", markerPos _x];
            _marker setMarkerTypeLocal "Select";
            _marker setMarkerColorLocal "ColorYellow";
            _availableMarkers pushBack _marker;
        } forEach GRLIB_AvailAttackSectors;
        _availAttackSectors = [] + GRLIB_AvailAttackSectors;
    };

    sleep 1;
};