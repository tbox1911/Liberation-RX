// *** FRIENDLIES ***

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

huron_typename = "B_FR_AS565_Panther_Marine_Nationale_01";  // comment to use value from lobby/server.cfg
FOB_typename = "Land_Cargo_HQ_V3_F";
FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "AMF_GBC180_ViV_02";
Respawn_truck_typename = "R3F_KAMAZ_DA_medevac";
ammo_truck_typename = "AMF_GBC180_AmmoTruck_02";
fuel_truck_typename = "R3F_KAMAZ_DA_fuel";
repair_truck_typename = "AMF_GBC180_MECA_02";
repair_sling_typename = "B_Slingload_01_Repair_F";
fuel_sling_typename = "B_Slingload_01_Fuel_F";
ammo_sling_typename = "B_Slingload_01_Ammo_F";
medic_sling_typename = "B_Slingload_01_Medevac_F";
pilot_classname = "R3F_APSO_PILOT_BLUFOR";
crewman_classname = "R3F_APSO_PILOT_VEHI_BLUFOR_DA";
chimera_vehicle_overide = [
  ["B_Heli_Light_01_F",  "AMF_gazelle_afte_f"],
  ["B_Heli_Transport_01_F", "AMF_panther_FRA"]
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
	["B_SDV_01_F",5,30,5,GRLIB_perm_inf],
	["B_FR_Hors_bord_01",5,150,5,GRLIB_perm_log],
	["B_Quadbike_01_F",1,5,1,0],
	["SUV_01_base_black_F",1,10,1,0],
	["B_G_Offroad_01_F",1,15,5,0],
	["C_Van_01_transport_F",1,15,7,0],
	["B_LSV_01_unarmed_F",2,25,5,GRLIB_perm_inf],
	["R3F_PVP_DA",2,50,10,GRLIB_perm_inf],
	["R3F_PVP_FN_DA",5,100,10,GRLIB_perm_inf],
	["R3F_PVP_WASP_DA",7,125,10,GRLIB_perm_log],
	["R3F_PLFS_A",5,150,10,GRLIB_perm_log],
	["AMF_GBC180_PLATEAU_02",5,100,10,GRLIB_perm_log],
	["AMF_GBC180_PERS_02",5,150,10,GRLIB_perm_log],
	["B_UGV_01_F",2,25,5,GRLIB_perm_inf],
	["B_UGV_01_rcws_F",7,200,5,GRLIB_perm_tank]
];

heavy_vehicles = [
	["B_AMF_VAB_ULTIMA_TOP_X8_TDF_F",10,250,15,GRLIB_perm_log],
	["AMF_VBMR_L_TDF_01",10,350,15,GRLIB_perm_log],
	["AMF_VBMR_GENIE_TDF",15,400,15,GRLIB_perm_tank],
	["R3F_VBMR_TDF_TOP_LG40",17,500,15,GRLIB_perm_tank],
	["AMF_VBCI_TDF_01_F",15,600,15,GRLIB_perm_tank],
	["AMF_EBRC_TDF_01",20,1000,20,GRLIB_perm_air],
	["B_AMF_AMX10_RCR_02_F",25,1750,25,GRLIB_perm_air],
	["B_AMF_AMX10_RCR_SEPAR_02_F",30,2250,25,GRLIB_perm_max],
	["B_AMF_TANK_TDF_01_F",35,3000,35,GRLIB_perm_max],
	["B_AMF_TANK_TDF_02_F",40,3500,35,GRLIB_perm_max],
	["B_FR_Scorcher_01",75,3500,60,GRLIB_perm_max]
];

air_vehicles = [
	["C_Plane_Civil_01_F",1,50,5,GRLIB_perm_log],
	["AMF_gazelle_afte_f",1,50,5,GRLIB_perm_log],
	["AMF_gazelle_minigun_f",5,100,10,GRLIB_perm_log],
	["AMF_panther_FRA",5,200,10,GRLIB_perm_tank],
	["ffaa_nh90_tth_transport",10,400,20,GRLIB_perm_tank],
	["ffaa_nh90_tth_cargo",15,600,30,GRLIB_perm_air],
	["B_AMF_Heli_Transport_4RHFS_01_F",20,1000,30,GRLIB_perm_air],
	["ffaa_famet_cougar",20,800,25,GRLIB_perm_air],
	["AMF_TIGRE_01",35,2250,35,GRLIB_perm_max],
	["B_FR_Greyhawk_01",15,1000,15,GRLIB_perm_air],
	["B_UAV_05_F",25,1500,25,GRLIB_perm_max],
	["B_FR_Rafale_M_01",40,4000,40,GRLIB_perm_max],
	["B_FR_Mirage_2000_5F_01",35,3000,40,GRLIB_perm_max]
];

blufor_air = [
	"AMF_TIGRE_01",
	"B_FR_Rafale_M_01",
	"B_FR_Mirage_2000_5F_01",
	"ffaa_nh90_tth_transport"
];

boats_west = [
	"B_FR_Hors_bord_01"
];

static_vehicles = [
	["B_UGV_02_Demining_F",0,20,0,GRLIB_perm_inf],
	["R3F_DLO_backpack",0,50,0,GRLIB_perm_inf],
	["B_Static_Designator_01_F",0,5,0,GRLIB_perm_inf],
	["R3F_FN_MAG58_fixe",0,15,0,GRLIB_perm_log],
	["I_HMG_02_high_F",0,15,0,GRLIB_perm_log],
	["B_GMG_01_F",0,20,0,GRLIB_perm_tank],
	["B_GMG_01_high_F",0,20,0,GRLIB_perm_tank],
	["B_FR_Poste_de_Tir_AA_01",0,50,0,GRLIB_perm_air],
	["R3F_MMP_STATIC",0,50,0,GRLIB_perm_tank],
	["R3F_MO81_LLR",0,1000,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
];

support_vehicles_west = [
	["AMF_GBC180_MECA_02",5,50,5,GRLIB_perm_inf],
	["B_FR_Zamak_Carburant_01",5,50,10,GRLIB_perm_inf],
	["Box_NATO_WpsLaunch_F",0,150,0,GRLIB_perm_tank],
	["B_FR_AS565_Panther_Marine_Nationale_01",10,600,25,GRLIB_perm_tank],
	["R3F_DCL_CE",15,2000,30,GRLIB_perm_max]
];

buildings_west = [
	["Land_Cargo_Tower_V3_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V3_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V3_F",0,0,0,GRLIB_perm_log],
	["Flag_UNO_F",0,0,0,0]
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
blufor_squad_recon = [
	"R3F_CQB_O",
	"R3F_CQB_1",
	"R3F_CQB_2",
	"R3F_CQB_4",
	"R3F_CQB_MEDIC",
	"R3F_CQB_1",
	"R3F_CQB_1"
];

squads = [
	[blufor_squad_inf_light,10,400,0,GRLIB_perm_max],
	[blufor_squad_inf,20,650,0,GRLIB_perm_max],
	[blufor_squad_at,25,750,0,GRLIB_perm_max],
	[blufor_squad_aa,25,750,0,GRLIB_perm_max],
	[blufor_squad_mix,25,1000,0,GRLIB_perm_max],
	[blufor_squad_recon,25,600,0,GRLIB_perm_max]
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
	"B_FR_Greyhawk_01",
	"R3F_DLO"
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [
  "R3F_DCL_CE"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"R3F_DCL_CE"
];

vehicle_rearm_sources_west = [
	"R3F_DCL_CE"
];

vehicle_big_units_west = [

];

GRLIB_vehicle_whitelist_west = [

];

GRLIB_vehicle_blacklist_west = [

];

GRLIB_AirDrop_1 = [
	"B_Quadbike_01_F"
];

GRLIB_AirDrop_2 = [
	"R3F_PVP_FN_DA"
];

GRLIB_AirDrop_3 = [
	"R3F_PLFS_A"
];

GRLIB_AirDrop_4 = [
	"AMF_GBC180_PERS_02"
];

GRLIB_AirDrop_5 = [
	"AMF_VBCI_TDF_01_F",
	"AMF_VBMR_GENIE_TDF"
];

GRLIB_AirDrop_6 = [
	"B_FR_Hors_bord_01"
];