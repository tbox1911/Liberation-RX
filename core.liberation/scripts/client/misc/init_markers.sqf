private ["_marker"];
_marker_debug = false;

// Game markers
_marker = createMarkerLocal ["zone_capture", markers_reset];
_marker setMarkerColorLocal "ColorUNKNOWN";
_marker setMarkerShapeLocal "Ellipse";
_marker setMarkerBrushLocal "SolidBorder";
_marker setMarkerSizeLocal [ GRLIB_capture_size, GRLIB_capture_size ];

_marker = createMarkerLocal ["spawn_marker", markers_reset];
_marker setMarkerColorLocal "ColorGreen";
_marker setMarkerTypeLocal "Select";

// Base markers color
"huronmarker" setMarkerColorLocal GRLIB_color_friendly;
"base_chimera" setMarkerColorLocal GRLIB_color_friendly;

// LRX Markers
GRLIB_Marker_SRV = [];
GRLIB_Marker_ATM = [];
GRLIB_Marker_FUEL = [];
GRLIB_Marker_SHOP = [];

// Objects too long to search (atm, phone, etc ..)
[] call compileFinal preprocessFileLineNUmbers "fixed_position.sqf";

// Search Objects by classname (only when dev)
//[] execVM "compute_position.sqf";

waituntil {sleep 1; !isNil "GRLIB_sectors_init"};
waituntil {sleep 1; !isNil "GRLIB_marker_init"};

// ATM Markers
{
  _marker = createMarkerLocal [format ["marked_atm%1", _forEachIndex], _x];
  _marker setMarkerColorLocal "ColorGreen";
  _marker setMarkerTypeLocal "mil_dot";
  if (_marker_debug) then {
    _marker setMarkerTextLocal format ["ATM %1", _x];
  } else {
    _marker setMarkerTextLocal "ATM";
  };
  _marker setMarkerSizeLocal [ 0.75, 0.75 ];
} forEach GRLIB_Marker_ATM;

// SRV Markers
{
  _marker = createMarkerLocal [format ["marked_car%1", _forEachIndex], _x];
  _marker setMarkerColorLocal "ColorBlue";
  _marker setMarkerTypeLocal "mil_dot";
    if (_marker_debug) then {
    _marker setMarkerTextLocal format ["SELL %1", _x];
  } else {
    _marker setMarkerTextLocal "SELL";
  };
  _marker setMarkerSizeLocal [ 0.75, 0.75 ];
} forEach GRLIB_Marker_SRV;

// FUEL Marker
{
  _marker = createMarkerLocal [format ["marked_fuel%1", _forEachIndex], _x];
  _marker setMarkerColorLocal "ColorYellow";
  _marker setMarkerTypeLocal "mil_dot";
  if (_marker_debug) then {
    _marker setMarkerTextLocal format ["FUEL %1", _x];
  } else {    
    _marker setMarkerTextLocal "FUEL";
  };
  _marker setMarkerSizeLocal [ 0.75, 0.75 ];
} forEach GRLIB_Marker_FUEL;

// SHOP Marker
{
  _marker = createMarkerLocal [format ["marked_shop%1", _forEachIndex], _x];
  _marker setMarkerColorLocal "ColorPink";
  _marker setMarkerTypeLocal "mil_dot";
  if (_marker_debug) then {
    _marker setMarkerTextLocal format ["SHOP %1", _x];
  } else {    
    _marker setMarkerTextLocal "SHOP";
  };
  _marker setMarkerSizeLocal [ 0.75, 0.75 ];
} forEach GRLIB_Marker_SHOP;

// Repair Marker (computed on server side)
waitUntil {sleep 2; !isNil "GRLIB_Marker_REPAIR"};
{
  _marker = createMarkerLocal [format ["marked_repair%1", _forEachIndex], _x];
  _marker setMarkerColorLocal "ColorOrange";
  _marker setMarkerTypeLocal "mil_dot";
  _marker setMarkerTextLocal "Repair";
  _marker setMarkerSizeLocal [ 0.75, 0.75 ];
} forEach GRLIB_Marker_REPAIR;
