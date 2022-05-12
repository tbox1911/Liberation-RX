_marker = createMarkerLocal ["zone_capture", markers_reset];
_marker setMarkerColorLocal "ColorUNKNOWN";
_marker setMarkerShapeLocal "Ellipse";
_marker setMarkerBrushLocal "SolidBorder";
_marker setMarkerSizeLocal [ GRLIB_capture_size, GRLIB_capture_size ];

_marker = createMarkerLocal ["spawn_marker", markers_reset];
_marker setMarkerColorLocal "ColorGreen";
_marker setMarkerTypeLocal "Select";

// LRX Markers
GRLIB_Marker_SRV = [];
GRLIB_Marker_ATM = [];
GRLIB_Marker_FUEL = [];
GRLIB_Marker_REPAIR = [];
GRLIB_Marker_SHOP = [];

waituntil {sleep 1; !isNil "GRLIB_sectors_init"};
sleep 5;

private _marker_dist = {
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

// Objects too long to search (atm, phone, etc ..)
[] call compileFinal preprocessFileLineNUmbers "fixed_position.sqf";

// Search Objects by classname
[] call compileFinal preprocessFileLineNUmbers "compute_position.sqf";


// Draw/Filter Markers
/*

private _tmp_marker = GRLIB_Marker_FUEL;
GRLIB_Marker_FUEL = [];
{
  _dist = ["FUEL", _x] call _marker_dist;
  if (_dist > 300) then {
    _marker = createMarkerLocal [format ["marked_fuel%1", _forEachIndex], _x];
    _marker setMarkerColorLocal "ColorYellow";
    _marker setMarkerTypeLocal "mil_dot";
    _marker setMarkerTextLocal "FUEL";
    _marker setMarkerSizeLocal [ 0.75, 0.75 ];
    GRLIB_Marker_FUEL pushback _x;
  };
} forEach _tmp_marker;

private _tmp_marker = GRLIB_Marker_ATM;
GRLIB_Marker_ATM = [];
{
  _dist = ["ATM", _x] call _marker_dist;
  if (_dist > 500) then {
    _marker = createMarkerLocal [format ["marked_atm%1", _forEachIndex], _x];
    _marker setMarkerColorLocal "ColorGreen";
    _marker setMarkerTypeLocal "mil_dot";
    _marker setMarkerTextLocal "ATM";
    _marker setMarkerSizeLocal [ 0.75, 0.75 ];
    GRLIB_Marker_ATM pushback _x;
  };
} forEach _tmp_marker;


private _tmp_marker = GRLIB_Marker_SRV;
GRLIB_Marker_SRV = [];
{
  _dist = ["SELL", _x] call _marker_dist;
  if (_dist > 800) then {
    _marker = createMarkerLocal [format ["marked_car%1", _forEachIndex], _x];
    _marker setMarkerColorLocal "ColorBlue";
    _marker setMarkerTypeLocal "mil_dot";
    _marker setMarkerTextLocal "SELL";
    _marker setMarkerSizeLocal [ 0.75, 0.75 ];
    GRLIB_Marker_SRV pushback _x;
  };
} forEach _tmp_marker;

private _tmp_marker = GRLIB_Marker_SHOP;
GRLIB_Marker_SHOP = [];
{
  _dist = ["SHOP", _x] call _marker_dist;
  if (_dist > 1500) then {
    _marker = createMarkerLocal [format ["marked_shop%1", _forEachIndex], _x];
    _marker setMarkerColorLocal "ColorPink";
    _marker setMarkerTypeLocal "mil_dot";
    _marker setMarkerTextLocal "SHOP";
    _marker setMarkerSizeLocal [ 0.75, 0.75 ];
    GRLIB_Marker_SHOP pushback _x;
  };
} forEach _tmp_marker;

private _tmp_marker = [];
_tmp_marker = [vehicles, {(alive _x) && typeOf _x == "C_Offroad_01_repair_F" && (_x getVariable ["GRLIB_vehicle_owner", ""] == "server")}] call BIS_fnc_conditionalSelect;
{
    _marker = createMarkerLocal [format ["marked_repair%1", _forEachIndex], getPos _x];
    _marker setMarkerColorLocal "ColorOrange";
    _marker setMarkerTypeLocal "mil_dot";
    _marker setMarkerTextLocal "Repair";
    _marker setMarkerSizeLocal [ 0.75, 0.75 ];
    GRLIB_Marker_REPAIR pushback getPos _x;
} forEach _tmp_marker;
*/


GRLIB_marker_init = true;