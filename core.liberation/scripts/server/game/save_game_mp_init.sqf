if (!isServer) exitWith {};

GRLIB_classnames_to_save = [] + all_buildings_classnames;
GRLIB_classnames_to_save_blu = [FOB_typename, FOB_outpost, FOB_sign, huron_typename] + all_friendly_classnames;
{
	GRLIB_classnames_to_save_blu pushback (_x select 0);
} foreach ind_recyclable;

GRLIB_classnames_to_save_blu = GRLIB_classnames_to_save_blu arrayIntersect GRLIB_classnames_to_save_blu;
GRLIB_classnames_to_save append (GRLIB_classnames_to_save_blu + all_hostile_classnames);
GRLIB_classnames_to_save = GRLIB_classnames_to_save arrayIntersect GRLIB_classnames_to_save;

GRLIB_vehicles_light = [mobile_respawn] + GRLIB_vehicle_blacklist + list_static_weapons + uavs;
{ GRLIB_vehicles_light pushback (_x select 0) } foreach support_vehicles;
GRLIB_vehicles_light = GRLIB_vehicles_light arrayIntersect GRLIB_vehicles_light;