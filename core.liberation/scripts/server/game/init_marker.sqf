if (!isServer) exitWith {};

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
    if (worldname != "chernarus" && worldname != "Enoch" &&  worldname != "vt7" &&  worldname != "isladuala3") then {if (_str find "workshop" > 0) then { GRLIB_Marker_SRV pushback (getpos _x) }};
    if (_str find "fs_roof_" > 0) then { GRLIB_Marker_FUEL pushback (getpos _x) };
    if (_str find "fuelstation" > 0 && _str find "workshop" < 0 ) then { GRLIB_Marker_FUEL pushback (getpos _x) };
    if (_str find "benzina_schnell" > 0) then { GRLIB_Marker_FUEL pushback (getpos _x) };
  };
} forEach (_center nearObjects ["House", _size]);

{
  _dist = ["ATM", _x] call marker_dist;
  if (_dist > 50) then {
    _marker = createMarker [format ["marked_atm%1" ,_x], markers_reset];
    _marker setMarkerPos _x;
    _marker setMarkerColor "ColorGreen";
    _marker setMarkerType "mil_dot";
    _marker setMarkerText "ATM";
    _marker setMarkerSize [ 1, 1 ];
  };
} forEach GRLIB_Marker_ATM;

{
  _dist = ["SELL", _x] call marker_dist;
  if (_dist > 50) then {
    _marker = createMarker [format ["marked_car%1" ,_x], markers_reset];
    _marker setMarkerPos _x;
    _marker setMarkerColor "ColorBlue";
    _marker setMarkerType "mil_dot";
    _marker setMarkerText "SELL";
    _marker setMarkerSize [ 1, 1 ];
  };
} forEach GRLIB_Marker_SRV;

{
  _dist = ["FUEL", _x] call marker_dist;
  if (_dist > 50) then {
    _marker = createMarker [format ["marked_fuel%1" ,_x], markers_reset];
    _marker setMarkerPos _x;
    _marker setMarkerColor "ColorYellow";
    _marker setMarkerType "mil_dot";
    _marker setMarkerText "FUEL";
    _marker setMarkerSize [ 1, 1 ];

    //add repair pickup
    private _pos = _x findEmptyPosition [10,100, "C_Offroad_01_repair_F"];
    if ( count _pos > 0) then {
      _vehicle = "C_Offroad_01_repair_F" createVehicle _pos;
      _vehicle allowDamage false;
      _vehicle lock 2;
      _vehicle setVariable ["GRLIB_vehicle_owner", "server", true];
      _vehicle setVariable ["R3F_LOG_disabled", true, true];
      clearWeaponCargoGlobal _vehicle;
      clearMagazineCargoGlobal _vehicle;
      clearItemCargoGlobal _vehicle;
      clearBackpackCargoGlobal _vehicle;
    };
  };
} forEach GRLIB_Marker_FUEL;

publicVariable "GRLIB_Marker_SRV";
publicVariable "GRLIB_Marker_ATM";
publicVariable "GRLIB_Marker_FUEL";