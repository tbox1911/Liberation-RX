private ["_array", "_marker"];
private _currentCircleMark = "";
while {true} do {
    waitUntil {sleep 0.1; visibleMap};
    _array = ctrlMapMouseOver (findDisplay 12 displayCtrl 51);
    _circleMark = "";
    if (count _array > 0) then {
        if ((_array select 0) == "marker" && (_array select 1) in GRLIB_AvailAttackSectors) then {
            _marker = _array select 1;
            _circleMark = _marker + "av";
            if (_currentCircleMark != _circleMark) then {
                [_circleMark,[1.2,1.2],0.009] spawn BIS_fnc_resizeMarker;
                playSoundUI ["a3\ui_f\data\sound\rsccombo\soundexpand.wss", 0.5, 1.2];
                _currentCircleMark = _circleMark;
            };
        };
    } else {
        if (_currentCircleMark != "") then {
            [_currentCircleMark,[1,1],0.009] spawn BIS_fnc_resizeMarker;
            playSoundUI ["a3\ui_f\data\sound\rsccombo\soundcollapse.wss", 0.5, 1.2];
            _currentCircleMark = "";
        };
    };

};