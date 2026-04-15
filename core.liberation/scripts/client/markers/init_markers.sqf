createMarkerLocal ["opfor_bg_marker", markers_reset];
"opfor_bg_marker" setMarkerTypeLocal "mil_unknown";
"opfor_bg_marker" setMarkerColorLocal GRLIB_color_enemy_bright;

createMarkerLocal ["opfor_capture_marker", markers_reset];
"opfor_capture_marker" setMarkerTypeLocal "mil_objective";
"opfor_capture_marker" setMarkerColorLocal GRLIB_color_enemy_bright;

// Game markers
private _marker = createMarkerLocal ["zone_capture", markers_reset];
_marker setMarkerColorLocal "ColorUNKNOWN";
_marker setMarkerShapeLocal "Ellipse";
_marker setMarkerBrushLocal "SolidBorder";
_marker setMarkerSizeLocal [GRLIB_capture_size, GRLIB_capture_size];

private _marker = createMarkerLocal ["spawn_marker", markers_reset];
_marker setMarkerColorLocal "ColorGreen";
_marker setMarkerTypeLocal "Select";

GRLIB_Marker_ATM = [];
GRLIB_Marker_REP = [];
GRLIB_Marker_FUEL = [];
GRLIB_Marker_SELL = [];
GRLIB_Marker_SHOP = [];

waituntil { sleep 1; !isNil "GRLIB_marker_init" };

{
    private _name = _x;
    private _pos = markerPos _x;
    
    switch (true) do {
        case (_name select [0,10] == "marked_atm"):  { GRLIB_Marker_ATM  pushBack _pos };
        case (_name select [0,10] == "marked_rep"):  { GRLIB_Marker_REP  pushBack _pos };
        case (_name select [0,11] == "marked_fuel"): { GRLIB_Marker_FUEL pushBack _pos };
        case (_name select [0,11] == "marked_sell"): { GRLIB_Marker_SELL pushBack _pos };
        case (_name select [0,11] == "marked_shop"): { GRLIB_Marker_SHOP pushBack _pos };
    };
} forEach (allMapMarkers select { _x select [0,7] == "marked_" });
