private ["_array", "_marker", "_sector"];
private _currentCircleMark = "";
while {true} do {
    waitUntil { sleep 0.1; visibleMap };
    _array = ctrlMapMouseOver (findDisplay 12 displayCtrl 51);
    _circleMark = "";
    _delete = true;
    if (count _array > 0) then {
        if ((_array select 0) == "marker" && !isNil {(_array select 1)}) then {
            _marker = _array select 1;
            _sector = [100, markerPos _marker, GRLIB_AvailAttackSectors] call F_getNearestSector;
            if (_sector != "") then {
                _circleMark = _sector + "av";
                _delete = false;
                if (_currentCircleMark != _circleMark) then {
                    if (_currentCircleMark != "") then {
                        [_currentCircleMark,[1,1],0.009] spawn BIS_fnc_resizeMarker;
                        playSoundUI ["a3\ui_f\data\sound\rsccombo\soundcollapse.wss", 0.5, 1.2];
                    };
                    [_circleMark,[1.2,1.2],0.009] spawn BIS_fnc_resizeMarker;
                    playSoundUI ["a3\ui_f\data\sound\rsccombo\soundexpand.wss", 0.5, 1.2];
                    _currentCircleMark = _circleMark;
                };
            };
        };
    };

    if (_currentCircleMark != "" && _delete) then {
        [_currentCircleMark,[1,1],0.009] spawn BIS_fnc_resizeMarker;
        playSoundUI ["a3\ui_f\data\sound\rsccombo\soundcollapse.wss", 0.5, 1.2];
        _currentCircleMark = "";
    };

};