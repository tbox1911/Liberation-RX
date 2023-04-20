// *** FRIENDLIES ***
GRLIB_side_friendly = EAST;
GRLIB_west_modder = "pSiKO";

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

huron_typename = "O_Heli_Transport_04_black_F";
FOB_typename = "Land_Cargo_HQ_V3_F";
FOB_box_typename = "Land_Pod_Heli_Transport_04_box_black_F";
FOB_truck_typename = "O_T_Truck_03_device_ghex_F";
Respawn_truck_typename = "O_Truck_03_medical_F";
ammo_truck_typename = "O_Truck_03_ammo_F";
fuel_truck_typename = "O_Truck_03_fuel_F";
repair_truck_typename = "O_Truck_03_Repair_F";
repair_sling_typename = "Land_Pod_Heli_Transport_04_repair_F";
fuel_sling_typename = "Land_Pod_Heli_Transport_04_fuel_F";
ammo_sling_typename = "Land_Pod_Heli_Transport_04_ammo_F";
medic_sling_typename = "Land_Pod_Heli_Transport_04_medevac_F";
pilot_classname = "O_Helipilot_F";
crewman_classname = "O_crew_F";
chimera_vehicle_overide = [
  ["B_Heli_Transport_01_F", "O_Heli_Light_02_dynamicLoadout_F"]
];

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["O_soldier_F",1,0,0,0],
	["O_medic_F",1,0,0,0],
	["O_engineer_F",1,0,0,0],
	["O_soldier_GL_F",1,0,0,GRLIB_perm_inf],
	["O_soldier_M_F",1,0,0,GRLIB_perm_inf],
	["O_soldier_LAT_F",1,0,0,0],
	["O_Sharpshooter_F",1,0,0,GRLIB_perm_inf],
	["O_HeavyGunner_F",1,0,0,GRLIB_perm_inf],
	["O_recon_F",1,0,0,GRLIB_perm_log],
	["O_diver_F",1,0,0,GRLIB_perm_log],
	["O_recon_LAT_F",1,0,0,GRLIB_perm_log],
	["O_soldier_AA_F",1,0,0,GRLIB_perm_log],
	["O_soldier_AT_F",1,0,0,GRLIB_perm_log],
	["O_sniper_F",1,0,0,GRLIB_perm_log],
	["O_soldier_PG_F",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];
units_loadout_overide = [
	"O_medic_F"
];

light_vehicles = [
	["O_Quadbike_01_F",1,5,1,0],
	["O_Boat_Transport_01_F",1,25,1,GRLIB_perm_inf],
	["C_Boat_Transport_02_F",2,25,2,GRLIB_perm_log],
	["O_Boat_Armed_01_hmg_F",5,30,5,GRLIB_perm_log],
	["O_SDV_01_F",5,30,5,GRLIB_perm_log],
	["C_Scooter_Transport_01_F",1,5,1,0],
	["SUV_01_base_black_F",1,10,1,0],
	["O_G_Offroad_01_F",1,10,1,0],
	["O_G_Offroad_01_armed_F",1,50,1,GRLIB_perm_inf],
	["C_SUV_01_F",1,10,1,GRLIB_perm_inf],
	["C_Van_01_transport_F",1,15,1,0],
	["O_MRAP_02_F",2,25,2,0],
	["O_MRAP_02_hmg_F",5,100,2,GRLIB_perm_inf],
	["O_MRAP_02_gmg_F",5,125,2,GRLIB_perm_log],
	["O_Truck_02_transport_F",5,10,5,GRLIB_perm_inf],
	["O_Truck_03_transport_F",5,50,5,GRLIB_perm_log],
	["O_Truck_02_covered_F",5,10,5,GRLIB_perm_inf],
	["O_Truck_03_covered_F",5,50,5,GRLIB_perm_log],
	["I_LT_01_cannon_F",2,200,2,GRLIB_perm_log],
	["O_LSV_02_unarmed_F",2,25,2,GRLIB_perm_inf],
	["O_LSV_02_armed_F",5,100,2,GRLIB_perm_log],
	["O_UGV_01_F",5,10,5,GRLIB_perm_inf],
	["O_UGV_01_rcws_F",5,250,5,GRLIB_perm_log]
];

heavy_vehicles = [
	["O_APC_Wheeled_02_rcws_v2_F",10,400,10,GRLIB_perm_log],
	["O_APC_Tracked_02_cannon_F",10,800,10,GRLIB_perm_log],
	["O_APC_Tracked_02_AA_F",10,1500,10,GRLIB_perm_tank],
	["O_MBT_02_cannon_F",15,1500,15,GRLIB_perm_tank],
	["O_MBT_04_cannon_F",15,2500,15,GRLIB_perm_air],
	["O_MBT_04_command_F",15,2500,15,GRLIB_perm_air],
	["I_MBT_03_cannon_F",15,4500,15,GRLIB_perm_max],
	["O_MBT_02_arty_F",15,3500,15,GRLIB_perm_max],
	["I_E_Truck_02_MRL_F",15,3500,15,GRLIB_perm_max]
];

air_vehicles = [
	["O_UAV_01_F",1,10,5,GRLIB_perm_log],
	["O_UAV_06_F",1,30,5,GRLIB_perm_tank],
	["O_UAV_02_dynamicLoadout_F",5,1000,5,GRLIB_perm_air],
	["O_T_UAV_04_CAS_F",5,1500,10,GRLIB_perm_max],
	["C_Plane_Civil_01_F",1,50,5,GRLIB_perm_air],
	["O_Heli_Light_02_unarmed_F",1,250,5,GRLIB_perm_tank],
	["O_Heli_Transport_04_F",3,500,10,GRLIB_perm_air],
	["O_Heli_Light_02_dynamicLoadout_F",5,1000,10,GRLIB_perm_air],
	["O_Heli_Attack_02_dynamicLoadout_F",10,2000,20,GRLIB_perm_air],
	["O_T_VTOL_02_infantry_dynamicLoadout_F", 10,2500,20,GRLIB_perm_max],
	["O_Plane_CAS_02_dynamicLoadout_F",20,4000,40,GRLIB_perm_max],
	["O_Plane_Fighter_02_F",20,4500,40,GRLIB_perm_max],
	["O_Plane_Fighter_02_Stealth_F",20,4500,40,GRLIB_perm_max]
];

blufor_air = [
	"O_Heli_Light_02_dynamicLoadout_F",
	"O_Heli_Attack_02_dynamicLoadout_F",
	"O_T_VTOL_02_infantry_dynamicLoadout_F",
	"O_Plane_CAS_02_dynamicLoadout_F",
	"O_Plane_Fighter_02_F",
	"O_Plane_Fighter_02_Stealth_F"
];

static_vehicles = [
	["O_UGV_02_Demining_F",0,5,0,GRLIB_perm_inf],
	["O_Static_Designator_01_F",0,5,0,GRLIB_perm_inf],
	["O_HMG_01_F",0,10,0,GRLIB_perm_log],
	["O_HMG_01_high_F",0,10,0,GRLIB_perm_tank],
	["O_GMG_01_F",0,20,0,GRLIB_perm_log],
	["O_GMG_01_high_F",0,20,0,GRLIB_perm_tank],
	["O_static_AA_F",0,50,0,GRLIB_perm_air],
	["O_static_AT_F",0,50,0,GRLIB_perm_air],
	["O_Mortar_01_F",0,500,0,GRLIB_perm_max],
	["B_SAM_System_01_F",10,1500,0,GRLIB_perm_tank],
	["B_AAA_System_01_F",10,1500,0,GRLIB_perm_air],
	["O_SAM_System_04_F",10,1500,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
	"B_SAM_System_01_F",
	"B_AAA_System_01_F",
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
	["Flag_CSAT_F",0,0,0,0]
];

blufor_squad_inf_light = [
	"O_Soldier_SL_F",
	"O_medic_F",
	"O_Soldier_GL_F",
	"O_soldier_AR_F",
	"O_soldier_LAT_F",
	"O_Soldier_lite_F",
	"O_Soldier_lite_F",
	"O_Soldier_lite_F"
];
blufor_squad_inf = [
	"O_Soldier_SL_F",
	"O_medic_F",
	"O_soldier_M_F",
	"O_Soldier_AR_F",
	"O_soldier_LAT_F",
	"O_HeavyGunner_F",
	"O_Sharpshooter_F",
	"O_Soldier_F",
	"O_Soldier_F",
	"O_Soldier_F"
];
blufor_squad_at = [
	"O_Soldier_SL_F",
	"O_medic_F",
	"O_soldier_AT_F",
	"O_soldier_AT_F",
	"O_soldier_F",
	"O_soldier_F"
];
blufor_squad_aa = [
	"O_Soldier_SL_F",
	"O_medic_F",
	"O_soldier_AA_F",
	"O_soldier_AA_F",
	"O_soldier_F",
	"O_soldier_F"
];
blufor_squad_mix = [
	"O_Soldier_SL_F",
	"O_medic_F",
	"O_soldier_AA_F",
	"O_soldier_AT_F",
	"O_soldier_F",
	"O_soldier_F"
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
