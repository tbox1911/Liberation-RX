// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

huron_typename = "CUP_B_UH60M_Unarmed_FFV_MEV_US";  // comment to use value from lobby/server.cfg
FOB_typename = "Land_Cargo_HQ_V1_F";
FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "CUP_B_MTVR_Ammo_BAF_DES";
Respawn_truck_typename = "CUP_B_M113A3_Med_desert_USA";
ammo_truck_typename = "CUP_B_MTVR_Ammo_USA";
fuel_truck_typename = "CUP_B_MTVR_Refuel_USA";
repair_truck_typename = "CUP_B_MTVR_Repair_USA";
repair_sling_typename = "B_Slingload_01_repair_F";
fuel_sling_typename = "B_Slingload_01_Fuel_F";
ammo_sling_typename = "B_Slingload_01_Ammo_F";
medic_sling_typename = "B_Slingload_01_Medevac_F";
pilot_classname = "CUP_B_USMC_Pilot_des";
crewman_classname = "CUP_B_USMC_Crew_des";
A3W_BoxWps = "CUP_LocalBasicWeaponsBox";
chimera_vehicle_overide = [
  ["B_Heli_Light_01_F",  "CUP_B_MH6M_USA"],
  ["B_Heli_Transport_01_F", "CUP_B_UH60M_US"]
];

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["CUP_B_USMC_Soldier_des",1,0,0,0],
	["CUP_B_USMC_Medic_des",1,0,0,0],
	["CUP_B_USMC_Engineer_des",1,0,0,0],
	["CUP_B_USMC_Soldier_GL_des",1,0,0,GRLIB_perm_inf],
	["CUP_B_USMC_Soldier_AR_des",1,0,0,GRLIB_perm_inf],
	["CUP_B_USMC_Soldier_AT_des",1,0,0,GRLIB_perm_inf],
	["CUP_B_USMC_Soldier_Marksman_des",1,0,0,GRLIB_perm_inf],
	["CUP_B_HIL_Diver_MP5_SF",1,0,0,GRLIB_perm_log],
	["CUP_B_USMC_Soldier_MG_des",1,0,0,GRLIB_perm_log],
	["CUP_B_USMC_Soldier_AA_des",1,0,0,GRLIB_perm_log],
	["CUP_B_USMC_Soldier_HAT_des",1,0,0,GRLIB_perm_tank],
	["CUP_B_USMC_Sniper_M40A3_des",1,0,0,GRLIB_perm_tank],
	["CUP_B_USMC_Sniper_M107_des",1,0,0,GRLIB_perm_air],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [
	"CUP_B_USMC_Soldier_AA_des",
	"CUP_B_USMC_Soldier_HAT_des"
];

light_vehicles = [
	// Drone
	["B_UGV_01_F",5,10,5,GRLIB_perm_inf],
	["B_UGV_01_rcws_F",5,250,5,GRLIB_perm_tank],
	// Boat
	["CUP_C_PBX_CIV",1,5,1,0],
	["CUP_B_Zodiac_USMC",1,15,1,GRLIB_perm_inf],
	["CUP_C_Fishing_Boat_Chernarus",1,50,2,GRLIB_perm_log],
	["B_SDV_01_F",1,25,1,GRLIB_perm_log],
	["CUP_B_RHIB_USMC",5,100,5,GRLIB_perm_tank],
	["CUP_B_RHIB2Turret_USMC",5,125,5,GRLIB_perm_tank],
	["CUP_B_LCU1600_USMC",1,200,7,GRLIB_perm_tank],
	// Land
	["CUP_B_M1030_USMC",1,5,1,0],
	["CUP_C_Octavia_CIV",1,10,2,0],
	["CUP_C_Datsun_4seat",1,12,2,0],
	["CUP_C_Pickup_unarmed_CIV",1,20,3,0],
	["CUP_C_S1203_CIV_CR",1,15,5,0],
	["CUP_B_MTVR_USA",2,40,15,0],
	["CUP_B_nM1097_AVENGER_USMC_DES",4,175,8,GRLIB_perm_tank],
	["CUP_B_nM1038_4s_USA_DES",2,50,7,GRLIB_perm_inf],
	["CUP_B_nM1025_Unarmed_USA_DES",2,30,2,GRLIB_perm_inf],
	["CUP_B_nM1037sc_USA_DES",2,30,2,GRLIB_perm_inf],
	["CUP_B_nM1025_SOV_M2_USA_DES",3,50,3,GRLIB_perm_inf],
	["CUP_B_nM1025_SOV_Mk19_USA_DES",3,75,4,GRLIB_perm_inf],
	["CUP_B_M1151_Deploy_USA",4,100,4,GRLIB_perm_log],
	["CUP_B_M1151_Mk19_USA",4,125,5,GRLIB_perm_log],
	["CUP_B_M1165_GMV_USA",4,150,6,GRLIB_perm_log],
	["CUP_B_nM1036_TOW_USA_DES",6,225,7,GRLIB_perm_log],
	["CUP_B_M1167_USA",8,300,5,GRLIB_perm_tank],
	["CUP_B_RG31_M2_USA",6,300,7,GRLIB_perm_tank],
	["CUP_B_RG31_Mk19_USA",6,350,8,GRLIB_perm_tank],
	["CUP_B_RG31E_M2_USA",6,375,10,GRLIB_perm_tank]
];

heavy_vehicles = [
	// AA
	["CUP_B_M6LineBacker_USA_D",15,1000,15,GRLIB_perm_air],
	// Arti
	["CUP_B_M1129_MC_MK19_Desert",45,3000,50,GRLIB_perm_max],
	// Other
	["CUP_B_M113A3_desert_USA",10,400,10,GRLIB_perm_log],
	["CUP_B_M113A3_Reammo_desert_USA",7,300,10,GRLIB_perm_log],
	["CUP_B_M113A3_Repair_desert_USA",7,300,10,GRLIB_perm_log],
	["CUP_B_M1126_ICV_M2_Desert",15,600,15,GRLIB_perm_log],
	["CUP_B_M1126_ICV_MK19_Desert",15,700,15,GRLIB_perm_log],
	["CUP_B_M1128_MGS_Desert",30,2000,25,GRLIB_perm_air],
	["CUP_B_M1135_ATGMV_Desert",30,2000,25,GRLIB_perm_air],
	["CUP_B_LAV25M240_desert_USMC",20,800,20,GRLIB_perm_tank],
	["CUP_B_M7Bradley_USA_D",20,850,20,GRLIB_perm_tank],
	["CUP_B_M2Bradley_USA_D",35,1500,35,GRLIB_perm_air],
	["CUP_B_M2A3Bradley_USA_D",50,2000,35,GRLIB_perm_max],
	["CUP_B_M1A1SA_Desert_US_Army",40,3000,40,GRLIB_perm_air],
	["CUP_B_M1A2SEP_TUSK_II_Desert_US_Army",50,3500,50,GRLIB_perm_max]
];

air_vehicles = [
	// Drone
	["CUP_B_USMC_DYN_MQ9",30,2500,35,GRLIB_perm_air],
	// Other
	["CUP_B_CESSNA_T41_UNARMED_USA",2,50,2,GRLIB_perm_log],
	["CUP_B_CESSNA_T41_ARMED_USA",10,600,35,GRLIB_perm_air],
	["CUP_B_AC47_Spooky_USA",15,1500,20,GRLIB_perm_air],
	["CUP_B_MH6M_USA",2,125,10,GRLIB_perm_log],
	["CUP_B_AH6M_USA",20,1500,20,GRLIB_perm_air],
	["CUP_B_UH60M_US",5,250,15,GRLIB_perm_tank],
	["CUP_B_MH60L_DAP_2x_US",20,1750,25,GRLIB_perm_air],
	["CUP_B_MH47E_USA",5,400,20,GRLIB_perm_tank],
	["CUP_B_CH53E_USMC",5,600,25,GRLIB_perm_air],
	["CUP_B_MV22_USMC_RAMPGUN",5,750,25,GRLIB_perm_air],
	["CUP_B_AH1Z_Dynamic_USMC",30,2500,40,GRLIB_perm_max],
	["CUP_B_AH64D_DL_USA",40,3000,50,GRLIB_perm_max],
	["CUP_B_C130J_Cargo_USMC",50,1000,50,GRLIB_perm_max],
	["CUP_B_A10_DYN_USA",60,4000,40,GRLIB_perm_max],
	["CUP_B_AV8B_DYN_USMC",50,3500,50,GRLIB_perm_max],
	["CUP_B_F35B_USMC",60,4000,60,GRLIB_perm_max]
];

blufor_air = [
	"CUP_B_AH1Z_Dynamic_USMC",
	"CUP_B_AH64D_DL_USA",
	"CUP_B_A10_DYN_USA",
	"CUP_B_AV8B_DYN_USMC",
	"CUP_B_F35B_USMC"
];

boats_west = [
	"CUP_C_PBX_CIV",
	"CUP_B_Zodiac_USMC",
	"CUP_C_Fishing_Boat_Chernarus",
	"CUP_B_RHIB_USMC",
	"CUP_B_RHIB2Turret_USMC",
	"CUP_B_LCU1600_USMC"
];

static_vehicles = [
	["B_Static_Designator_01_F",0,5,0,GRLIB_perm_inf],
	["CUP_B_M2StaticMG_US",0,20,0,GRLIB_perm_log],
	["CUP_B_M2StaticMG_MiniTripod_US",0,25,0,GRLIB_perm_tank],
	["CUP_B_MK19_TriPod_US",0,40,0,GRLIB_perm_log],
	["CUP_B_M134_A_US_ARMY",0,40,0,GRLIB_perm_tank],
	["CUP_B_TOW2_TriPod_US",0,100,0,GRLIB_perm_air],
	["CUP_B_CUP_Stinger_AA_pod_US",0,100,0,GRLIB_perm_air],
	["CUP_B_M252_US",5,600,0,GRLIB_perm_max],
	["CUP_B_M119_US",25,1500,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
];

support_vehicles_west = [
	["CUP_B_nM1038_Repair_USA_DES",5,30,5,GRLIB_perm_inf],
	["CUP_B_nM1038_Ammo_USA_DES",10,30,5,GRLIB_perm_inf],
	["CUP_B_UH60M_Unarmed_FFV_MEV_US",5,600,15,GRLIB_perm_tank],
	["B_APC_Tracked_01_CRV_F",15,2000,50,GRLIB_perm_max]
];

buildings_west = [
	["Land_Cargo_Tower_V3_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V3_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V3_F",0,0,0,GRLIB_perm_log],
	["Flag_US_F",0,0,0,0]
];

blufor_squad_inf_light = [
	"CUP_B_USMC_Soldier_SL_des",
	"CUP_B_USMC_Medic_des",
	"CUP_B_USMC_Soldier_GL_des",
	"CUP_B_USMC_Soldier_AR_des",
	"CUP_B_USMC_Soldier_LAT_des",
	"CUP_B_USMC_Soldier_des"
];
blufor_squad_inf = [
	"CUP_B_USMC_Soldier_SL_des",
	"CUP_B_USMC_Medic_des",
	"CUP_B_USMC_Soldier_Marksman_des",
	"CUP_B_USMC_Soldier_AR_des",
	"CUP_B_USMC_Soldier_LAT_des",
	"CUP_B_USMC_Soldier_MG_des",
	"CUP_B_USMC_Sniper_M40A3_des",
	"CUP_B_USMC_Soldier_des",
	"CUP_B_USMC_Soldier_des"
];
blufor_squad_at = [
	"CUP_B_USMC_Soldier_SL_des",
	"CUP_B_USMC_Medic_des",
	"CUP_B_USMC_Soldier_HAT_des",
	"CUP_B_USMC_Soldier_AT_des",
	"CUP_B_USMC_Soldier_des",
	"CUP_B_USMC_Soldier_des"
];
blufor_squad_aa = [
	"CUP_B_USMC_Soldier_SL_des",
	"CUP_B_USMC_Medic_des",
	"CUP_B_USMC_Soldier_AA_des",
	"CUP_B_USMC_Soldier_AA_des",
	"CUP_B_USMC_Soldier_des",
	"CUP_B_USMC_Soldier_des"
];
blufor_squad_mix = [
	"CUP_B_USMC_Soldier_SL_des",
	"CUP_B_USMC_Medic_des",
	"CUP_B_USMC_Soldier_AT_des",
	"CUP_B_USMC_Soldier_AA_des",
	"CUP_B_USMC_Soldier_des",
	"CUP_B_USMC_Soldier_des"
];

squads = [
	[blufor_squad_inf_light,15,400,0,GRLIB_perm_max],
	[blufor_squad_inf,25,550,0,GRLIB_perm_max],
	[blufor_squad_at,25,600,0,GRLIB_perm_max],
	[blufor_squad_aa,25,600,0,GRLIB_perm_max],
	[blufor_squad_mix,25,600,0,GRLIB_perm_max]
];

// All the UAVs must be declared here
uavs = [
	"CUP_B_USMC_DYN_MQ9",
	"B_UGV_01_F",
	"B_UGV_01_rcws_F"
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [
	"B_APC_Tracked_01_CRV_F"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"B_APC_Tracked_01_CRV_F"
];

vehicle_rearm_sources_west = [
	"B_APC_Tracked_01_CRV_F"
];

vehicle_big_units_west = [

];

GRLIB_vehicle_whitelist_west = [

];

GRLIB_vehicle_blacklist_west = [

];

GRLIB_AirDrop_1 = [
	"CUP_C_Octavia_CIV"
];

GRLIB_AirDrop_2 = [
	"CUP_B_nM1025_SOV_M2_USA_DES"
];

GRLIB_AirDrop_3 = [
	"CUP_B_M1151_Deploy_USA"
];

GRLIB_AirDrop_4 = [
	"CUP_B_MTVR_USA"
];

GRLIB_AirDrop_5 = [
	"CUP_B_M1126_ICV_M2_Desert"
];

GRLIB_AirDrop_6 = [
	"CUP_B_RHIB_USMC"
];