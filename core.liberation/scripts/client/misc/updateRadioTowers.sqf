// updateRadioTowers.sqf
// Initializes radio towers based on their side.
sleep 60;
[{
    diag_log "TFAR antenna script running...";

    // Define the marker colors for each side.
    private _color_friendly = "ColorBLUFOR";

    // Define the ranges for each side
    private _range_friendly = 10000; // range for friendly side

    // Get all objects of type "TFAR_Land_Communication_F".
    private _towers = allMissionObjects "TFAR_Land_Communication_F";
    diag_log format ["Found %1 towers", count _towers];

    {
        private _tower = _x;
        private _pos = getPos _tower;
        private _closestMarker = "";
        private _closestDistance = 100; // change this to a smaller value if the marker is on top of the tower

        {
            private _markerPos = markerPos _x;
            private _distance = _pos distance2D _markerPos;
            if (_distance < _closestDistance) then {
                _closestDistance = _distance;
                _closestMarker = _x;
            };
        } forEach allMapMarkers;

        if (_closestMarker != "") then {
            private _markerName = _closestMarker;
            if (_markerName find "tower_" == 0) then {
                private _color = getMarkerColor _markerName;
                if (_color == _color_friendly) then {
                    diag_log format ["Initializing radio tower at %1", _pos];
                    [_tower, _range_friendly] call TFAR_antennas_fnc_initRadioTower;
                };
            } else { 
                if (_markerName find "fobmarker" == 0) then {
                    diag_log format ["Initializing radio tower at %1", _pos];
                    [_tower, _range_friendly] call TFAR_antennas_fnc_initRadioTower;
                }
            };
        } else {
            diag_log format ["No marker found near tower at %1", _pos];
        };
    } forEach _towers;

    diag_log "TFAR antenna script ended";

// Set a timer to run this script again in 5 minutes
}, 300] call CBA_fnc_addPerFrameHandler;