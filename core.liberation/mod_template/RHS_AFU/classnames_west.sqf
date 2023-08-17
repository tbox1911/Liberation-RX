// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;
GRLIB_west_modder = "mixed authors";

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

FOB_typename = "Land_Cargo_HQ_V3_F";
huron_typename = "UA_2020_CUP_Mi8AMT_01";
FOB_box_typename = "Land_Pod_Heli_Transport_04_box_black_F";
FOB_truck_typename = "rhsgref_cdf_gaz66_r142";
Respawn_truck_typename = "UA_M113";
ammo_truck_typename = "rhsusf_M977A4_AMMO_BKIT_usarmy_wd";
fuel_truck_typename = "UA_2020_CUP_KRAZ_6322_PALN";
repair_truck_typename = "rhsusf_M977A4_REPAIR_usarmy_wd";
repair_sling_typename = "Land_Pod_Heli_Transport_04_repair_F";
fuel_sling_typename = "Land_Pod_Heli_Transport_04_fuel_F";
ammo_sling_typename = "Land_Pod_Heli_Transport_04_ammo_F";
medic_sling_typename = "Land_Pod_Heli_Transport_04_medevac_F";
pilot_classname = "UA_2020_CUP_B_HeliPilot_mm14";
crewman_classname = "UA_2020_CUP_crew_mm14";
basic_weapon_typename = "Box_Syndicate_Ammo_F";

chimera_vehicle_overide = [
  ["B_Heli_Transport_01_F", "UA_2020_CUP_Mi8AMT_01"]
];

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["B_UKR_Army_Rifleman_01",1,0,0,0],
	["B_UKR_Army_Medic_01",1,0,0,0],
	["B_UKR_Army_Sapeur_01",1,0,0,0],
	["B_UKR_Army_Team_Leader_01",1,0,0,GRLIB_perm_inf],
	["B_UKR_Army_Grenadier_01",1,0,0,0],
	["B_UKR_Army_MachineGunner_01",1,0,0,GRLIB_perm_inf],
	["UA_2020_CUP_soldier_AA_F",1,0,0,GRLIB_perm_log],
	["B_UKR_Army_AT_01",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [];


// *** Territorial defense ***
resistance_squad = [
    "UA_2020_CUP_Soldier_SL_tro_mm14",
    "UA_2020_CUP_Soldier2_tro_mm14",
    "UA_2020_CUP_Soldier_AT_tro_mm14",
    "UA_2020_CUP_Soldier3_tro_mm14",
    "UA_2020_CUP_Soldier_tro_mm14",
    "UA_2020_CUP_medic_tro_mm14",
    "UA_2020_CUP_Marksman_tro_mm14",
    "UA_2020_CUP_Soldier_GL_tro_mm14",
    "UA_2020_CUP_Soldier_AR_tro_mm14"
];

resistance_squad_static = "UA_2020_CUP_DSHKM_01";

// TODO add US-supplied vehicles
light_vehicles = [
	["O_Boat_Transport_01_F",1,25,1,GRLIB_perm_inf],
	["O_Boat_Armed_01_hmg_F",5,30,5,GRLIB_perm_log],
	["C_Offroad_01_covered_F",1,10,1,0],
	["CUP_C_Octavia_CIV",1,10,1,0],
	["C_Tractor_01_F",1,25,3,0],
	["CUP_C_Golf4_kitty_Civ",1,11,1,0],
	["C_Quadbike_01_F",1,5,1,0],
	["C_Van_02_vehicle_F",1,10,1,0],
	["UA_2020_cup_Hilux_unarmed_01",1,10,1,0],
	["UA_2020_cup_Hilux_DSHKM_01",1,50,1,GRLIB_perm_inf],
	["UA_2020_cup_Hilux_metis_01",1,75,1,GRLIB_perm_inf],
	["UA_2020_cup_Hilux_AGS30_01",1,75,GRLIB_perm_inf],
	["UA_2020_cup_Hilux_SPG9_01",1,75,1,GRLIB_perm_inf],
	["UA_2020_cup_Kraz_Spartan_01",1,15,1,0],
	["Kraz_spartan_camo_gs",1,15,1,0],
	["rhsgref_cdf_btr60",5,75,2,GRLIB_perm_inf],
	["UA_btr80",5,125,2,GRLIB_perm_log],
	["UA_btr80a",5,145,2,GRLIB_perm_log],
	["UA_2020_CUP_KRAZ_6322_TENT",5,10,5,GRLIB_perm_inf],
	["UA_2020_CUP_KRAZ_6322_BORT",5,10,5,GRLIB_perm_inf],
	["UA_2020_cup_Hilux_zu23_01",10,350,10,GRLIB_perm_tank],
	["UA_2020_cup_Hilux_podnos_01",10,500,10,GRLIB_perm_tank]
];

heavy_vehicles = [
	["UA_bmp1",10,150,10,GRLIB_perm_tank],
	["BTR4E_AFU",180,80,10,GRLIB_perm_tank],
	["UA_bmp2",15,200,20,GRLIB_perm_air],
	["mkk_t64_bv_ua",15,500,20,GRLIB_perm_tank],
	["ssr_Leopard2a4",20,500,25,GRLIB_perm_tank],
	["UA_2020_CUP_2S6_01",20,750,25,GRLIB_perm_air],
	["UA_HIMARS",50,2300,100,GRLIB_perm_max]
];

air_vehicles = [
	["UA_2020_CUP_Mi8_VIV_01",10,500,20,GRLIB_perm_tank],
	["UA_2020_CUP_Mi24_P_01",20,700,30,GRLIB_perm_air],
    ["UA_2020_CUP_Mi8_01",10,800,20,GRLIB_perm_air],
    ["UA_2020_CUP_Mi8_VIV_01",10,400,20,GRLIB_perm_air],
	["UA_2020_CUP_Su25_01",20,2000,40,GRLIB_perm_max],
	["rhsgref_cdf_mig29s",20,2000,40,GRLIB_perm_max]
];

blufor_air = [
	"UA_2020_CUP_Mi24_P_01",
	"UA_2020_CUP_Mi8_01",
	"UA_2020_CUP_Mi8AMT_01",
	"UA_2020_CUP_Mi8_VIV_01",
	"UA_2020_CUP_Su25_01",
	"rhsgref_cdf_mig29s"
];

static_vehicles = [
	["UA_2020_CUP_DSHKM_01",0,15,0,0],
	["UA_2020_CUP_AGS_01",0,15,0,GRLIB_perm_inf],
	["UA_2020_CUP_DSHkM_MiniTriPod_01",0,25,0,GRLIB_perm_log],
	["UA_2020_CUP_SPG9_01",0,15,0,GRLIB_perm_log],
	["rhs_Igla_AA_pod_msv",0,50,0,GRLIB_perm_air],
	["UA_2020_CUP_Metis_01",0,50,0,GRLIB_perm_tank],
	["rhs_Kornet_9M133_2_msv",0,50,0,GRLIB_perm_tank],
	["UA_2020_CUP_ZU23_01",0,500,0,GRLIB_perm_air],
	["rhsgref_cdf_reg_BM21",10,2600,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
];

support_vehicles_west = [
	["rhsusf_M977A4_REPAIR_usarmy_wd",1,30,1,GRLIB_perm_inf],
	["rhsusf_M977A4_AMMO_BKIT_usarmy_wd",1,30,1,GRLIB_perm_inf],
	["UA_2020_CUP_KRAZ_6322_PALN",1,30,1,GRLIB_perm_inf],
	["rhs_launcher_crate",0,150,0,GRLIB_perm_tank]
];

buildings_west = [
	["Land_Cargo_Tower_V3_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V3_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V3_F",0,0,0,GRLIB_perm_log],
	["FA_UAF_FlagTrident",0,0,0,0]
];

// TODO change squads
blufor_squad_inf_light = [
	"B_UKR_Army_Medic_01",
	"B_UKR_Army_AT_01",
	"B_UKR_Army_Team_Leader_01",
	"B_UKR_Army_Team_Leader_01",
	"B_UKR_Army_Rifleman_01",
	"B_UKR_Army_Grenadier_01",
	"B_UKR_Army_Rifleman_01",
	"B_UKR_Army_Rifleman_01"
 ];
blufor_squad_inf = [
    "B_UKR_Army_Medic_01",
    "B_UKR_Army_AT_01",
    "B_UKR_Army_Team_Leader_01",
    "B_UKR_Army_AT_01",
    "B_UKR_Army_Team_Leader_01",
    "B_UKR_Army_Rifleman_01",
    "B_UKR_Army_Grenadier_01",
    "B_UKR_Army_MachineGunner_01",
	"B_UKR_Army_Rifleman_01",
	"UA_2020_CUP_B_Marksman_2"
 ];
blufor_squad_at = [
    "B_UKR_Army_Medic_01",
    "B_UKR_Army_AT_01",
    "B_UKR_Army_AT_01",
	"B_UKR_Army_AT_01",
    "UA_2020_CUP_soldier_AA_F",
    "B_UKR_Army_Rifleman_01",
    "UA_2020_CUP_B_Marksman_2"
 ];
blufor_squad_aa = [
    "B_UKR_Army_Medic_01",
    "UA_2020_CUP_soldier_AA_F",
    "UA_2020_CUP_soldier_AA_F",
	"UA_2020_CUP_soldier_AA_F",
    "B_UKR_Army_AT_01",
    "B_UKR_Army_Rifleman_01",
    "UA_2020_CUP_B_Marksman_2"
 ];
blufor_squad_mix = [
    "B_UKR_Army_Medic_01",
    "UA_2020_CUP_soldier_AA_F",
    "UA_2020_CUP_soldier_AA_F",
	"B_UKR_Army_AT_01",
    "B_UKR_Army_AT_01",
    "B_UKR_Army_Rifleman_01",
    "UA_2020_CUP_B_Marksman_2"
 ];

squads = [
	[blufor_squad_inf_light,10,300,0,GRLIB_perm_max],
	[blufor_squad_inf,20,400,0,GRLIB_perm_max],
	[blufor_squad_at,25,600,0,GRLIB_perm_max],
	[blufor_squad_aa,25,600,0,GRLIB_perm_max],
	[blufor_squad_mix,25,2500,0,GRLIB_perm_max]
];

// All the UAVs must be declared here
uavs = [
	"O_UAV_01_F",
	"O_UAV_02_dynamicLoadout_F",
	"O_T_UAV_03_F",
	"O_UAV_05_F",
	"O_UAV_06_F",
	"O_UGV_01_F",
	"O_UGV_01_rcws_F",
	"O_UGV_02_Demining_F"
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

];

GRLIB_vehicle_blacklist_west = [
	"UA_2020_CUP_DSHKM_01",
	"UA_2020_CUP_AGS_01",
	"UA_2020_CUP_DSHkM_MiniTriPod_01",
	"UA_2020_CUP_SPG9_01",
	"rhs_Igla_AA_pod_msv",
	"UA_2020_CUP_Metis_01",
	"rhs_Kornet_9M133_2_msv",
	"UA_2020_CUP_ZU23_01"
];

GRLIB_AirDrop_1 = [			// Unarmed Offroader 50
	"UA_2020_cup_Hilux_unarmed_01"
];

GRLIB_AirDrop_2 = [			// Armed Offroader 100
	"UA_2020_cup_Hilux_DSHKM_01"
];

GRLIB_AirDrop_3 = [			// MRAP 200
	"UA_2020_CUP_BRDM2_01"
];

GRLIB_AirDrop_4 = [			// Large Truck 300
	"UA_2020_CUP_KRAZ_6322_TENT"
];

GRLIB_AirDrop_5 = [			// APC 750
	"rhsgref_cdf_btr60"
];

GRLIB_AirDrop_6 = [			// Boat 250
	"O_Boat_Transport_01_F"
];
