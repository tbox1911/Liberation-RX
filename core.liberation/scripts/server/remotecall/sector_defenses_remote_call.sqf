if (!isServer && hasInterface) exitWith {};

params ["_sector", "_defense"];
private _index = { if ((_x select 0) == _sector) exitWith { _forEachIndex } } forEach GRLIB_sector_defense;
if (isNil "_index") then {
    if (_defense > 0) then {
        private _marker = createMarkerLocal [format ["defense_%1", _sector], (markerPos _sector)];
        _marker setMarkerShapeLocal "ICON";
        _marker setMarkerTypeLocal "loc_defend";
        _marker setMarkerColor "ColorGrey";        
        GRLIB_sector_defense pushBack [_sector, _defense] 
    };
} else {
    if (_defense == 0) then {
        GRLIB_sector_defense deleteAt _index;
        deleteMarker format ["defense_%1", _sector];
    } else {
        GRLIB_sector_defense set [_index, [_sector, _defense]];
    };
};
publicVariable "GRLIB_sector_defense";
