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

marker_dist = {
  params ["_type", "_pos"];
  private _list = [];
  {
    if( markerText _x == _type) then { _list pushback _x };
  } forEach allMapMarkers;

  _sortedByRange = [_list,[],{_pos distance2D (markerPos _x)},"ASCEND"] call BIS_fnc_sortBy;
  private _ret = round (markerPos (_sortedByRange select 0) distance2D _pos);
  if (isNil "_ret") then {_ret = 9999};
  _ret;
};

[] call compileFinal preprocessFileLineNUmbers "fixed_position.sqf";

_size = (getnumber (configfile >> "cfgworlds" >> worldname >> "mapSize")) / 2;
_center = [_size,_size,0];

{
  if (_x distance2D lhd > 1000) then {
    _str = str _x;
    //if (_str find "atm_" > 0) then { GRLIB_Marker_ATM pushback (getpos _x) };
    if (_str find "mil_guardhouse" > 0) then { GRLIB_Marker_ATM pushback (getpos _x) };
    if (_str find "carservice_" > 0) then { GRLIB_Marker_SRV pushback (getpos _x) };
    if (_str find "cargo_hq_" > 0) then { GRLIB_Marker_SRV pushback (getpos _x) };
    if (_str find "house_c_12_ep1" > 0) then { GRLIB_Marker_SRV pushback (getpos _x) };
    if (_str find "GarageRow" > 0) then { GRLIB_Marker_SRV pushback (getpos _x) };
    if (_str find "workshop_05" > 0) then { GRLIB_Marker_SRV pushback (getpos _x) };
    if (_str find "workshop01_04" > 0) then { GRLIB_Marker_SRV pushback (getpos _x) };
    if (worldname != "chernarus" && worldname != "Enoch" &&  worldname != "vt7") then {if (_str find "workshop" > 0) then { GRLIB_Marker_SRV pushback (getpos _x) }};
    if (_str find "fs_roof_" > 0) then { GRLIB_Marker_FUEL pushback (getpos _x) };
    if (_str find "fuelstation" > 0 && _str find "workshop" < 0 ) then { GRLIB_Marker_FUEL pushback (getpos _x) };
    if (_str find "benzina_schnell" > 0) then { GRLIB_Marker_FUEL pushback (getpos _x) };
  };
} forEach (_center nearObjects ["House", _size]);

{
  _dist = ["ATM", _x] call marker_dist;
  if (_dist > 50) then {
    _marker = createMarkerLocal [format ["marked_atm%1" ,_x], markers_reset];
    _marker setMarkerPosLocal _x;
    _marker setMarkerColorLocal "ColorGreen";
    _marker setMarkerTypeLocal "mil_dot";
    _marker setMarkerTextLocal "ATM";
    _marker setMarkerSizeLocal [ 1, 1 ];
  };
} forEach GRLIB_Marker_ATM;

{
  _dist = ["SELL", _x] call marker_dist;
  if (_dist > 50) then {
    _marker = createMarkerLocal [format ["marked_car%1" ,_x], markers_reset];
    _marker setMarkerPosLocal _x;
    _marker setMarkerColorLocal "ColorBlue";
    _marker setMarkerTypeLocal "mil_dot";
    _marker setMarkerTextLocal "SELL";
    _marker setMarkerSizeLocal [ 1, 1 ];
  };
} forEach GRLIB_Marker_SRV;

{
  _dist = ["FUEL", _x] call marker_dist;
  if (_dist > 50) then {
    _marker = createMarkerLocal [format ["marked_fuel%1" ,_x], markers_reset];
    _marker setMarkerPosLocal _x;
    _marker setMarkerColorLocal "ColorYellow";
    _marker setMarkerTypeLocal "mil_dot";
    _marker setMarkerTextLocal "FUEL";
    _marker setMarkerSizeLocal [ 1, 1 ];

    //add repair pickup
    //_vehicle = createVehicleLocal ["C_Offroad_01_repair_F", _x, [], 50, "NONE"];
    _vehicle = "C_Offroad_01_repair_F" createVehicleLocal _x;
    _vehicle allowDamage false;
    _vehicle lock 2;
    _vehicle setVariable ["GRLIB_vehicle_owner", "server"];
    _vehicle setVariable ["R3F_LOG_disabled", true];
  };
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