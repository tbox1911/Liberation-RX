_marker = createMarkerLocal ["zone_capture", markers_reset];
_marker setMarkerColorLocal "ColorUNKNOWN";
_marker setMarkerShapeLocal "Ellipse";
_marker setMarkerBrushLocal "SolidBorder";
_marker setMarkerSizeLocal [ GRLIB_capture_size, GRLIB_capture_size ];

_marker = createMarkerLocal ["spawn_marker", markers_reset];
_marker setMarkerColorLocal "ColorGreen";
_marker setMarkerTypeLocal "Select";

GRLIB_Marker_SRV = [];
GRLIB_Marker_ATM = [];
GRLIB_Marker_FUEL = [];

[] call compileFinal preprocessFileLineNUmbers "fixed_position.sqf";

_size = (getnumber (configfile >> "cfgworlds" >> worldname >> "mapSize")) / 2;
_center = [_size,_size,0];

{
  if (_x distance2D lhd > 1000) then {
    _str = str _x;
    //if (_str find "atm_" > 0) then { GRLIB_Marker_ATM pushback _x };
    if (_str find "carservice_" > 0) then { GRLIB_Marker_SRV pushback (getpos _x) };
    if (_str find "cargo_hq_" > 0) then { GRLIB_Marker_SRV pushback (getpos _x) };
    if (_str find "house_c_12_ep1" > 0) then { GRLIB_Marker_SRV pushback (getpos _x) };
    if (_str find "GarageRow" > 0) then { GRLIB_Marker_SRV pushback (getpos _x) };
    if (_str find "workshop_05" > 0) then { GRLIB_Marker_SRV pushback (getpos _x) };
    if (worldname != "chernarus" && worldname != "Enoch" &&  worldname != "vt7") then {if (_str find "workshop" > 0) then { GRLIB_Marker_SRV pushback (getpos _x) }};
    if (_str find "fs_roof_" > 0) then { GRLIB_Marker_FUEL pushback (getpos _x) };
    if (_str find "fuelstation" > 0 && _str find "workshop" < 0 ) then { GRLIB_Marker_FUEL pushback (getpos _x) };
    if (_str find "benzina_schnell" > 0) then { GRLIB_Marker_FUEL pushback (getpos _x) };
  };
} forEach (_center nearObjects ["House", _size]);

{
  _marker = createMarkerLocal [format ["marked_atm%1" ,_x], markers_reset];
  _marker setMarkerPosLocal _x;
  _marker setMarkerColorLocal "ColorGreen";
  _marker setMarkerTypeLocal "mil_dot";
  _marker setMarkerTextLocal "ATM";
  _marker setMarkerSizeLocal [ 1, 1 ];
} forEach GRLIB_Marker_ATM;

{
  _marker = createMarkerLocal [format ["marked_car%1" ,_x], markers_reset];
  _marker setMarkerPosLocal _x;
  _marker setMarkerColorLocal "ColorBlue";
  _marker setMarkerTypeLocal "mil_dot";
  _marker setMarkerTextLocal "SELL";
  _marker setMarkerSizeLocal [ 1, 1 ];
} forEach GRLIB_Marker_SRV;

{
  _marker = createMarkerLocal [format ["marked_fuel%1" ,_x], markers_reset];
  _marker setMarkerPosLocal _x;
  _marker setMarkerColorLocal "ColorYellow";
  _marker setMarkerTypeLocal "mil_dot";
  _marker setMarkerTextLocal "FUEL";
  _marker setMarkerSizeLocal [ 1, 1 ];
} forEach GRLIB_Marker_FUEL;


//-------------------------------------------------------------
/*
_posh = 2000;
_marker = createMarkerLocal ["ATM", markers_reset];
_marker setMarkerPosLocal [150, _posh,0];
_marker setMarkerColorLocal "ColorGreen";
_marker setMarkerTypeLocal "n_support";
_marker setMarkerTextLocal "ATM";
_marker setMarkerSizeLocal [ 1, 1 ];

_marker = createMarkerLocal ["SELL", markers_reset];
_marker setMarkerPosLocal [150,_posh-200,0];
_marker setMarkerColorLocal "ColorBlue";
_marker setMarkerTypeLocal "c_car";
_marker setMarkerTextLocal "SELL";
_marker setMarkerSizeLocal [ 1, 1 ];

_marker = createMarkerLocal ["FUEL", markers_reset];
_marker setMarkerPosLocal [150,_posh-400,0];
_marker setMarkerColorLocal "ColorYellow";
_marker setMarkerTypeLocal "loc_Fuelstation";
_marker setMarkerTextLocal "FUEL";
_marker setMarkerSizeLocal [ 1, 1 ];
*/