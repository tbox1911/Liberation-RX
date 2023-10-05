if (!isServer) exitWith {};

GRLIB_classnames_to_save = [] + all_buildings_classnames;
GRLIB_classnames_to_save_blu = [FOB_typename, FOB_outpost, FOB_sign, huron_typename] + all_friendly_classnames;
{
	GRLIB_classnames_to_save_blu pushBackUnique (_x select 0);
} foreach ind_recyclable;

GRLIB_classnames_to_save_blu = GRLIB_classnames_to_save_blu arrayIntersect GRLIB_classnames_to_save_blu;
GRLIB_classnames_to_save append (GRLIB_classnames_to_save_blu + all_hostile_classnames);
GRLIB_classnames_to_save = GRLIB_classnames_to_save - GRLIB_disabled_arsenal;
GRLIB_classnames_to_save = GRLIB_classnames_to_save arrayIntersect GRLIB_classnames_to_save;

GRLIB_vehicles_light = [mobile_respawn] + GRLIB_vehicle_blacklist + list_static_weapons + uavs;
{
	if !((_x select 0) isKindOf "AllVehicles") then { GRLIB_vehicles_light pushBackUnique (_x select 0) };
} foreach support_vehicles;
GRLIB_vehicles_light = GRLIB_vehicles_light arrayIntersect GRLIB_vehicles_light;

GRLIB_no_kill_handler_classnames = [FOB_typename, FOB_outpost] + all_buildings_classnames;
