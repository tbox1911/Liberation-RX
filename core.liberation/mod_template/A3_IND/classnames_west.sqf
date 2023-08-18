// *** FRIENDLIES ***
GRLIB_side_friendly = INDEPENDENT;
GRLIB_west_modder = "pSiKO";

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

huron_typename = "I_Heli_Transport_02_F";  // // to use value from lobby/server.cfg
FOB_typename = "Land_Cargo_HQ_V2_F";
FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "B_Truck_01_box_F";
Respawn_truck_typename = "I_Truck_02_medical_F";
ammo_truck_typename = "I_Truck_02_ammo_F";
fuel_truck_typename = "I_Truck_02_fuel_F";
repair_truck_typename = "I_Truck_02_Repair_F";
repair_sling_typename = "B_Slingload_01_Repair_F";
fuel_sling_typename = "B_Slingload_01_Fuel_F";
ammo_sling_typename = "B_Slingload_01_Ammo_F";
medic_sling_typename = "B_Slingload_01_Medevac_F";
pilot_classname = "I_Helipilot_F";
crewman_classname = "I_crew_F";

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["I_soldier_F",1,0,0,0],
	["I_medic_F",1,0,0,0],
	["I_engineer_F",1,0,0,0],
	["I_soldier_GL_F",1,0,0,GRLIB_perm_inf],
	["I_soldier_M_F",1,0,0,GRLIB_perm_inf],
	["I_soldier_LAT_F",1,0,0,0],
	["I_Soldier_AR_F",1,0,0,GRLIB_perm_inf],
	["I_diver_F",1,0,0,GRLIB_perm_inf],
	["I_Soldier_exp_F",1,0,0,GRLIB_perm_log],
	["I_soldier_AA_F",1,0,0,GRLIB_perm_log],
	["I_soldier_AT_F",1,0,0,GRLIB_perm_log],
	["I_sniper_F",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [];

light_vehicles = [
	["I_Quadbike_01_F",1,5,1,0],
	["I_Boat_Transport_01_F",1,25,1,GRLIB_perm_inf],
	["C_Boat_Transport_02_F",2,25,2,GRLIB_perm_log],
	["I_Boat_Armed_01_minigun_F",5,30,5,GRLIB_perm_log],
	["I_SDV_01_F",5,30,5,GRLIB_perm_log],
	["C_Scooter_Transport_01_F",1,5,1,0],
	["C_SUV_01_F",1,10,3,0],
	["I_G_Offroad_01_F",1,10,5,0],
	["I_G_Offroad_01_armed_F",1,50,5,GRLIB_perm_inf],
	["C_Van_01_transport_F",1,15,7,0],
	["I_MRAP_03_F",2,25,12,0],
	["I_MRAP_03_hmg_F",5,100,12,GRLIB_perm_inf],
	["I_MRAP_03_gmg_F",5,125,12,GRLIB_perm_log],
	["I_Truck_02_transport_F",5,30,15,GRLIB_perm_log],
	["I_Truck_02_covered_F",5,30,15,GRLIB_perm_log],
	["I_LT_01_cannon_F",2,200,12,GRLIB_perm_log],
	["I_LT_01_AT_F",2,200,12,GRLIB_perm_tank],
	["I_LT_01_AA_F",2,200,12,GRLIB_perm_air],
	["I_LSV_01_unarmed_F",2,25,10,GRLIB_perm_inf],
	["I_LSV_01_armed_F",5,100,10,GRLIB_perm_log],
	["I_UGV_01_F",5,10,5,GRLIB_perm_inf],
	["I_UGV_01_rcws_F",5,250,5,GRLIB_perm_log]
];

heavy_vehicles = [
	["I_E_APC_tracked_03_cannon_F",10,500,20,GRLIB_perm_log],
	["I_APC_Wheeled_03_cannon_F",10,500,20,GRLIB_perm_tank],
	["I_APC_tracked_03_cannon_F",10,500,20,GRLIB_perm_tank],
	["I_MBT_01_cannon_F",15,1000,25,GRLIB_perm_tank],
	["I_MBT_03_cannon_F",15,3500,25,GRLIB_perm_max],
	["I_Truck_02_MRL_F",15,4000,25,GRLIB_perm_max]
];

air_vehicles = [
	["I_UAV_01_F",1,10,5,GRLIB_perm_log],
	["I_UAV_06_F",1,30,5,GRLIB_perm_tank],
	["I_UAV_02_dynamicLoadout_F",5,1000,5,GRLIB_perm_air],
	["I_T_UAV_03_dynamicLoadout_F",5,1500,10,GRLIB_perm_max],
	["I_UAV_05_F",5,2000,15,GRLIB_perm_max],
	["C_Plane_Civil_01_F",1,50,5,GRLIB_perm_air],
	["I_Heli_light_03_unarmed_F",1,50,15,GRLIB_perm_tank],
	["I_Heli_light_03_dynamicLoadout_F",1,150,15,GRLIB_perm_air],
	["I_E_Heli_light_03_dynamicLoadout_F",1,150,15,GRLIB_perm_tank],	
	["I_Plane_Fighter_03_dynamicLoadout_F", 10,3500,50,GRLIB_perm_max],
	["I_Plane_Fighter_03_Cluster_F",20,3000,50,GRLIB_perm_max],
	["I_Plane_Fighter_04_F",20,4500,50,GRLIB_perm_max],
	["I_Plane_Fighter_04_Cluster_F",20,4500,50,GRLIB_perm_max]
];

blufor_air = [
	"I_Heli_light_03_dynamicLoadout_F",
	"I_E_Heli_light_03_dynamicLoadout_F",
	"I_Plane_Fighter_03_AA_F",
	"I_Plane_Fighter_03_dynamicLoadout_F",
	"I_Plane_Fighter_03_Cluster_F",
	"I_Plane_Fighter_04_F",
	"I_Plane_Fighter_04_Cluster_F"
];

static_vehicles = [
	["I_UGV_02_Demining_F",0,5,0,GRLIB_perm_inf],
	["I_Static_Designator_01_F",0,5,0,GRLIB_perm_inf],
	["I_HMG_01_F",0,10,0,GRLIB_perm_log],
	["I_HMG_01_high_F",0,10,0,GRLIB_perm_tank],
	["I_GMG_01_F",0,20,0,GRLIB_perm_log],
	["I_GMG_01_high_F",0,20,0,GRLIB_perm_tank],
	["I_static_AA_F",0,50,0,GRLIB_perm_air],
	["I_static_AT_F",0,50,0,GRLIB_perm_air],
	["I_Mortar_01_F",0,500,0,GRLIB_perm_max],
	["B_AAA_System_01_F",10,500,0,GRLIB_perm_max],
	["I_E_SAM_System_03_F",10,800,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
	"B_AAA_System_01_F",
	"I_E_SAM_System_03_F"
];

support_vehicles_west = [
	["I_G_Offroad_01_repair_F",5,15,5,GRLIB_perm_inf],
	["I_G_Van_01_fuel_F",5,15,20,GRLIB_perm_inf]
];

buildings_west = [
	["Land_Cargo_Tower_V2_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V2_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V2_F",0,0,0,GRLIB_perm_log],
	["Flag_FIA_F",0,0,0,0]
];

blufor_squad_inf_light = [
	"I_Soldier_SL_F",
	"I_medic_F",
	"I_Soldier_GL_F",
	"I_soldier_AR_F",
	"I_Soldier_lite_F",
	"I_Soldier_lite_F"
];
blufor_squad_inf = [
	"I_Soldier_SL_F",
	"I_medic_F",
	"I_soldier_M_F",
	"I_Soldier_AR_F",
	"I_Soldier_F",
	"I_Soldier_F"
];
blufor_squad_at = [
	"I_Soldier_SL_F",
	"I_medic_F",
	"I_soldier_AT_F",
	"I_soldier_AT_F",
	"I_soldier_F",
	"I_soldier_F"
];
blufor_squad_aa = [
	"I_Soldier_SL_F",
	"I_medic_F",
	"I_soldier_AA_F",
	"I_soldier_AA_F",
	"I_soldier_F",
	"I_soldier_F"
];
blufor_squad_mix = [
	"I_Soldier_SL_F",
	"I_medic_F",
	"I_soldier_AA_F",
	"I_soldier_AT_F",
	"I_soldier_F",
	"I_soldier_F"
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
	"I_UAV_01_F",
	"I_UAV_02_dynamicLoadout_F",
	"I_T_UAV_03_dynamicLoadout_F",
	"I_UAV_05_F",
	"I_UAV_06_F",
	"C_UAV_06_F",
	"I_UGV_01_F",
	"I_UGV_01_rcws_F",
	"I_UGV_02_Demining_F"
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [
  "I_Truck_02_ammo_F"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"I_Truck_02_medical_F"
];

vehicle_rearm_sources_west = [
	"I_Truck_02_ammo_F"
];

vehicle_big_units_west = [

];

GRLIB_vehicle_whitelist_west = [

];

GRLIB_vehicle_blacklist_west = [

];
