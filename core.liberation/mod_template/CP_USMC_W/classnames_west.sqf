// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;
GRLIB_color_friendly = "ColorKhaki";

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

huron_typename = "CUP_B_CH47F_USA";  // comment to use value from lobby/server.cfg
FOB_typename = "Land_Cargo_HQ_V1_F";
FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "CUP_B_AAV_Unarmed_USMC" ;
Respawn_truck_typename = "CUP_B_nM997_USMC_WDL";
ammo_truck_typename = "CUP_B_MTVR_Ammo_USMC";
fuel_truck_typename = "CUP_B_MTVR_Refuel_USMC";
repair_truck_typename = "CUP_B_MTVR_Repair_USMC";
repair_sling_typename = "B_Slingload_01_Repair_F";
fuel_sling_typename = "B_Slingload_01_Fuel_F";
ammo_sling_typename = "B_Slingload_01_Ammo_F";
medic_sling_typename = "B_Slingload_01_Medevac_F";
pilot_classname = "CUP_B_USMC_Pilot";
crewman_classname = "CUP_B_USMC_Crew";
A3W_BoxWps = "CUP_LocalBasicWeaponsBox";

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["CUP_B_USMC_Soldier",1,0,0,0],
	["CUP_B_USMC_Medic",1,0,0,0],
	["CUP_B_USMC_Engineer",1,0,0,0],
	["CUP_B_USMC_Soldier_GL",1,0,0,GRLIB_perm_inf],
	["CUP_B_USMC_Spotter",1,0,0,GRLIB_perm_inf],
	["CUP_B_USMC_Soldier_LAT",1,0,0,0],
	["CUP_B_USMC_Soldier_AR",1,0,0,GRLIB_perm_log],
	["CUP_B_USMC_Soldier_Marksman",1,0,0,GRLIB_perm_inf],
	["CUP_B_USMC_Soldier_MG",1,0,0,GRLIB_perm_inf],
	["CUP_B_USMC_Soldier_AT",1,0,0,GRLIB_perm_log],
	["CUP_B_USMC_Soldier_AA",1,0,0,GRLIB_perm_log],
	["CUP_B_USMC_Soldier_HAT",1,0,0,GRLIB_perm_log],
	["CUP_B_USMC_Sniper_M107",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [
	"CUP_B_USMC_Soldier_AT",
	"CUP_B_USMC_Soldier_AA",
	"CUP_B_USMC_Soldier_HAT"
];	

light_vehicles = [
	["CUP_B_M1030_USMC",1,5,1,0],
	["CUP_C_Golf4_camo_Civ",1,15,1,0],
	["CUP_B_Zodiac_USMC",1,25,1,0],
	["CUP_B_RHIB_USMC",4,50,4,GRLIB_perm_log],
	["CUP_B_LCU1600_USMC",5,30,5,GRLIB_perm_log],
	["C_Van_01_transport_F",1,15,1,0],
	["CUP_B_T810_Unarmed_CZ_WDL",1,15,1,GRLIB_perm_inf],
	["CUP_B_T810_Armed_CZ_WDL",5,30,5,GRLIB_perm_log],
	["CUP_B_MTVR_USMC",5,30,5,GRLIB_perm_tank],
	["CUP_B_nM1025_Unarmed_USMC_WDL",2,10,2,0],
	["CUP_B_nM1025_M2_USMC_WDL",2,20,2,GRLIB_perm_inf],
	["CUP_B_nM1025_Mk19_USMC_WDL",2,20,2,GRLIB_perm_log],
	["CUP_B_nM1025_M240_USMC_WDL",2,30,2,GRLIB_perm_log],
	["CUP_B_M1151_Deploy_USMC",1,100,1,GRLIB_perm_inf],
	["CUP_B_M1151_Mk19_USMC",1,110,1,GRLIB_perm_inf],
	["CUP_B_M1165_GMV_USMC",1,120,1,GRLIB_perm_inf],
	["CUP_B_M1167_USMC",1,250,2,GRLIB_perm_log],
	["CUP_B_RG31_M2_OD_USMC",1,150,1,GRLIB_perm_log],
	["CUP_B_RG31_Mk19_OD_USMC",1,125,1,GRLIB_perm_log],
	["CUP_B_RG31E_M2_OD_USMC",5,200,2,GRLIB_perm_log],
	["CUP_B_M163_Vulcan_USA",10,300,10,GRLIB_perm_log],
	["CUP_B_nM1097_AVENGER_USA_WDL",5,750,10,GRLIB_perm_air],
	["CUP_B_LAV25_USMC",10,600,7,GRLIB_perm_log],
    ["CUP_B_M1126_ICV_M2_Woodland",10,450,10,GRLIB_perm_log],
	["CUP_B_M1126_ICV_MK19_Woodland",10,475,10,GRLIB_perm_log],
	["CUP_B_M1129_MC_MK19_Woodland",10,1250,15,GRLIB_perm_max]
];

heavy_vehicles = [
	["CUP_B_M1128_MGS_Woodland",12,600,15,GRLIB_perm_tank],
	["CUP_B_M1135_ATGMV_Woodland",12,650,15,GRLIB_perm_tank],
	["CUP_B_M7Bradley_USA_W",12,700,15,GRLIB_perm_tank],
	["CUP_B_M2Bradley_USA_W",12,1000,15,GRLIB_perm_air],
	["CUP_B_M2A3Bradley_USA_W",15,1750,15,GRLIB_perm_max],
	["CUP_B_M60A3_TTS_USMC",15,1500,15,GRLIB_perm_air],
	["CUP_B_M1A1SA_Woodland_US_Army",15,2000,15,GRLIB_perm_air],
	["CUP_B_M1A2SEP_TUSK_Woodland_US_Army",15,2500,17,GRLIB_perm_air],
	["CUP_B_M1A2C_TUSK_II_Woodland_US_Army",20,3000,20,GRLIB_perm_max],
	["CUP_B_Frigate_ANZAC",50,5000,50,GRLIB_perm_max]
];

air_vehicles = [
	["CUP_B_CESSNA_T41_UNARMED_USA",1,50,5,GRLIB_perm_log],
	["CUP_B_CESSNA_T41_ARMED_USA",5,200,10,GRLIB_perm_tank],
	["CUP_B_AC47_Spooky_USA",5,300,5,GRLIB_perm_max],
	["CUP_B_USMC_DYN_MQ9",10,1000,10,GRLIB_perm_air],
	["CUP_B_MH6M_USA",1,150,5,GRLIB_perm_log],
	["CUP_B_AH6M_USA",5,400,10,GRLIB_perm_air],	
	["CUP_B_UH1Y_UNA_USMC",5,300,10,GRLIB_perm_tank],
	["CUP_B_UH60S_USN",10,500,10,GRLIB_perm_air],
	["CUP_B_MH60L_DAP_2x_USN",10,1000,10,GRLIB_perm_air],
	["CUP_B_MH60L_DAP_4x_USN",10,1500,15,GRLIB_perm_max],
	["CUP_B_MH47E_USA",10,1250,10,GRLIB_perm_air],
	["CUP_B_MV22_USMC",15,1750,20,GRLIB_perm_max],
	["CUP_B_CH53E_USMC",12,1500,15,GRLIB_perm_air],
	["CUP_B_AH64D_DL_USA",20,2500,40,GRLIB_perm_max],
	["CUP_B_A10_DYN_USA",20,3000,40,GRLIB_perm_max],
	["CUP_B_F35B_USMC",20,4000,40,GRLIB_perm_max],
	["CUP_B_C130J_Cargo_USMC",20,2000,20,GRLIB_perm_max]
];

blufor_air = [
	"CUP_B_UH60S_USN",
	"CUP_B_AH64D_DL_USA",
	"CUP_B_A10_DYN_USA",
	"CUP_B_F35B_USMC"
];

boats_west = [
  	"CUP_B_LCU1600_USMC"
];

static_vehicles = [
	["CUP_B_SearchLight_static_USMC",0,10,0,GRLIB_perm_log],
	["CUP_B_M2StaticMG_USMC",0,50,0,GRLIB_perm_log],
	["CUP_B_M2StaticMG_MiniTripod_USMC",0,70,0,GRLIB_perm_tank],
	["CUP_B_MK19_TriPod_USMC",0,70,0,GRLIB_perm_tank],
	["CUP_B_Stinger_AA_pod_Base_USMC",0,150,0,GRLIB_perm_tank],
	["CUP_B_TOW_TriPod_USMC",0,150,0,GRLIB_perm_tank],
	["CUP_B_M252_USMC",0,100,0,GRLIB_perm_max],
	["CUP_B_M119_USMC",0,150,0,GRLIB_perm_air],
	["CUP_WV_B_CRAM",0,200,0,GRLIB_perm_air],
	["CUP_WV_B_RAM_Launcher",0,250,0,GRLIB_perm_max],
	["CUP_WV_B_SS_Launcher",0,250,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
	"CUP_WV_B_CRAM",
	"CUP_WV_B_RAM_Launcher",
	"CUP_WV_B_SS_Launcher"
];

support_vehicles_west = [
	["CUP_B_nM1038_Repair_USMC_WDL",5,15,5,GRLIB_perm_inf],
	["CUP_B_MTVR_Refuel_USMC",5,15,20,GRLIB_perm_inf],
	["CUP_BOX_USMC_WpsLaunch_F",0,150,0,GRLIB_perm_tank],
	["CUP_B_AAV_Unarmed_USMC",10,2000,20,GRLIB_perm_max]
];

buildings_west = [
	["Land_Cargo_Tower_V1_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V1_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V1_F",0,0,0,GRLIB_perm_log],
	["FlagCarrierUSA",0,0,0,0],
	["WarfareBunkerSign",0,0,0,0]
];

if ( isNil "blufor_squad_inf_light" ) then { blufor_squad_inf_light = [] };
if ( count blufor_squad_inf_light == 0 ) then { blufor_squad_inf_light = [
	"CUP_B_USMC_Soldier_SL",
	"CUP_B_USMC_Medic",
	"CUP_B_USMC_Soldier_GL",
	"CUP_B_USMC_Soldier_AR",
	"CUP_B_USMC_Soldier_LAT",
	"CUP_B_USMC_Engineer",
	"CUP_B_USMC_Soldier",
	"CUP_B_USMC_Soldier"
	];
};
if ( isNil "blufor_squad_inf" ) then { blufor_squad_inf = [] };
if ( count blufor_squad_inf == 0 ) then { blufor_squad_inf = [
	"CUP_B_USMC_Soldier_SL",
	"CUP_B_USMC_Medic",
	"CUP_B_USMC_Spotter",
	"CUP_B_USMC_Soldier_AR",
	"CUP_B_USMC_Soldier_MG",
	"CUP_B_USMC_Soldier_Marksman",
	"CUP_B_USMC_Soldier_LAT",
	"CUP_B_USMC_Engineer",
	"CUP_B_USMC_Soldier",	
	"CUP_B_USMC_Soldier"
	];
};
if ( isNil "blufor_squad_at" ) then { blufor_squad_at = [] };
if ( count blufor_squad_at == 0 ) then { blufor_squad_at = [
	"CUP_B_USMC_Soldier_SL",
	"CUP_B_USMC_Medic",
	"CUP_B_USMC_Soldier_HAT",
	"CUP_B_USMC_Soldier_LAT",
	"CUP_B_USMC_Engineer",
	"CUP_B_USMC_Soldier"
	];
};
if ( isNil "blufor_squad_aa" ) then { blufor_squad_aa = [] };
if ( count blufor_squad_aa == 0 ) then { blufor_squad_aa = [
	"CUP_B_USMC_Soldier_SL",
	"CUP_B_USMC_Medic",
	"CUP_B_USMC_Soldier_AA",
	"CUP_B_USMC_Soldier_AA",
	"CUP_B_USMC_Engineer",
	"CUP_B_USMC_Soldier"
	];
};
if ( isNil "blufor_squad_mix" ) then { blufor_squad_mix = [] };
if ( count blufor_squad_mix == 0 ) then { blufor_squad_mix = [
	"CUP_B_USMC_Soldier_SL",
	"CUP_B_USMC_Medic",
	"CUP_B_USMC_Soldier_AA",
	"CUP_B_USMC_Soldier_HAT",
	"CUP_B_USMC_Engineer",
	"CUP_B_USMC_Soldier"
	];
};

squads = [
	[blufor_squad_inf_light,10,300,0,GRLIB_perm_max],
	[blufor_squad_inf,20,400,0,GRLIB_perm_max],
	[blufor_squad_at,25,600,0,GRLIB_perm_max],
	[blufor_squad_aa,25,600,0,GRLIB_perm_max],
	[blufor_squad_mix,25,600,0,GRLIB_perm_max]
];

// All the UAVs must be declared here
uavs = [
	"B_UAV_01_F",
	"B_UAV_02_dynamicLoadout_F",
	"B_T_UAV_03_dynamicLoadout_F",
	"B_UAV_05_F",
	"B_UAV_06_F",
	"C_UAV_06_F",
	"B_UGV_01_F",
	"B_UGV_01_rcws_F",
	"B_UGV_02_Demining_F",
	"CUP_B_USMC_DYN_MQ9"
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [
  "CUP_B_AAV_Unarmed_USMC"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"CUP_B_AAV_Unarmed_USMC"
];

vehicle_rearm_sources_west = [
	"CUP_B_AAV_Unarmed_USMC"
];

vehicle_big_units_west = [
	"CUP_B_LCU1600_USMC"
];

GRLIB_vehicle_whitelist_west = [

];

GRLIB_vehicle_blacklist_west = [
	"CUP_B_SearchLight_static_USMC",
	"CUP_B_M2StaticMG_USMC",
	"CUP_B_M2StaticMG_MiniTripod_USMC",
	"CUP_B_M252_USMC",
	"CUP_B_M119_USMC",
	"CUP_B_MK19_TriPod_USMC",
	"CUP_B_Stinger_AA_pod_Base_USMC",
	"CUP_B_TOW_TriPod_USMC"
];

box_transport_config_west = [
	[ "CUP_B_MTVR_USMC", -6.5, [0, -0.4, 0.3], [0, -2.1, 0.3] ],
	[ "CUP_B_T810_Unarmed_CZ_DES", -5.5, [0, 0.3, 0], [0, -1.25, 0] ],
	[ "CUP_B_T810_Armed_CZ_DES", -5.5, [0, 0.3, -0.3], [0, -1.25, -0.3] ]
];

//GRLIB_AirDrop_1 = [];
//GRLIB_AirDrop_2 = [];
GRLIB_AirDrop_3 = [
	"CUP_B_T810_Armed_CZ_DES",
	"CUP_B_nM1025_M2_USMC_WDL",
	"CUP_B_M1151_Deploy_USMC",
	"CUP_B_RG31_M2_OD_USMC"	
];
GRLIB_AirDrop_4 = [
	"CUP_B_T810_Unarmed_CZ_DES",
	"CUP_B_T810_Armed_CZ_DES",
	"CUP_B_MTVR_USMC"
];
GRLIB_AirDrop_5 = [
	"CUP_B_M1126_ICV_M2_Woodland",
	"CUP_B_M1126_ICV_MK19_Woodland",
	"CUP_B_RG31E_M2_OD_USMC"
];
//GRLIB_AirDrop_6 = [];