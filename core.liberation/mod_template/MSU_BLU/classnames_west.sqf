// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;
GRLIB_color_friendly = "ColorBLUFOR";

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

huron_typename = "B_Heli_Transport_03_F"; // comment to use value from lobby/server.cfg
FOB_typename = "Land_Cargo_HQ_V1_F";
FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "rhsusf_m113_usarmy_unarmed";
FOB_outpost = "";
FOB_box_outpost = "";
Respawn_truck_typename = "";
ammo_truck_typename = "";
fuel_truck_typename = "";
repair_truck_typename = "";
repair_sling_typename = "B_Slingload_01_Repair_F";
fuel_sling_typename = "B_Slingload_01_Fuel_F";
ammo_sling_typename = "B_Slingload_01_Ammo_F";
medic_sling_typename = "B_Slingload_01_Medevac_F";
pilot_classname = "rhsusf_army_ucp_helipilot";
crewman_classname = "rhsusf_army_ucp_crewman";
A3W_BoxWps = "rhs_weapon_crate";

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units = [
["vn_b_men_army_03",0,ai_value,0,GRLIB_perm_inf]
];


units_loadout_overide = [];


light_vehicles = [
["UNS_Zodiac_W",0,25,0,GRLIB_perm_inf],
["uns_willys_2",0,50,0,GRLIB_perm_inf]
];


strong_light_vehicles = [
// SOG
["vn_c_bicycle_01",0,10,0,GRLIB_perm_inf],
["vn_o_boat_01_02",0,15,0,GRLIB_perm_inf],
["vn_o_boat_01_mg_02",0,30,0,GRLIB_perm_inf],
["vn_b_boat_06_01",0,15,0,GRLIB_perm_inf],
["vn_b_boat_05_01",0,15,0,0,GRLIB_perm_inf],
["vn_b_wheeled_m151_01",0,40,0,GRLIB_perm_inf],
["vn_b_wheeled_m151_02",0,40,0,GRLIB_perm_inf],
["vn_b_wheeled_m151_mg_04",0,75,0,GRLIB_perm_inf],
["vn_b_wheeled_m151_mg_02",0,100,0,GRLIB_perm_inf],
["vn_b_wheeled_m151_mg_03",0,125,0,GRLIB_perm_inf],
["vn_b_wheeled_m54_01",0,100,0,GRLIB_perm_inf],
["vn_b_wheeled_m54_02",0,150,0,GRLIB_perm_inf],

// GM
["gm_gc_army_bicycle_01_oli",0,10,0,GRLIB_perm_inf],
["gm_ge_army_k125",0,20,0,GRLIB_perm_inf],
["gm_ge_army_typ1200_cargo",0,50,0,GRLIB_perm_inf],
["gm_ge_army_iltis_cargo",0,50,0,GRLIB_perm_inf],
["gm_ge_army_iltis_milan",0,100,0,GRLIB_perm_inf],
["gm_ge_army_iltis_mg3",0,125,0,GRLIB_perm_inf],
["gm_ge_army_u1300l_container",0,75,0,GRLIB_perm_inf],
["gm_ge_army_kat1_451_container",0,125,0,GRLIB_perm_inf]
];


heavy_vehicles = [
["uns_pbr_mk18",0,250,0,GRLIB_perm_inf], // ship with gl
["uns_M113_M60",0,250,0,GRLIB_perm_inf]
];


strong_heavy_vehicles = [
// SOG
["vn_b_wheeled_m54_mg_01",0,250,0,GRLIB_perm_inf],
["vn_b_wheeled_m54_mg_02",0,300,0,GRLIB_perm_inf],
["vn_b_wheeled_m54_mg_03",0,250,0,GRLIB_perm_inf],
["vn_b_wheeled_m151_mg_05",0,250,0,GRLIB_perm_inf],
["vn_b_armor_m41_01_01",0,1000,0,GRLIB_perm_inf],

// GM
["gm_ge_army_fuchsa0_reconnaissance",0,500,0,GRLIB_perm_inf],
["gm_ge_army_m113a1g_apc_milan",0,500,0,GRLIB_perm_inf],
["gm_ge_army_luchsa1",0,500,0,GRLIB_perm_inf],
["gm_ge_army_marder1a2",0,750,0,GRLIB_perm_inf],
["gm_ge_army_bibera0",0,250,0,GRLIB_perm_inf],
["gm_ge_army_Leopard1a1",0,1000,0,GRLIB_perm_inf]
];


air_vehicles = [
	["uns_UH1H_m60_light",0,400,0,GRLIB_perm_inf]
];


fast_air_vehicle = [
// SOG
["vn_b_air_oh6a_01",0,300,0,GRLIB_perm_inf],
["vn_b_air_oh6a_03",0,300,0,GRLIB_perm_inf],
["vn_b_air_oh6a_02",0,300,0,GRLIB_perm_inf],
["vn_b_air_oh6a_05",0,300,0,GRLIB_perm_inf],
["vn_b_air_uh1d_02_01",0,400,0,GRLIB_perm_inf],
["vn_b_air_ch34_03_01",0,400,0,GRLIB_perm_inf],
["vn_b_air_ch34_04_03",0,400,0,GRLIB_perm_inf],
["vn_b_air_uh1d_02_02",0,750,0,GRLIB_perm_inf],
["vn_b_air_uh1c_04_02",0,750,0,GRLIB_perm_inf],
["vn_b_air_uh1c_02_02",0,750,0,GRLIB_perm_inf],
["vn_b_air_ah1g_10_usmc",0,1000,0,GRLIB_perm_inf],
["vn_b_air_f4c_chico",0,1500,0,GRLIB_perm_inf],

// GM
["gm_ge_army_bo105m_vbh",0,300,0,GRLIB_perm_inf],
["gm_ge_army_bo105p1m_vbh",0,300,0,GRLIB_perm_inf],
["gm_ge_army_bo105p1m_vbh_swooper",0,300,0,GRLIB_perm_inf],
["gm_ge_army_bo105p_pah1",0,750,0,GRLIB_perm_inf],
["gm_ge_army_bo105p_pah1a1",0,750,0,GRLIB_perm_inf],
["gm_ge_army_ch53g",0,500,0,GRLIB_perm_inf],
["gm_ge_airforce_do28d2",0,300,0,GRLIB_perm_inf]
];


static_vehicles = [
// SOG
["vn_b_army_static_m60_low",0,0,0,GRLIB_perm_inf],
["vn_b_army_static_m60_high",0,0,0,GRLIB_perm_inf],
["vn_b_army_static_m1919a6",0,0,0,GRLIB_perm_inf],
["vn_b_army_static_m1919a4_low",0,0,0,GRLIB_perm_inf],
["vn_b_army_static_m1919a4_high",0,0,0,GRLIB_perm_inf],
["vn_b_army_static_m2_low",0,0,0,GRLIB_perm_inf],
["vn_b_army_static_m2_high",0,0,0,GRLIB_perm_inf],
["vn_b_army_static_m45",0,0,0,GRLIB_perm_inf],
["vn_b_army_static_tow",0,0,0,GRLIB_perm_inf],
["vn_b_army_static_m101_01",0,0,0,GRLIB_perm_inf],
["vn_b_army_static_mortar_m2",0,0,0,GRLIB_perm_inf],
["vn_b_army_static_mortar_m29",0,0,0,GRLIB_perm_inf],
["vn_b_navy_static_l70mk2",0,0,0,GRLIB_perm_inf],

// GM
["B_HMG_01_F",0,0,0,GRLIB_perm_inf],
["B_HMG_01_high_F",0,0,0,GRLIB_perm_inf],
["gm_ge_army_mg3_aatripod",0,0,0,GRLIB_perm_inf],
["gm_ge_army_milan_launcher_tripod",0,0,0,GRLIB_perm_inf],
["B_Mortar_01_F",0,0,0,GRLIB_perm_inf]
];


support_vehicles_west = [
// SOG

// GM
["gm_ge_army_kat1_451_reammo",0,150,0,GRLIB_perm_inf],
["gm_ge_army_u1300l_repair",0,130,0,GRLIB_perm_inf],
["gm_ge_army_kat1_451_refuel",0,120,0,GRLIB_perm_inf]
];


support_crates = [
// Ersatzteile
["ACE_Track",0,0,0,GRLIB_perm_inf],
["ACE_Wheel",0,0,0,GRLIB_perm_inf],

// Kisten
["Box_NATO_Equip_F",0,0,0,GRLIB_perm_inf],
["B_CargoNet_01_ammo_F",0,0,0,GRLIB_perm_inf],
["CargoNet_01_box_F",0,0,0,GRLIB_perm_inf],
["CargoNet_01_barrels_F",0,0,0,GRLIB_perm_inf],

// Huron Container
[ammo_sling_typename,0,0,0,GRLIB_perm_inf],
[repair_sling_typename,0,0,0,GRLIB_perm_inf],
[fuel_sling_typename,0,0,0,GRLIB_perm_inf],
[medic_sling_typename,0,0,0,GRLIB_perm_inf],

// FOB
[FOB_box_typename,0,15000,0,GRLIB_perm_inf],
[FOB_truck_typename,0,15000,0,GRLIB_perm_inf]
];


buildings_west = [
["US_WarfareBArtilleryRadar_Base_EP1",0,0,0,GRLIB_perm_inf],
["Land_fort_artillery_nest_EP1",0,0,0,GRLIB_perm_inf],
["Land_Mil_Barracks_EP1",0,0,0,GRLIB_perm_inf],
["Land_Mil_Barracks_i_EP1",0,0,0,GRLIB_perm_inf],
["Land_Mil_Barracks_no_interior_EP1_CUP",0,0,0,GRLIB_perm_inf],
["Land_Mil_Barracks_L_EP1",0,0,0,GRLIB_perm_inf],
["Land_fortified_nest_big_EP1",0,0,0,GRLIB_perm_inf],
["Land_fortified_nest_small_EP1",0,0,0,GRLIB_perm_inf],
["Land_Fort_Watchtower_EP1",0,0,0,GRLIB_perm_inf],
["WarfareBDepot",0,0,0,GRLIB_perm_inf],
["US_WarfareBUAVterminal_Base_EP1",0,0,0,GRLIB_perm_inf],
["Land_fort_rampart_EP1",0,0,0,GRLIB_perm_inf],
["US_WarfareBFieldhHospital_Base_EP1",0,0,0,GRLIB_perm_inf],
["US_WarfareBAircraftFactory_Base_EP1",0,0,0,GRLIB_perm_inf],
["US_WarfareBVehicleServicePoint_Base_EP1",0,0,0,GRLIB_perm_inf],
["US_WarfareBBarrier10xTall_EP1",0,0,0,GRLIB_perm_inf],
["US_WarfareBBarracks_Base_EP1",0,0,0,GRLIB_perm_inf],
["Land_Barrack2_EP1",0,0,0,GRLIB_perm_inf],
["US_WarfareBBarrier5x_EP1",0,0,0,GRLIB_perm_inf],
["WarfareBCamp",0,0,0,GRLIB_perm_inf],
["76n6ClamShell_EP1",0,0,0,GRLIB_perm_inf],
["US_WarfareBBarrier10x_EP1",0,0,0,GRLIB_perm_inf],
["US_WarfareBHeavyFactory_Base_EP1",0,0,0,GRLIB_perm_inf],
["Land_CamoNetB_NATO_EP1",0,0,0,GRLIB_perm_inf],
["Land_CamoNet_NATO_EP1",0,0,0,GRLIB_perm_inf],
["Land_HBarrier_01_wall_6_green_F",0,0,0,GRLIB_perm_inf],
["Land_HBarrier_01_line_3_green_F",0,0,0,GRLIB_perm_inf],
["Land_HBarrier_01_big_tower_green_F",0,0,0,GRLIB_perm_inf],
["Land_HBarrier_01_tower_green_F",0,0,0,GRLIB_perm_inf],
["Land_HBarrier_01_wall_corridor_green_F",0,0,0,GRLIB_perm_inf],
["Land_HBarrier_01_wall_corner_green_F",0,0,0,GRLIB_perm_inf],
["Land_HBarrier_01_wall_4_green_F",0,0,0,GRLIB_perm_inf],

["Land_HBarrier_1_F",0,0,0,GRLIB_perm_inf],
["Land_HBarrierWall6_F",0,0,0,GRLIB_perm_inf],
["Land_HBarrier_3_F",0,0,0,GRLIB_perm_inf],
["Land_HBarrierTower_F",0,0,0,GRLIB_perm_inf],
["Land_HBarrierWall_corridor_F",0,0,0,GRLIB_perm_inf],
["Land_HBarrierWall4_F",0,0,0,GRLIB_perm_inf],
["Land_HBarrierWall_corner_F",0,0,0,GRLIB_perm_inf],

["Land_CncBarrierMedium_F",0,0,0,GRLIB_perm_inf],
["Land_CncBarrierMedium4_F",0,0,0,GRLIB_perm_inf],
["Land_CncShelter_F",0,0,0,GRLIB_perm_inf],
["Land_CncWall1_F",0,0,0,GRLIB_perm_inf],
["Land_CncWall4_F",0,0,0,GRLIB_perm_inf],
["Land_CncBarrier_stripes_F",0,0,0,GRLIB_perm_inf],
["Flag_UNO_F",0,0,0,GRLIB_perm_inf],
["Flag_NATO_F",0,0,0,GRLIB_perm_inf],
["FlagCarrierGermany_EP1",0,0,0,GRLIB_perm_inf],
["FlagCarrierRU",0,0,0,GRLIB_perm_inf],
["Flag_UK_F",0,0,0,GRLIB_perm_inf],
["Flag_US_F",0,0,0,GRLIB_perm_inf],
["Land_PortableLight_single_F",0,0,0,GRLIB_perm_inf],

["Land_Campfire_F",0,0,0,GRLIB_perm_inf],
["Land_CampingChair_V1_F",0,0,0,GRLIB_perm_inf],
["Land_CampingTable_F",0,0,0,GRLIB_perm_inf],
["Land_fort_bagfence_long",0,0,0,GRLIB_perm_inf],

["Land_HelipadSquare_F",0,0,0,GRLIB_perm_inf],
["PortableHelipadLight_01_blue_F",0,0,0,GRLIB_perm_inf],
["PortableHelipadLight_01_green_F",0,0,0,GRLIB_perm_inf],

["Land_ClutterCutter_large_F",0,0,0,GRLIB_perm_inf],

["Land_Hangar_F",0,0,0,GRLIB_perm_inf],
["Land_Cargo_Tower_V1_F",0,0,0,GRLIB_perm_inf],
["Land_Medevac_house_V1_F",0,0,0,GRLIB_perm_inf],
["Land_Medevac_HQ_V1_F",0,0,0,GRLIB_perm_inf],

["Land_PortableLight_double_F",0,0,0,GRLIB_perm_inf],
["Land_LampAirport_F",0,0,0,GRLIB_perm_inf],
["Land_LampStreet_02_double_F",0,0,0,GRLIB_perm_inf],
["Land_SandbagBarricade_01_hole_F",0,0,0,GRLIB_perm_inf],
["Land_fortified_nest_small",0,0,0,GRLIB_perm_inf],
["Land_fortified_nest_big",0,0,0,GRLIB_perm_inf],
["Land_BagBunker_Small_F",0,0,0,GRLIB_perm_inf],
["land_bunker_garage",0,0,0,GRLIB_perm_inf],
["Land_Trench_01_grass_F",0,0,0,GRLIB_perm_inf],
["Land_fort_rampart",0,0,0,GRLIB_perm_inf],
["Land_fort_artillery_nest",0,0,0,GRLIB_perm_inf],
["Land_HBarrier_01_line_5_green_F",0,0,0,GRLIB_perm_inf],
["Land_HBarrier_01_big_4_green_F",0,0,0,GRLIB_perm_inf],
["zed2",0,0,0,GRLIB_perm_inf],
["US_WarfareBBarrier10xTall_EP1",0,0,0,GRLIB_perm_inf],
["WarfareBCamp",0,0,0,GRLIB_perm_inf],
["Fortress2",0,0,0,GRLIB_perm_inf],
["Land_Lampa_sidl_3",0,0,0,GRLIB_perm_inf],
["Land_TentHangar_V1_F", 0, 0, 0, GRLIB_perm_inf],
["Land_fort_bagfence_round",0,0,0,GRLIB_perm_inf],
["Land_fort_bagfence_long",0,0,0,GRLIB_perm_inf],
["Land_fort_bagfence_corner",0,0,0,GRLIB_perm_inf],
["Land_CzechHedgehog_01_new_F",0,0,0,GRLIB_perm_inf],
["Land_Bunker_01_blocks_3_F",0,0,0,GRLIB_perm_inf],
["Land_Bunker_01_small_F",0,0,0,GRLIB_perm_inf],
["Land_Bunker_01_tall_F",0,0,0,GRLIB_perm_inf],
["Land_PillboxBunker_01_big_F",0,0,0,GRLIB_perm_inf],
["SignM_FOB_Revolve_EP1",0,0,0,GRLIB_perm_inf],
["Land_Shooting_range",0,0,0,GRLIB_perm_inf],
["Shed",0,0,0,GRLIB_perm_inf],
["ShedSmall",0,0,0,GRLIB_perm_inf],
["CampEast_EP1",0,0,0,GRLIB_perm_inf],
["Land_Mil_WallBig_4m_F",0,0,0,GRLIB_perm_inf],
["rnt_graben_t",0,0,0,GRLIB_perm_inf],
["rnt_graben_bunker",0,0,0,GRLIB_perm_inf],
["rnt_graben_ecke",0,0,0,GRLIB_perm_inf],
["rnt_graben_ende",0,0,0,GRLIB_perm_inf],
["rnt_graben_stellung",0,0,0,GRLIB_perm_inf],
["rnt_graben_gerade",0,0,0,GRLIB_perm_inf],
["MapBoard_stratis_F",0,0,0,GRLIB_perm_inf],
["MapBoard_altis_F",0,0,0,GRLIB_perm_inf],
["Land_MapBoard_Enoch_F", 0, 0, 0, GRLIB_perm_inf],
["MapBoard_Malden_F",0,0,0,GRLIB_perm_inf],
["MapBoard_Tanoa_F",0,0,0,GRLIB_perm_inf],
["ClutterCutter",0,0,0,GRLIB_perm_inf],
["Notice_board_EP1",0,0,0,GRLIB_perm_inf],
["Land_CncBlock",0,0,0,GRLIB_perm_inf],
["Concrete_Wall_EP1",0,0,0,GRLIB_perm_inf],
["Land_Ind_Shed_02_EP1",0,0,0,GRLIB_perm_inf],
["HeliH",0,0,0,GRLIB_perm_inf],
["HeliHRescue",0,0,0,GRLIB_perm_inf],
["HeliHCivil",0,0,0,GRLIB_perm_inf],
["Land_strelecky_post_new",0,0,0,GRLIB_perm_inf],
["Land_GuardTower_01_F",0,0,0,GRLIB_perm_inf],
["Target_PopUp4_Moving_90deg_F",0,0,0,GRLIB_perm_inf]

];


if ( isNil "blufor_squad_inf_light" ) then { blufor_squad_inf_light = [] };

if ( count blufor_squad_inf_light == 0 ) then { blufor_squad_inf_light = []; };

if ( isNil "blufor_squad_inf" ) then { blufor_squad_inf = [] };

if ( count blufor_squad_inf == 0 ) then { blufor_squad_inf = []; };

if ( isNil "blufor_squad_at" ) then { blufor_squad_at = [] };

if ( count blufor_squad_at == 0 ) then { blufor_squad_at = []; };

if ( isNil "blufor_squad_aa" ) then { blufor_squad_aa = [] };

if ( count blufor_squad_aa == 0 ) then { blufor_squad_aa = []; };

if ( isNil "blufor_squad_mix" ) then { blufor_squad_mix = [] };

if ( count blufor_squad_mix == 0 ) then { blufor_squad_mix = []; };


squads = [
[blufor_squad_inf_light,10,300,0,GRLIB_perm_inf],
[blufor_squad_inf,20,400,0,GRLIB_perm_inf],
[blufor_squad_at,25,600,0,GRLIB_perm_inf],
[blufor_squad_aa,25,600,0,GRLIB_perm_inf],
[blufor_squad_mix,25,600,0,GRLIB_perm_inf]
];





// *** Static Weapon with AI ***
static_vehicles_AI = [];

blufor_air = [];

boats_west = [];

// All the UAVs must be declared here
uavs = [];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [];

vehicle_rearm_sources_west = [];

vehicle_big_units_west = [];

GRLIB_vehicle_whitelist_west = [];

GRLIB_vehicle_blacklist_west = [];

box_transport_config_west = [];

//GRLIB_AirDrop_1 = [];

//GRLIB_AirDrop_2 = [];

GRLIB_AirDrop_3 = [];

GRLIB_AirDrop_4 = [];

GRLIB_AirDrop_5 = [];

//GRLIB_AirDrop_6 = [];
