// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;
GRLIB_west_modder = "pSiKO";

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

//huron_typename = "B_Heli_Transport_03_unarmed_F";  // // to use value from lobby/server.cfg
FOB_typename = "Land_Cargo_HQ_V1_F";
FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "B_Truck_01_box_F" ;
Respawn_truck_typename = "B_Truck_01_medical_F";
ammo_truck_typename = "B_Truck_01_ammo_F";
fuel_truck_typename = "B_Truck_01_fuel_F";
repair_truck_typename = "B_Truck_01_Repair_F";
repair_sling_typename = "B_Slingload_01_Repair_F";
fuel_sling_typename = "B_Slingload_01_Fuel_F";
ammo_sling_typename = "B_Slingload_01_Ammo_F";
medic_sling_typename = "B_Slingload_01_Medevac_F";
pilot_classname = "B_Helipilot_F";
crewman_classname = "B_crew_F";

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["B_Soldier_F",1,0,0,0],
	["B_medic_F",1,0,0,0],
	["B_engineer_F",1,0,0,0],
	["B_Soldier_GL_F",1,0,0,GRLIB_perm_inf],
	["B_soldier_M_F",1,0,0,GRLIB_perm_inf],
	["B_soldier_LAT_F",1,0,0,0],
	["B_Sharpshooter_F",1,0,0,GRLIB_perm_inf],
	["B_HeavyGunner_F",1,0,0,GRLIB_perm_inf],
	["B_recon_F",1,0,0,GRLIB_perm_log],
	["B_diver_F",1,0,0,GRLIB_perm_log],
	// ["B_Recon_Sharpshooter_F",1,0,0,GRLIB_perm_log],
	// ["B_soldier_AA_F",1,0,0,GRLIB_perm_log],
	// ["B_soldier_AT_F",1,0,0,GRLIB_perm_log],
	// ["B_sniper_F",1,0,0,GRLIB_perm_log],
	// ["B_soldier_PG_F",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [
	"B_medic_F"
];

light_vehicles = [
	["B_Quadbike_01_F",1,5,1,0],
	["B_Boat_Transport_01_F",1,25,1,0],
	["C_Boat_Transport_02_F",2,25,2,GRLIB_perm_log],
	["B_Boat_Armed_01_minigun_F",5,30,5,GRLIB_perm_log],
	["B_SDV_01_F",5,30,5,GRLIB_perm_log],
	["C_Scooter_Transport_01_F",1,5,1,0],
	["SUV_01_base_black_F",1,10,1,0],
	["B_G_Offroad_01_F",1,10,5,0],
	["B_G_Offroad_01_armed_F",1,50,5,GRLIB_perm_inf],
	["C_SUV_01_F",1,10,3,GRLIB_perm_inf],
	["C_Van_01_transport_F",1,15,7,0],
	["B_MRAP_01_F",2,25,12,0],
	["B_LSV_01_unarmed_F",2,25,10,GRLIB_perm_inf],
	//["I_MRAP_03_F",2,25,2,0],
	//["I_MRAP_03_hmg_F",5,100,2,GRLIB_perm_inf],
	//["I_MRAP_03_gmg_F",5,125,2,GRLIB_perm_log],
	//["I_LT_01_cannon_F",2,200,2,GRLIB_perm_log],
	["B_Truck_01_transport_F",5,30,15,GRLIB_perm_log],
	["B_Truck_01_covered_F",5,30,15,GRLIB_perm_tank],
	["I_Truck_02_transport_F",5,30,15,GRLIB_perm_log],
	["I_Truck_02_covered_F",5,30,15,GRLIB_perm_tank]
	// ["B_UGV_01_F",5,10,5,GRLIB_perm_inf],
	// ["B_UGV_01_rcws_F",5,250,5,GRLIB_perm_tank]
];

heavy_vehicles = [
	["B_LSV_01_armed_F",5,100,10,GRLIB_perm_log],
	["B_MRAP_01_hmg_F",5,100,12,GRLIB_perm_inf],
	["B_MRAP_01_gmg_F",5,125,12,GRLIB_perm_log],
	["B_APC_Tracked_01_rcws_F",10,500,20,GRLIB_perm_tank]
	// ["B_APC_Wheeled_01_cannon_F",10,500,20,GRLIB_perm_log],
	// ["B_APC_Tracked_01_AA_F",10,500,20,GRLIB_perm_tank],
	// ["I_APC_Wheeled_03_cannon_F",10,500,20,GRLIB_perm_tank],
	// ["B_MBT_01_cannon_F",15,1000,35,GRLIB_perm_tank],
	// ["B_MBT_01_TUSK_F",15,1500,35,GRLIB_perm_air],
	// ["B_AFV_Wheeled_01_cannon_F",15,3000,35,GRLIB_perm_max],
	// ["B_AFV_Wheeled_01_up_cannon_F",15,3500,35,GRLIB_perm_max],
	// ["B_MBT_01_arty_F",15,3500,30,GRLIB_perm_max],
	// ["B_MBT_01_mlrs_F",20,5000,30,GRLIB_perm_max]
];

air_vehicles = [
	["B_UAV_01_F",1,10,5,GRLIB_perm_log],
	["B_UAV_06_F",1,30,5,GRLIB_perm_tank],
	// ["B_UAV_02_dynamicLoadout_F",5,1000,5,GRLIB_perm_air],
	// ["B_T_UAV_03_dynamicLoadout_F",5,1500,10,GRLIB_perm_max],
	// ["B_UAV_05_F",5,2000,15,GRLIB_perm_max],
	// ["C_Plane_Civil_01_F",1,50,5,GRLIB_perm_air],
	["B_Heli_Light_01_F",1,50,15,GRLIB_perm_log],
	// ["B_Heli_Light_01_dynamicLoadout_F",1,150,15,GRLIB_perm_tank],
	["I_Heli_light_03_unarmed_F",1,50,5,GRLIB_perm_tank]
	// ["I_Heli_light_03_dynamicLoadout_F",10,500,20,GRLIB_perm_air],
	// //["I_Plane_Fighter_03_dynamicLoadout_F", 10,3500,20,GRLIB_perm_max],
	// ["B_Heli_Transport_03_F",10,1700,35,GRLIB_perm_air],
	// ["B_Heli_Transport_01_F",10,2000,35,GRLIB_perm_tank],
	// ["B_T_VTOL_01_infantry_F",10,1300,40,GRLIB_perm_air],
	// ["B_T_VTOL_01_vehicle_F",10,1400,40,GRLIB_perm_air],
	// ["B_T_VTOL_01_armed_F",20,2500,40,GRLIB_perm_max],
	// ["B_Heli_Attack_01_dynamicLoadout_F",10,2250,30,GRLIB_perm_air],
	// ["B_Plane_CAS_01_dynamicLoadout_F",20,3000,50,GRLIB_perm_max],
	// ["B_Plane_Fighter_01_F",20,4500,50,GRLIB_perm_max],
	// ["B_Plane_Fighter_01_Stealth_F",20,2000,50,GRLIB_perm_max]
];

blufor_air = [
	"B_Heli_Attack_01_F",
	"B_Plane_CAS_01_dynamicLoadout_F",
	"B_Plane_Fighter_01_F",
	"B_Heli_Attack_01_F"
];

static_vehicles = [
	["B_HMG_01_F",0,10,0,GRLIB_perm_inf],
	["B_HMG_01_high_F",0,10,0,GRLIB_perm_log],
	["B_GMG_01_F",0,20,0,GRLIB_perm_inf],
	["B_GMG_01_high_F",0,20,0,GRLIB_perm_log],
	["B_static_AA_F",0,150,0,GRLIB_perm_tank],
	["B_static_AT_F",0,150,0,GRLIB_perm_tank],
	["B_Mortar_01_F",0,500,0,GRLIB_perm_tank]
	// ["B_SAM_System_01_F",10,1500,0,GRLIB_perm_air],
	// ["B_SAM_System_02_F",10,1500,0,GRLIB_perm_air],
	// ["B_AAA_System_01_F",10,1500,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
	// "B_SAM_System_01_F",
	// "B_SAM_System_02_F",
	// "B_AAA_System_01_F"
];

support_vehicles_west = [
	["B_G_Offroad_01_repair_F",5,150,5,GRLIB_perm_inf],
	["B_G_Van_01_fuel_F",5,130,40,GRLIB_perm_inf],
	["B_APC_Tracked_01_CRV_F",15,2000,50,GRLIB_perm_max]
];

//buildings_west_overide = true;
buildings_west = [
	["Land_Cargo_Tower_V1_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V1_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V1_F",0,0,0,GRLIB_perm_log],
	["Flag_NATO_F",0,0,0,0]
];

// Boats
boats_west = [
	"B_Boat_Transport_01_F",
	"B_Boat_Armed_01_minigun_F"
];

blufor_squad_inf_light = [
	"B_Soldier_SL_F",
	"B_medic_F",
	"B_Soldier_GL_F",
	"B_soldier_AR_F",
	"B_Soldier_lite_F",
	"B_Soldier_lite_F"
];
blufor_squad_inf = [
	"B_Soldier_SL_F",
	"B_medic_F",
	"B_soldier_M_F",
	"B_Soldier_AR_F",
	"B_HeavyGunner_F",
	"B_Soldier_F"
];
blufor_squad_at = [
	"B_Soldier_SL_F",
	"B_medic_F",
	"B_soldier_AT_F",
	"B_soldier_AT_F",
	"B_Soldier_F",
	"B_Soldier_F"
];

blufor_squad_aa = [
	"B_Soldier_SL_F",
	"B_medic_F",
	"B_soldier_AA_F",
	"B_soldier_AA_F",
	"B_Soldier_F",
	"B_Soldier_F"
];
blufor_squad_mix = [
	"B_Soldier_SL_F",
	"B_medic_F",
	"B_soldier_AA_F",
	"B_soldier_AT_F",
	"B_Soldier_F",
	"B_Soldier_F"
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
	"B_UAV_01_F",
	"B_UAV_02_dynamicLoadout_F",
	"B_T_UAV_03_dynamicLoadout_F",
	"B_UAV_05_F",
	"B_UAV_06_F",
	"C_UAV_06_F",
	"B_UGV_01_F",
	"B_UGV_01_rcws_F",
	"B_UGV_02_Demining_F"
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
