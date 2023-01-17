// *** FRIENDLIES ***
GRLIB_side_friendly = EAST;

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

huron_typename = "O_Heli_Transport_04_black_F";
FOB_typename = "Land_Cargo_HQ_V3_F";
FOB_box_typename = "Land_Pod_Heli_Transport_04_box_black_F";
FOB_truck_typename = "O_T_Truck_03_device_ghex_F";
Respawn_truck_typename = "O_Truck_03_medical_F";
ammo_truck_typename = "CUP_O_Kamaz_Reammo_RU";
fuel_truck_typename = "CUP_O_Kamaz_Refuel_RU";
repair_truck_typename = "O_Truck_03_Repair_F";
repair_sling_typename = "Land_Pod_Heli_Transport_04_repair_F";
fuel_sling_typename = "Land_Pod_Heli_Transport_04_fuel_F";
ammo_sling_typename = "Land_Pod_Heli_Transport_04_ammo_F";
medic_sling_typename = "Land_Pod_Heli_Transport_04_medevac_F";
pilot_classname = "CUP_O_RU_Pilot";
crewman_classname = "CUP_O_RU_Soldier_Crew_M_EMR_V2";
A3W_BoxWps = "CUP_BOX_RU_Wps_F";
chimera_vehicle_overide = [
  ["B_Heli_Light_01_F", "CUP_O_UH1H_SLA"],
  ["B_Heli_Transport_01_F", "CUP_O_Mi8_VIV_RU"]
];

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["CUP_O_RU_Soldier_M_EMR_V2",1,0,0,0],
	["CUP_O_RU_Soldier_Medic_M_EMR_V2",1,0,0,0],
	["CUP_O_RU_Soldier_Engineer_M_EMR_V2",1,0,0,0],
	["CUP_O_RU_Soldier_GL_M_EMR_V2",1,0,0,GRLIB_perm_inf],
	["CUP_O_RU_Soldier_Marksman_M_EMR_V2",1,0,0,GRLIB_perm_inf],
	["CUP_O_RU_Soldier_LAT_M_EMR_V2",1,0,0,0],
	["CUP_O_RU_Sniper_M_EMR",1,0,0,GRLIB_perm_inf],
	["CUP_O_RU_Soldier_MG_M_EMR_V2",1,0,0,GRLIB_perm_inf],
	["CUP_O_RU_Soldier_AR_M_EMR_V2",1,0,0,GRLIB_perm_log],
	["CUP_O_RU_Soldier_AA_M_EMR_V2",1,0,0,GRLIB_perm_log],
	["CUP_O_RU_Soldier_HAT_M_EMR_V2",1,0,0,GRLIB_perm_log],
	["CUP_O_RU_Sniper_KSVK_M_EMR",1,0,0,GRLIB_perm_log],
	["CUP_O_RU_Soldier_Saiga_M_EMR_V2",1,0,0,GRLIB_perm_log],
	["O_diver_F",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];
units_loadout_overide = [
];

light_vehicles = [
	["O_Quadbike_01_F",1,5,1,0],
	["O_Boat_Transport_01_F",1,25,1,GRLIB_perm_inf],
	["O_Boat_Armed_01_hmg_F",5,30,5,GRLIB_perm_log],
	["B_SDV_01_F",5,30,5,GRLIB_perm_log],
	["C_Scooter_Transport_01_F",1,5,1,0],
	["O_G_Offroad_01_F",1,10,1,0],
	["CUP_O_UAZ_Unarmed_RU",1,10,5,0],
	["CUP_O_UAZ_MG_RU",1,60,5,0],
	["CUP_O_UAZ_SPG9_RU",1,180,5,GRLIB_perm_inf],
	["CUP_O_UAZ_METIS_RU",1,250,5,GRLIB_perm_log],
	["CUP_O_UAZ_AA_RU",1,250,5,GRLIB_perm_log],
	["CUP_O_UAZ_AGS30_RU",1,250,5,GRLIB_perm_log],
	["C_Van_01_transport_F",1,15,1,0],
	["CUP_O_LR_Transport_TKA",1,15,1,0],
	["CUP_O_GAZ_Vodnik_Unarmed_RU",1,10,7,GRLIB_perm_inf],
	["CUP_O_GAZ_Vodnik_PK_RU",1,50,7,GRLIB_perm_inf],
	["CUP_O_GAZ_Vodnik_AGS_RU",1,80,7,GRLIB_perm_log],
	["CUP_O_GAZ_Vodnik_BPPU_RU",1,80,7,GRLIB_perm_log],
	["CUP_O_GAZ_Vodnik_KPVT_RU",1,80,7,GRLIB_perm_log],
	["CUP_O_BM21_RU",5,100,2,GRLIB_perm_inf],
	["CUP_O_Kamaz_Open_RU",5,10,10,GRLIB_perm_inf],
	["CUP_O_Kamaz_RU",5,50,10,GRLIB_perm_log],
	["O_Truck_02_covered_F",5,10,5,GRLIB_perm_inf],
	["O_Truck_03_covered_F",5,50,5,GRLIB_perm_log]
];

heavy_vehicles = [
	["CUP_O_BMP2_RU",10,400,10,GRLIB_perm_log],
	["CUP_O_BMP_HQ_RU",10,400,10,GRLIB_perm_log],
	["CUP_O_BMP3_RU",10,800,10,GRLIB_perm_log],
	["CUP_O_BRDM2_RUS",10,1000,10,GRLIB_perm_tank],
	["CUP_O_MTLB_pk_WDL_RU",10,1250,10,GRLIB_perm_tank],
	["CUP_O_BRDM2_ATGM_RUS",10,1250,10,GRLIB_perm_tank],
	["CUP_O_BTR80A_CAMO_RU",15,1500,15,GRLIB_perm_tank],
	["CUP_O_BTR90_RU",15,2500,15,GRLIB_perm_tank],
	["CUP_O_BTR90_HQ_RU",15,2500,15,GRLIB_perm_air],
	["CUP_O_Ural_ZU23_RU",15,2500,15,GRLIB_perm_tank],
	["CUP_O_T72_RU",15,2500,15,GRLIB_perm_air],
	["CUP_O_T90_RU",15,3500,15,GRLIB_perm_max],
	["CUP_O_2S6_RU",15,4000,15,GRLIB_perm_max]
];

air_vehicles = [
	["O_UAV_01_F",1,10,5,GRLIB_perm_log],
	["O_UAV_06_F",1,30,5,GRLIB_perm_tank],
	["O_UAV_02_dynamicLoadout_F",5,1000,5,GRLIB_perm_air],
	//["O_T_UAV_04_CAS_F",5,1500,10,GRLIB_perm_max],
	["C_Plane_Civil_01_F",1,50,5,GRLIB_perm_air],
	["CUP_O_Mi8_RU",1,350,5,GRLIB_perm_tank],
	["CUP_O_Ka50_DL_RU",1,1850,5,GRLIB_perm_tank],
	["CUP_O_Mi24_V_Dynamic_RU",20,3000,40,GRLIB_perm_air],
	["CUP_O_MI6T_RU",3,1500,10,GRLIB_perm_air],
	["CUP_O_Ka52_RU", 10,2500,20,GRLIB_perm_air],
	["CUP_O_Ka60_Grey_RU",20,600,40,GRLIB_perm_max],
	["CUP_O_SU34_RU",20,4200,40,GRLIB_perm_max],
	["CUP_O_Su25_Dyn_RU",20,3800,40,GRLIB_perm_max],
	["CUP_O_Mi8AMT_RU",3,1300,10,GRLIB_perm_air]
];

blufor_air = [
	"CUP_O_Ka60_Grey_RU",
	"CUP_O_Mi8AMT_RU",
	"CUP_O_MI6T_RU",
	"CUP_O_Su25_Dyn_RU",
	"CUP_O_SU34_RU"
];

static_vehicles = [
	["CUP_O_KORD_high_RU",0,10,0,GRLIB_perm_log],
	["CUP_O_Igla_AA_pod_RU",0,150,0,GRLIB_perm_tank],
	["CUP_O_Metis_RU_M_MSV",0,150,0,GRLIB_perm_air],
	["CUP_O_Kornet_RU",0,150,0,GRLIB_perm_tank],
	["CUP_O_ZU23_RU_M_MSV",0,450,0,GRLIB_perm_max],
	["O_Mortar_01_F",0,500,0,GRLIB_perm_max],
	["CUP_O_D30_AT_RU",0,500,0,GRLIB_perm_tank],
	["O_SAM_System_04_F",10,1500,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
	"O_SAM_System_04_F"
];

support_vehicles_west = [
	["O_G_Offroad_01_repair_F",5,15,5,GRLIB_perm_inf],
	["O_G_Van_01_fuel_F",5,15,20,GRLIB_perm_inf],
	["Land_Pod_Heli_Transport_04_bench_F",0,50,0,GRLIB_perm_log],
	["Land_Pod_Heli_Transport_04_covered_F",0,50,0,GRLIB_perm_log]
];

buildings_west = [
	["Land_Cargo_Tower_V3_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V3_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V3_F",0,0,0,GRLIB_perm_log],
	["CUP_Flag_Black",0,0,0,0]
];

blufor_squad_inf_light = [
	"CUP_O_INS_Medic",
	"CUP_O_INS_Soldier",
	"CUP_O_INS_Soldier_AK74",
	"CUP_O_INS_Sniper",
	"CUP_O_INS_Commander",
	"CUP_O_INS_Soldier_AT",
	"CUP_O_INS_Soldier_Ammo",
	"CUP_O_INS_Soldier_Exp",
	"CUP_O_INS_Saboteur",
	"CUP_O_INS_Soldier_LAT",
	"CUP_O_INS_Soldier_MG",
	"CUP_O_INS_Soldier_Engineer",
	"CUP_O_INS_Soldier_GL",
	"CUP_O_INS_Soldier",
	"CUP_O_INS_Soldier_AK74"
];
blufor_squad_inf = [
	"CUP_O_RU_Soldier_M_EMR_V2",
	"CUP_O_RU_Soldier_Medic_M_EMR_V2",
	"CUP_O_RU_Soldier_Engineer_M_EMR_V2",
	"CUP_O_RU_Soldier_GL_M_EMR_V2",
	"CUP_O_RU_Soldier_Marksman_M_EMR_V2",
	"CUP_O_RU_Soldier_LAT_M_EMR_V2",
	"CUP_O_RU_Sniper_M_EMR",
	"CUP_O_RU_Soldier_MG_M_EMR_V2",
	"CUP_O_RU_Soldier_AR_M_EMR_V2",
	"CUP_O_RU_Soldier_AA_M_EMR_V2",
	"CUP_O_RU_Soldier_HAT_M_EMR_V2",
	"CUP_O_RU_Sniper_KSVK_M_EMR",
	"CUP_O_RU_Soldier_Saiga_M_EMR_V2",
	"CUP_O_RU_Soldier_M_EMR_V2"
];
blufor_squad_at = [
	"CUP_O_RU_Soldier_SL_EMR",
	"CUP_O_RU_Medic_EMR",
	"CUP_O_RU_Soldier_AT_EMR",
	"CUP_O_RU_Soldier_HAT_EMR",
	"CUP_O_RU_Soldier_HAT_EMR",
	"CUP_O_RU_Soldier_EMR"
];
blufor_squad_aa = [
	"CUP_O_RU_Soldier_SL_EMR",
	"CUP_O_RU_Medic_EMR",
	"CUP_O_RU_Soldier_AT_EMR",
	"CUP_O_RU_Soldier_AA_EMR",
	"CUP_O_RU_Soldier_AA_EMR",
	"CUP_O_RU_Soldier_EMR"
];
blufor_squad_mix = [
	"CUP_O_RU_Soldier_SL_EMR",
	"CUP_O_RU_Medic_EMR",
	"CUP_O_RU_Soldier_AT_EMR",
	"CUP_O_RU_Soldier_HAT_EMR",
	"CUP_O_RU_Soldier_AA_EMR",
	"CUP_O_RU_Soldier_EMR"
];

squads = [
	[blufor_squad_inf_light,10,300,0,GRLIB_perm_max],
	[blufor_squad_inf,20,400,0,GRLIB_perm_max],
	[blufor_squad_at,25,600,0,GRLIB_perm_max],
	[blufor_squad_aa,25,600,0,GRLIB_perm_max],
	[blufor_squad_mix,25,600,0,GRLIB_perm_max]
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

];

GRLIB_AirDrop_1 = [        // cost = 50 Unarmed Offroad
    "CUP_O_UAZ_Unarmed_RU"
];
GRLIB_AirDrop_2 = [        // cost 100 Armed Offroader
    "CUP_O_GAZ_Vodnik_PK_RU"
];
GRLIB_AirDrop_3 = [        // cost 200 MRAPs (Mine Resistant Ambush Protected Vehicle)
    "CUP_O_BRDM2_RUS"
];
GRLIB_AirDrop_4 = [        // cost 300 Large Truck
    "CUP_O_Kamaz_RU"
];
GRLIB_AirDrop_5 = [        // cost 750 APC (Armoured personnel carrier)
    "CUP_O_BTR60_Green_RU"
];
GRLIB_AirDrop_6 = [        // cost 250 Boat
    "CUP_O_PBX_RU"
];
