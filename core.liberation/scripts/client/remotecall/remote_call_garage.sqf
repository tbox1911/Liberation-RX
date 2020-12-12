if ( isDedicated ) exitWith {};
params [ "_veh_info" ];

_veh_class = _veh_info select 0;
_color = _veh_info select 1;
_ammo = _veh_info select 2;
//_owner = _veh_info select 3;
_lst_a3 = _veh_info select 4;
_lst_r3f = _veh_info select 5;

buildtype = 9;
build_unit = [_veh_class,_color,_ammo,_lst_a3,_lst_r3f];
dobuild = 1;

waitUntil { sleep 1; dobuild == 0};
hintSilent (format ["Vehicle %1\nUnloaded from Garage.", getText (configFile >> "cfgVehicles" >> _veh_class >> "displayName")]);