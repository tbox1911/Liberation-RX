if (!isServer) exitWith {};

GRLIB_base_objects = [
	FOB_typename,
	FOB_sign,
	FOB_outpost,
	FOB_carrier,
	Warehouse_typename,
	land_cutter_typename,
	helipad_typename
];

GRLIB_classnames_to_save = [] + all_buildings_classnames + fob_defenses_classnames;
GRLIB_classnames_to_save_blu = [
	huron_typename
] + GRLIB_base_objects + all_friendly_classnames + all_hostile_classnames;
GRLIB_classnames_to_save_blu = GRLIB_classnames_to_save_blu arrayIntersect GRLIB_classnames_to_save_blu;

private _support_vehicles_light = support_vehicles_classname select {!( _x isKindof "AllVehicles")};
GRLIB_vehicles_light = _support_vehicles_light + list_static_weapons + uavs_vehicles;
GRLIB_vehicles_light = GRLIB_vehicles_light arrayIntersect GRLIB_vehicles_light;

GRLIB_classnames_to_save = GRLIB_classnames_to_save + GRLIB_classnames_to_save_blu + GRLIB_vehicles_light - GRLIB_disabled_arsenal;
GRLIB_classnames_to_save = GRLIB_classnames_to_save arrayIntersect GRLIB_classnames_to_save;

GRLIB_quick_delete = [
	Arsenal_typename,
	FOB_box_typename,
	foodbarrel_typename,
	waterbarrel_typename,
	medic_heal_typename,
	"Land_MedicalTent_01_base_F",
	"CargoNet_01_base_F",
	"Shelter_base_F"
];

GRLIB_no_kill_handler_classnames = [];
{
	GRLIB_no_kill_handler_classnames pushBackUnique _x;
} foreach (GRLIB_base_objects + all_buildings_classnames + fob_defenses_classnames);

GRLIB_explo_delete = [ammobox_o_typename, ammobox_b_typename, ammobox_i_typename, fuelbarrel_typename];
