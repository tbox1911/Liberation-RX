private _atmObjects = [];
private _serviceObject = [];
private _fuelObject = [];
[] call compileFinal preprocessFileLineNUmbers "fixed_position.sqf";

private _pos = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
{
  if (_x distance2D lhd > 1000) then {
    _str = str _x;
    //if (_str find "atm_" > 0) then { _atmObjects pushback _x };
    if (_str find "carservice_" > 0) then { _serviceObject pushback (getpos _x) };
    if (_str find "cargo_hq_" > 0) then { _serviceObject pushback (getpos _x) };
    if (_str find "fs_roof_" > 0) then { _fuelObject pushback (getpos _x) };
  };
} forEach (_pos nearObjects ["House", worldSize / 2]);

{
  _marker = createMarker [format ["marked_atm%1" ,_x], markers_reset];
  _marker setMarkerPos _x;
  _marker setMarkerColor "ColorGreen";
  _marker setMarkerType "mil_dot";
  _marker setMarkerText "";
  _marker setMarkerSize [ 1, 1 ];
} forEach _atmObjects;

{
  _marker = createMarker [format ["marked_car%1" ,_x], markers_reset];
  _marker setMarkerPos _x;
  _marker setMarkerColor "ColorBlue";
  _marker setMarkerType "mil_dot";
  _marker setMarkerText "";
  _marker setMarkerSize [ 1, 1 ];
} forEach _serviceObject;

{
  _marker = createMarker [format ["marked_fuel%1" ,_x], markers_reset];
  _marker setMarkerPos _x;
  _marker setMarkerColor "ColorYellow";
  _marker setMarkerType "mil_dot";
  _marker setMarkerText "";
  _marker setMarkerSize [ 1, 1 ];
} forEach _fuelObject;

//-------------------------------------------------------------
//_posh =  ((_pos select 1) * 3) - 1300;
_posh = 2000;
_marker = createMarker ["ATM", markers_reset];
_marker setMarkerPos [150, _posh,0];
_marker setMarkerColor "ColorGreen";
_marker setMarkerType "n_support";
_marker setMarkerText "ATM";
_marker setMarkerSize [ 1, 1 ];

_marker = createMarker ["SELL", markers_reset];
_marker setMarkerPos [150,_posh-200,0];
_marker setMarkerColor "ColorBlue";
_marker setMarkerType "c_car";
_marker setMarkerText "SELL";
_marker setMarkerSize [ 1, 1 ];

_marker = createMarker ["FUEL", markers_reset];
_marker setMarkerPos [150,_posh-400,0];
_marker setMarkerColor "ColorYellow";
_marker setMarkerType "loc_Fuelstation";
_marker setMarkerText "FUEL";
_marker setMarkerSize [ 1, 1 ];
