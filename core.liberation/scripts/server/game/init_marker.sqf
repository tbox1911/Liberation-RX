if (!isServer) exitWith {};

waituntil {sleep 0.5; !isNil "GRLIB_sectors_init"};

GRLIB_Marker_SRV = [];
GRLIB_Marker_ATM = [];
GRLIB_Marker_FUEL = [];
GRLIB_Marker_REPAIR = [];

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

// Objects too long to search (atm, phone, etc ..)
[] call compileFinal preprocessFileLineNUmbers "fixed_position.sqf";

// Search Objects by classname
[] call compileFinal preprocessFileLineNUmbers "compute_position.sqf";

// Draw/Filter Markers
private _tmp_marker = GRLIB_Marker_ATM;
GRLIB_Marker_ATM = [];
{
  _dist = ["ATM", _x] call marker_dist;
  if (_dist > 100) then {
    _marker = createMarker [format ["marked_atm%1" ,_x], markers_reset];
    _marker setMarkerPos _x;
    _marker setMarkerColor "ColorGreen";
    _marker setMarkerType "mil_dot";
    _marker setMarkerText "ATM";
    _marker setMarkerSize [ 1, 1 ];
    GRLIB_Marker_ATM pushback _x;
  };
} forEach _tmp_marker;
publicVariable "GRLIB_Marker_ATM";

private _tmp_marker = GRLIB_Marker_SRV;
GRLIB_Marker_SRV = [];
{
  _dist = ["SELL", _x] call marker_dist;
  if (_dist > 100) then {
    _marker = createMarker [format ["marked_car%1" ,_x], markers_reset];
    _marker setMarkerPos _x;
    _marker setMarkerColor "ColorBlue";
    _marker setMarkerType "mil_dot";
    _marker setMarkerText "SELL";
    _marker setMarkerSize [ 1, 1 ];
    GRLIB_Marker_SRV pushback _x;
  };
} forEach _tmp_marker;
publicVariable "GRLIB_Marker_SRV";

private _tmp_marker = GRLIB_Marker_FUEL;
GRLIB_Marker_FUEL = [];
{
  _dist = ["FUEL", _x] call marker_dist;
  if (_dist > 100) then {
    _marker = createMarker [format ["marked_fuel%1" ,_x], markers_reset];
    _marker setMarkerPos _x;
    _marker setMarkerColor "ColorYellow";
    _marker setMarkerType "mil_dot";
    _marker setMarkerText "FUEL";
    _marker setMarkerSize [ 1, 1 ];
    GRLIB_Marker_FUEL pushback _x;
  };
} forEach _tmp_marker;
publicVariable "GRLIB_Marker_FUEL";

private _tmp_marker = [];
{ _tmp_marker pushback (markerpos _x) } forEach sectors_factory;
{
  _dist = ["Repair", _x] call marker_dist;
  if (_dist > 300) then {
    //add repair pickup
    private _pos = [];
    private _max_try = 5;
    private _find_pos = false;
    private _cur_pos = _x;
    while {!_find_pos && _max_try > 0} do {
      _pos = _cur_pos findEmptyPosition [5,50, "C_Offroad_01_repair_F"];
      if (count _pos == 3) then {
        if (!isOnRoad _pos) then {_find_pos = true};
        _cur_pos = _x vectorAdd [([[-50,0,50], 5] call F_getRND), ([[-50,0,50], 5] call F_getRND), 0];
      };
      _max_try = _max_try - 1;
    };

    if (_find_pos) then {
      _vehicle = "C_Offroad_01_repair_F" createVehicle _pos;
      _vehicle allowDamage false;
      _vehicle lock 2;
      _vehicle setVariable ["GRLIB_vehicle_owner", "server", true];
      _vehicle setVariable ["R3F_LOG_disabled", true, true];
      clearWeaponCargoGlobal _vehicle;
      clearMagazineCargoGlobal _vehicle;
      clearItemCargoGlobal _vehicle;
      clearBackpackCargoGlobal _vehicle;

      _marker = createMarker [format ["marked_repair%1" ,_pos], markers_reset];
      _marker setMarkerPos _pos;
      _marker setMarkerColor "ColorOrange";
      _marker setMarkerType "mil_dot";
      _marker setMarkerText "Repair";
      _marker setMarkerSize [ 1, 1 ];
      GRLIB_Marker_REPAIR pushback _pos;
    };
  };
} forEach _tmp_marker;
publicVariable "GRLIB_Marker_REPAIR";

GRLIB_marker_init = true;
publicVariable "GRLIB_marker_init";

// Search object
//  _object = "mailboxsouth";
//  _res = [];
//  private _pos = getArray(configFile >> "CfgWorlds" >> worldName >> "centerPosition");
//  {
//   if (_x distance2D lhd > 1000) then {
//     if (str _x find _object > 0) then { _res pushback (getPos _x) };
//   };
// } foreach nearestobjects [_pos, [], worldSize / 2];
// systemchat str (count _res);
// copyToClipboard str _res;