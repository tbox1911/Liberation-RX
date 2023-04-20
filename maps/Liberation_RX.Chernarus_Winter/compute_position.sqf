//_size = (getnumber (configfile >> "cfgworlds" >> worldname >> "mapSize")) / 2;
// workaround buggy map
_size = 7860;
_center = [_size,_size,0];

{
  if (_x distance2D lhd > 1000) then {
    _str = toLower str _x;
    if (_str find "workshop01_04" > 0) then { GRLIB_Marker_SRV pushback (getpos _x) };
    if (_str find "carservice_" > 0) then { GRLIB_Marker_SRV pushback (getpos _x) };
    if (_str find "fs_feed" > 0) then { GRLIB_Marker_FUEL pushback (getpos _x) };
    if (_str find "fuelstation_feed" > 0) then { GRLIB_Marker_FUEL pushback (getpos _x) };
    if (_str find "ind_workshop01_02" > 0) then { GRLIB_Marker_SHOP pushback (getpos _x) };
  };
} forEach (_center nearObjects ["All", (_size * 2^0.50)]);  // cover corner