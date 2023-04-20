// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

huron_typename = "R3F_MERLIN_DA";  // comment to use value from lobby/server.cfg
FOB_typename = "Land_Cargo_HQ_V3_F";
FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "R3F_HEMTT_DA_log";
Respawn_truck_typename = "R3F_KAMAZ_DA_medevac";
ammo_truck_typename = "I_E_Truck_02_Ammo_F";
fuel_truck_typename = "R3F_KAMAZ_DA_fuel";
repair_truck_typename = "I_E_Truck_02_Box_F";
repair_sling_typename = "B_Slingload_01_Repair_F";
fuel_sling_typename = "B_Slingload_01_Fuel_F";
ammo_sling_typename = "B_Slingload_01_Ammo_F";
medic_sling_typename = "B_Slingload_01_Medevac_F";
pilot_classname = "R3F_APSO_PILOT_BLUFOR";
crewman_classname = "R3F_APSO_PILOT_VEHI_BLUFOR_DA";
chimera_vehicle_overide = [
	["B_Heli_Light_01_F",  "R3F_AH6_DA"],
	["B_Heli_Transport_01_F", "R3F_LYNX_DA"]
];

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["R3F_FANTASSIN_300_BLUFOR_DA",1,0,0,0],
	["R3F_APSO_MEDIC_BLUFOR_DA",1,0,0,0],
	["R3F_APSO_BLUFOR_DA",1,0,0,0],
	["R3F_FANTASSIN_600_BLUFOR_DA",1,0,0,GRLIB_perm_inf],
	["R3F_FANTASSIN_AT_BLUFOR_DA",1,0,0,GRLIB_perm_inf],
	["B_soldier_AA_F",1,0,0,GRLIB_perm_log],
	["R3F_FANTASSIN_MG_BLUFOR_DA",1,0,0,GRLIB_perm_log],
	["R3F_FANTASSIN_TP_BLUFOR_DA",1,0,0,GRLIB_perm_log],
	["R3F_URR_PLONGEUR_BLUFOR_DA",1,0,0,GRLIB_perm_log],
	["B_soldier_PG_F",1,0,0,GRLIB_perm_log],
	["R3F_CDE600_APSO_AF_BLUFOR",1,0,0,GRLIB_perm_tank],
	["R3F_URR_TE_BLUFOR_DA",1,0,0,GRLIB_perm_tank],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [
	"B_soldier_AA_F",
	"B_soldier_PG_F",
	"R3F_APSO_BLUFOR_DA",
	"R3F_CDE600_APSO_AF_BLUFOR"
];

light_vehicles = [
	["C_Scooter_Transport_01_F",1,5,1,0],
	["B_Boat_Transport_01_F",1,25,1,0],
	["C_Boat_Transport_02_F",5,150,5,GRLIB_perm_inf],
	["B_Boat_Armed_01_minigun_F",5,130,5,GRLIB_perm_log],
	["B_Quadbike_01_F",1,5,1,0],
	["C_Van_01_transport_F",1,15,7,0],
	["R3F_KAMAZ_DA_trans",1,25,7,0],
	["R3F_KAMAZ_DA_VPC",1,25,8,GRLIB_perm_inf],
	["R3F_PLFS_A",5,120,12,GRLIB_perm_inf],
	["R3F_PVP_FN_DA",2,65,12,0],
	["R3F_PVP_WASP_DA_COMMANDEMENT",2,75,12,0],
	["R3F_FENNEC_DA",2,25,12,0],
	["R3F_FENNEC_DA_HMG",5,100,12,GRLIB_perm_inf],
	["R3F_FENNEC_DA_GMG",5,125,12,GRLIB_perm_log],
	["R3F_MATV_DA",2,40,12,0],
	["R3F_MATV_DA_HMG",5,120,12,GRLIB_perm_inf],
	["R3F_MATV_DA_GMG",5,145,12,GRLIB_perm_log]
];

heavy_vehicles = [
	["R3F_VBMR_DA",5,300,15,GRLIB_perm_log],
	["R3F_VBMR_DA_TOP_127",10,450,25,GRLIB_perm_tank],
	["R3F_VBMR_DA_TOP_LG40",10,500,25,GRLIB_perm_tank],
	["R3F_PANDUR_DA",12,650,25,GRLIB_perm_log],
	["B_APC_Tracked_01_AA_F",10,500,20,GRLIB_perm_tank],
	["R3F_MBT52_DA",15,1500,35,GRLIB_perm_tank],
	["B_MBT_01_TUSK_F",15,1500,35,GRLIB_perm_air],
	["B_MBT_01_arty_F",15,3500,30,GRLIB_perm_max]
];

air_vehicles = [
	["R3F_DLO",1,10,5,GRLIB_perm_log],
	["C_Plane_Civil_01_F",1,50,5,GRLIB_perm_inf],
	["R3F_AH6_DA",1,50,5,GRLIB_perm_inf],
	["R3F_AH6_DA_ARMED",5,100,10,GRLIB_perm_tank],
	["R3F_LYNX_DA",15,500,10,GRLIB_perm_tank],
	["R3F_LYNX_DA_ARMED",20,1000,30,GRLIB_perm_air],
	["R3F_LYNX_DA_EVASAN",20,1000,30,GRLIB_perm_air],
	["R3F_MERLIN_DA",15,1000,15,GRLIB_perm_air],
	["R3F_TIGRE",35,2250,35,GRLIB_perm_air],
	["R3F_ALCA_ADLA",35,3000,40,GRLIB_perm_air],
	["R3F_GRIPEN",40,4000,40,GRLIB_perm_max]
];

blufor_air = [
	"R3F_TIGRE",
	"R3F_LYNX_DA_ARMED",
	"R3F_ALCA_ADLA",
	"R3F_GRIPEN"
];

boats_west = [
  	"B_Boat_Transport_01_F",
	"B_Boat_Armed_01_minigun_F",
	"B_T_Boat_Armed_01_minigun_F"
];

static_vehicles = [
	["R3F_FN_MAG58_fixe",0,10,0,GRLIB_perm_log],
	["B_GMG_01_high_F",0,20,0,GRLIB_perm_inf],
	["R3F_MMP_STATIC",0,150,0,GRLIB_perm_tank],
	["B_static_AA_F",0,150,0,GRLIB_perm_air],
	["R3F_MO81_LLR",0,500,0,GRLIB_perm_max],
	["B_SAM_System_01_F",10,1500,0,GRLIB_perm_tank],
	["B_SAM_System_02_F",10,1500,0,GRLIB_perm_air],
	["B_AAA_System_01_F",10,1500,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
	"B_SAM_System_01_F",
	"B_SAM_System_02_F",
	"B_AAA_System_01_F"
];

support_vehicles_west = [
	["B_G_Offroad_01_repair_F",5,15,5,GRLIB_perm_inf],
	["B_G_Van_01_fuel_F",5,15,20,GRLIB_perm_inf],
	["B_Truck_01_transport_F",5,30,15,GRLIB_perm_log],
	["R3F_DCL_DA",15,2000,30,GRLIB_perm_max]
];

buildings_west = [
	["Land_Cargo_Tower_V3_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V3_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V3_F",0,0,0,GRLIB_perm_log],
	["Flag_NATO_F",0,0,0,0]
];

blufor_squad_inf_light = [
	"R3F_APSO_SOUSOFF_BLUFOR_DA",
	"R3F_APSO_MEDIC_BLUFOR_DA",
	"R3F_FANTASSIN_600_BLUFOR_DA",
	"R3F_FANTASSIN_MG_BLUFOR_DA",
	"R3F_FANTASSIN_300_BLUFOR_DA",
	"R3F_FANTASSIN_300_BLUFOR_DA"
];
blufor_squad_inf = [
	"R3F_APSO_SOUSOFF_BLUFOR_DA",
	"R3F_APSO_MEDIC_BLUFOR_DA",
	"R3F_URR_OBS_BLUFOR_DA",
	"R3F_FANTASSIN_MG_BLUFOR_DA",
	"R3F_FANTASSIN_AT_BLUFOR_DA",
	"R3F_FANTASSIN_600_BLUFOR_DA",
	"R3F_FANTASSIN_AT_BLUFOR_DA",
	"R3F_FANTASSIN_300_BLUFOR_DA",
	"R3F_FANTASSIN_300_BLUFOR_DA"
];
blufor_squad_at = [
	"R3F_APSO_SOUSOFF_BLUFOR_DA",
	"R3F_APSO_MEDIC_BLUFOR_DA",
	"R3F_CDE600_APSO_AF_BLUFOR",
	"R3F_CDE600_APSO_AF_BLUFOR",
	"R3F_FANTASSIN_300_BLUFOR_DA",
	"R3F_FANTASSIN_300_BLUFOR_DA"
];
blufor_squad_aa = [
	"R3F_APSO_SOUSOFF_BLUFOR_DA",
	"R3F_APSO_MEDIC_BLUFOR_DA",
	"B_soldier_AA_F",
	"B_soldier_AA_F",
	"R3F_FANTASSIN_300_BLUFOR_DA",
	"R3F_FANTASSIN_300_BLUFOR_DA"
];
blufor_squad_mix = [
	"R3F_APSO_SOUSOFF_BLUFOR_DA",
	"R3F_APSO_MEDIC_BLUFOR_DA",
	"B_soldier_AA_F",
	"R3F_CDE600_APSO_AF_BLUFOR",
	"R3F_FANTASSIN_600_BLUFOR_DA",
	"R3F_FANTASSIN_300_BLUFOR_DA",
	"R3F_FANTASSIN_300_BLUFOR_DA",
	"R3F_FANTASSIN_MG_BLUFOR_DA",
	"R3F_FANTASSIN_TP_BLUFOR_DA"
];

squads = [
	[blufor_squad_inf_light,10,400,0,GRLIB_perm_max],
	[blufor_squad_inf,20,650,0,GRLIB_perm_max],
	[blufor_squad_at,25,750,0,GRLIB_perm_max],
	[blufor_squad_aa,25,750,0,GRLIB_perm_max],
	[blufor_squad_mix,25,1000,0,GRLIB_perm_max]
];

// All the UAVs must be declared here
uavs = [
	"R3F_DLO"
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [
	"R3F_DCL_DA"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"R3F_DCL_DA"
];

vehicle_rearm_sources_west = [
	"R3F_DCL_DA"
];

vehicle_big_units_west = [

];

GRLIB_vehicle_whitelist_west = [

];

GRLIB_vehicle_blacklist_west = [

];

GRLIB_AirDrop_1 = [
	"B_Quadbike_01_F",
	"R3F_FENNEC_DA",
	"R3F_MATV_DA"
];

GRLIB_AirDrop_2 = [
	"R3F_PVP_WASP_DA_COMMANDEMENT",
	"R3F_PVP_FN_DA",
	"R3F_PLFS_A"
];

GRLIB_AirDrop_3 = [
	"R3F_PLFS_A",
	"R3F_FENNEC_DA_HMG",
	"R3F_FENNEC_DA_GMG",
	"R3F_MATV_DA_HMG",
	"R3F_MATV_DA_GMG"
];

GRLIB_AirDrop_4 = [
	"C_Van_01_transport_F",
	"R3F_KAMAZ_DA_trans",
	"R3F_KAMAZ_DA_VPC"
];

GRLIB_AirDrop_5 = [
	"R3F_PANDUR_DA",
	"R3F_VBMR_TOP_127",
	"R3F_VBMR_TOP_LG40"
];

GRLIB_AirDrop_6 = [
	"B_Boat_Transport_01_F",
	"C_Boat_Transport_02_F",
	"B_Boat_Armed_01_minigun_F"
];