//_size = (getnumber (configfile >> "cfgworlds" >> worldname >> "mapSize")) / 2;
// Workaround for Kapaulio coz "mapSize" is missing
_size = 10240;
_center = [_size,_size,0];

{
  if (_x distance2D lhd > 1000) then {
    _str = toLower str _x;
    if (_str find "carservice_" > 0) then { GRLIB_Marker_SRV pushback (getpos _x) };
    if (_str find "fs_feed_f" > 0) then { GRLIB_Marker_FUEL pushback (getpos _x) };
    if (_str find "fuelstation_shed_f" > 0) then { GRLIB_Marker_FUEL pushback (getpos _x) };
    if (_str find "atm_01_f" > 0) then { GRLIB_Marker_ATM pushback (getpos _x) };
    if (_str find "fuelstation_feed" > 0) then { GRLIB_Marker_FUEL pushback (getpos _x) };
    if (_str find "i_shop_01_v1_f." > 0) then { GRLIB_Marker_SHOP pushback (getpos _x) };
    if (_str find "i_shop_01_v2_f." > 0) then { GRLIB_Marker_SHOP pushback (getpos _x) };    
  };
} forEach (_center nearObjects ["All", (_size * 2^0.50)]);  // cover corner

