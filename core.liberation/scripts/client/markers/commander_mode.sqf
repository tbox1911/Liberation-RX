if !(GRLIB_Commander_mode) exitWith {};

private _availableMarkers = [];
private _old_blufor_sectors = -1;
while {true} do {
	waitUntil {sleep 0.1; visibleMap};

    if ((count blufor_sectors + count GRLIB_all_fobs) != _old_blufor_sectors) then {
        { deleteMarker _x } forEach _availableMarkers;
        _availableMarkers = [];
        {
            _marker = createMarkerLocal [_x + "av", markerPos _x];
            _marker setMarkerTypeLocal "Select";
            _marker setMarkerColor "ColorYellow";
            _availableMarkers pushBack _marker;
        } forEach GRLIB_AvailAttackSectors;
        _old_blufor_sectors = (count blufor_sectors + count GRLIB_all_fobs);
    };
    if (count GRLIB_AvailAttackSectors == 0 && count _availableMarkers > 0) then {
        { deleteMarker _x } forEach _availableMarkers;
        _availableMarkers = [];
        waitUntil {sleep 1; (count GRLIB_AvailAttackSectors != 0)};
    };
};