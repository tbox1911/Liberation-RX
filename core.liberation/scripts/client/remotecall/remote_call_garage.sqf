if ( isDedicated ) exitWith {};
params [ "_veh_info" ];

_veh_class = _veh_info select 0;
_color = _veh_info select 1;
_ammo = _veh_info select 2;

buildtype = 9;
build_unit = [_veh_class,0,0,0,0,_color,_ammo];
dobuild = 1;
