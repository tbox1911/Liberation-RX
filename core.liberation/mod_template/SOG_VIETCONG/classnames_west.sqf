// *** FRIENDLIES ***


// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

huron_typename = "vn_o_air_mi2_01_01";  // comment to use value from lobby/server.cfg
FOB_typename = "Land_vn_b_trench_bunker_04_01";
FOB_box_typename = "Land_Pod_Heli_Transport_04_box_black_F";
FOB_truck_typename = "vn_o_wheeled_z157_repair";
FOB_outpost = "Land_vn_b_trench_bunker_01_02";
FOB_box_outpost = "vn_us_komex_small_03";
Respawn_truck_typename = "vn_o_wheeled_btr40_02_nva65";
ammo_truck_typename = "vn_o_wheeled_z157_ammo_nvam";
fuel_truck_typename = "vn_o_wheeled_z157_fuel_nvam";
repair_truck_typename = "vn_o_wheeled_z157_repair_nva65";
repair_sling_typename = "B_Slingload_01_repair_F";
fuel_sling_typename = "B_Slingload_01_Fuel_F";
ammo_sling_typename = "B_Slingload_01_Ammo_F";
medic_sling_typename = "B_Slingload_01_Medevac_F";
pilot_classname = "vn_o_men_aircrew_01";
crewman_classname = "vn_o_men_nva_41";
Arsenal_typename = "Land_vn_pavn_weapons_stack1";
PAR_Medikit = "vn_b_item_medikit_01";
PAR_AidKit = "vn_o_item_firstaidkit";
GRLIB_sar_wreck = "vn_air_mi2_01_wreck";
repair_offroad = "vn_b_wheeled_m54_repair_airport";
waterbarrel_typename = "Land_WaterBottle_01_stack_F";
fuelbarrel_typename = "Land_vn_metalbarrel_f";
foodbarrel_typename = "Land_FoodSacks_01_large_brown_idap_F";
A3W_BoxWps = "Land_vn_us_weapons_stack2";
chimera_vehicle_overide = [
  ["B_Heli_Light_01_F",  "vn_b_air_oh6a_01"],
  ["B_Heli_Transport_01_F", "vn_b_air_uh1d_02_04"]
];

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["vn_o_men_nva_20",1,0,0,0],
	["vn_o_men_nva_19",1,0,0,0],
	["vn_o_men_nva_22",1,0,0,0],
	["vn_o_men_nva_23",1,0,0,0],
	["vn_o_men_nva_21",1,0,0,GRLIB_perm_inf],
	["vn_o_men_nva_25",1,0,0,GRLIB_perm_inf],
	["vn_o_men_nva_28",1,0,0,GRLIB_perm_log],
	["vn_o_men_nva_17",1,0,0,GRLIB_perm_log],
	["vn_o_men_nva_44",1,0,0,GRLIB_perm_tank],
	["vn_o_men_nva_24",1,0,0,GRLIB_perm_air],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];


// *** RESISTANCE - Viet Cong - Local VC  ***
resistance_squad = [
	"vn_o_men_vc_local_21",
	"vn_o_men_vc_local_11",
	"vn_o_men_vc_local_01",
	"vn_o_men_vc_local_28",
	"vn_o_men_vc_local_09",
	"vn_o_men_vc_local_08",
	"vn_o_men_vc_local_30",
	"vn_o_men_vc_local_16",
	"vn_o_men_vc_local_05",
	"vn_o_men_vc_local_24",
	"vn_o_men_vc_local_19",
	"vn_o_men_vc_local_06",
	"vn_o_men_vc_local_14"
];

units_loadout_overide = [
];

LOADOUT_fixed_price = [
	//["launch_o_vorona_brown_f" , 200],
	["vn_sa7_mag" , 6],
	["vn_sa7b_mag" , 6],
	["vn_m72_mag" , 3],
	["vn_rpg2_mag" , 3],
	["vn_rpg7_mag" , 3]
];

LOADOUT_expensive_items = [
	"vn_o_item_toolkit",
	"vn_o_item_medikit"
];

LOADOUT_free_items = [
	"_mag",
	"vn_o_item_firstaidkit",
	"vn_o_item_map",
	"vn_o_item_radio_urc10",
	"vn_o_item_compass",
	"vn_o_item_watch"
];

light_vehicles = [
	// Boat
	["vn_o_boat_01_02",1,10,1,0],
	["vn_o_boat_01_mg_02",1,25,1,GRLIB_perm_inf],
	["vn_o_boat_02_02",1,20,1,GRLIB_perm_inf],
	["vn_o_boat_02_mg_02",1,45,1,GRLIB_perm_log],
	["vn_o_boat_03_02",20,800,40,GRLIB_perm_tank],
	["vn_o_boat_04_02",20,800,40,GRLIB_perm_air],
	// Land
	["vn_o_car_01_01",1,5,1,0],
	["vn_o_car_03_01",1,10,1,0],
	["vn_o_car_02_01",1,15,1,0],
	["vn_o_car_04_01",1,25,2,0],
	["vn_o_car_04_mg_01",2,40,2,GRLIB_perm_inf],
	["vn_o_wheeled_btr40_01_nva65",2,50,2,GRLIB_perm_inf],
	["vn_o_wheeled_btr40_mg_01_nva65",3,75,2,GRLIB_perm_log],
	["vn_o_wheeled_btr40_mg_02_nva65",3,100,2,GRLIB_perm_log],
	["vn_o_wheeled_z157_01_nva65",3,100,3,GRLIB_perm_log],
	["vn_o_wheeled_z157_02_nva65",4,150,4,GRLIB_perm_tank],
	["vn_o_wheeled_z157_mg_01_nva65",4,150,4,GRLIB_perm_tank]
];

heavy_vehicles = [
	["vn_o_wheeled_btr40_mg_03_nva65",10,500,6,GRLIB_perm_air],
	["vn_o_wheeled_z157_mg_02_nva65",10,650,8,GRLIB_perm_air],
	["vn_o_armor_type63_01_nva65",20,1500,25,GRLIB_perm_max]
];

air_vehicles = [
	["vn_o_air_mi2_01_03",4,200,6,GRLIB_perm_log],
	["vn_o_air_mi2_03_04",6,400,10,GRLIB_perm_tank],
	["vn_o_air_mi2_04_06",10,800,15,GRLIB_perm_air],
	["vn_o_air_mi2_05_04",20,1500,25,GRLIB_perm_max]
];

blufor_air = [
	"vn_o_air_mi2_01_03",
	"vn_o_air_mi2_03_04",
	"vn_o_air_mi2_04_06",
	"vn_o_air_mi2_05_04"
];

boats_west = [
	"vn_o_boat_01_02",
	"vn_o_boat_01_mg_02",
	"vn_o_boat_02_02",
	"vn_o_boat_02_mg_02",
	"vn_o_boat_03_02",
	"vn_o_boat_04_02"
];

static_vehicles = [
	["vn_o_nva_spiderhole_01",0,15,0,GRLIB_perm_inf],
	["vn_o_nva_spiderhole_03",0,25,0,GRLIB_perm_log],
	["vn_o_nva_spiderhole_02",0,25,0,GRLIB_perm_tank],
	["vn_o_nva_65_static_pk_low",0,15,0,GRLIB_perm_inf],
	["vn_o_nva_65_static_pk_high",0,20,0,GRLIB_perm_inf],
	["vn_o_nva_65_static_rpd_high",0,20,0,GRLIB_perm_inf],
	["vn_o_nva_65_static_dshkm_high_01",0,45,0,GRLIB_perm_log],
	["vn_o_nva_65_static_dshkm_high_02",0,50,0,GRLIB_perm_log],
	["vn_o_nva_65_static_dshkm_low_02",0,40,0,GRLIB_perm_log],
	["vn_o_nva_65_static_dshkm_low_01",0,50,0,GRLIB_perm_log],
	["vn_o_nva_65_static_zpu4",5,150,0,GRLIB_perm_tank],
	["vn_o_nva_65_static_type56rr",2,200,0,GRLIB_perm_air],
	["vn_o_nva_65_static_d44",10,300,0,GRLIB_perm_air],
	["vn_o_nva_65_static_mortar_type63",15,600,0,GRLIB_perm_max],
	["vn_o_nva_65_static_mortar_type53",20,800,0,GRLIB_perm_max],
	["vn_o_nva_navy_static_v11m",15,500,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
	"vn_o_nva_navy_static_v11m"
];

support_vehicles_west = [
	["vn_o_air_mi2_01_01",5,300,15,GRLIB_perm_tank]
];

buildings_west_overide = true;
buildings_west = [
	["Land_vn_o_tower_02",0,0,0,GRLIB_perm_tank],
	["Land_vn_o_bunker_03",0,0,0,GRLIB_perm_inf],
	["Land_vn_o_bunker_04",0,0,0,GRLIB_perm_log],
	["Land_vn_o_platform_06",0,0,0,GRLIB_perm_log],
	["Land_vn_fence_bamboo_02",0,0,0,0],
	["Land_vn_fence_bamboo_02_gate",0,0,0,0],
	["Land_vn_fence_punji_01_10",0,0,0,GRLIB_perm_log],
	["Land_vn_o_trench_firing_01",0,0,0,0],
	["Land_vn_wf_field_hospital_east",0,0,0,GRLIB_perm_inf],
	["vn_banner_pavn",0,0,0,0],
	["vn_flag_pavn",0,0,0,0],
	["Land_vn_o_bunker_02",0,0,0,0],
	["Land_vn_o_shelter_05",0,0,0,0]
];

blufor_squad_inf_light = [
	"vn_o_men_nva_15",
	"vn_o_men_nva_22",
	"vn_o_men_nva_21",
	"vn_o_men_nva_25",
	"vn_o_men_nva_28",
	"vn_o_men_nva_19"
];
blufor_squad_inf = [
	"vn_o_men_nva_15",
	"vn_o_men_nva_22",
	"vn_o_men_nva_17",
	"vn_o_men_nva_25",
	"vn_o_men_nva_28",
	"vn_o_men_nva_25",
	"vn_o_men_nva_24",
	"vn_o_men_nva_19",
	"vn_o_men_nva_19"
];
blufor_squad_at = [
	"vn_o_men_nva_15",
	"vn_o_men_nva_22",
	"vn_o_men_nva_28",
	"vn_o_men_nva_28",
	"vn_o_men_nva_19",
	"vn_o_men_nva_19"
];
blufor_squad_aa = [
	"vn_o_men_nva_15",
	"vn_o_men_nva_22",
	"vn_o_men_nva_44",
	"vn_o_men_nva_44",
	"vn_o_men_nva_19",
	"vn_o_men_nva_19"
];
blufor_squad_mix = [
	"vn_o_men_nva_15",
	"vn_o_men_nva_22",
	"vn_o_men_nva_28",
	"vn_o_men_nva_44",
	"vn_o_men_nva_19",
	"vn_o_men_nva_19"
];
blufor_squad_recon = [
	"vn_o_men_vc_01",
	"vn_o_men_vc_08",
	"vn_o_men_vc_10",
	"vn_o_men_vc_11",
	"vn_o_men_vc_14",
	"vn_o_men_vc_04"
];

squads = [
	[blufor_squad_inf_light,15,400,0,GRLIB_perm_max],
	[blufor_squad_inf,25,550,0,GRLIB_perm_max],
	[blufor_squad_at,25,600,0,GRLIB_perm_max],
	[blufor_squad_aa,25,600,0,GRLIB_perm_max],
	[blufor_squad_mix,25,600,0,GRLIB_perm_max],
	[blufor_squad_recon,20,450,0,GRLIB_perm_max]
];

// All the UAVs must be declared here
uavs = [
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
];

vehicle_rearm_sources_west = [
];

vehicle_big_units_west = [

];

GRLIB_vehicle_whitelist_west = [
    "Land_vn_o_tower_02",
	"Land_vn_o_bunker_03",
	"Land_vn_o_bunker_04",
	"Land_vn_o_platform_06",
	"Land_vn_fence_bamboo_02",
	"Land_vn_fence_bamboo_02_gate",
	"Land_vn_fence_punji_01_10",
	"Land_vn_o_trench_firing_01",
	"Land_vn_wf_field_hospital_east",
	"vn_banner_pavn",
	"vn_flag_pavn",
	"Land_vn_o_bunker_02",
	"Land_vn_o_shelter_05"
];

GRLIB_vehicle_blacklist_west = [

];

GRLIB_AirDrop_1 = [		// cost = 50 Unarmed Offroad
	"vn_o_wheeled_btr40_01"
];

GRLIB_AirDrop_2 = [		// cost 100 Armed Offroader
	"vn_o_wheeled_btr40_mg_01"
];

GRLIB_AirDrop_3 = [		// cost 200 MRAPs (Mine Resistant Ambush Protected Vehicle)
	"vn_o_wheeled_btr40_mg_02"
];

GRLIB_AirDrop_4 = [		// cost 300 Large Truck
	"vn_o_wheeled_z157_01_nvam"
];

GRLIB_AirDrop_5 = [		// cost 750 APC (Armoured personnel carrier)
	"vn_o_wheeled_btr40_mg_03"
];


GRLIB_AirDrop_6 = [		// cost 250 Boat
	"vn_o_boat_01_01"
];
