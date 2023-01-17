// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

// BWMOD Tropentarn

//huron_typename = "B_Heli_Transport_03_unarmed_F";  // comment to use value from lobby/server.cfg
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
A3W_BoxWps = "CUP_BOX_RACS_Wps_F";

chimera_vehicle_overide = [
  ["B_LSV_01_unarmed_F", "BWA3_Eagle_Fleck"],
  ["B_Quadbike_01_F", "B_MRAP_01_F"],
  ["B_Heli_Transport_01_F", "RHS_UH60M2"]
];

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["BWA3_Rifleman_Tropen",1,0,0,0],
	["BWA3_Medic_Tropen",1,0,0,0],
	["BWA3_Engineer_Tropen",1,0,0,0],
	["BWA3_Grenadier_Tropen",1,0,0,GRLIB_perm_inf],
	["BWA3_MachineGunner_MG4_Tropen",1,0,0,GRLIB_perm_inf],
	["BWA3_MachineGunner_MG5_Tropen",1,0,0,0],
	["BWA3_Marksman_Tropen",1,0,0,GRLIB_perm_inf],
	["BWA3_RiflemanAT_PzF3_Tropen",1,0,0,GRLIB_perm_log],
	["BWA3_RiflemanAA_Fliegerfaust_Tropen",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [];


light_vehicles = [
	["B_Boat_Transport_01_F",1,25,1,GRLIB_perm_inf],
	["C_Boat_Transport_02_F",2,25,2,GRLIB_perm_log],
	["B_Boat_Armed_01_minigun_F",5,30,5,GRLIB_perm_log],
	["B_SDV_01_F",5,30,5,GRLIB_perm_log],
	["SUV_01_base_black_F",1,10,1,0],
	["B_G_Offroad_01_F",1,10,5,0],
	["B_G_Offroad_01_armed_F",1,50,5,GRLIB_perm_inf],
	["B_Truck_01_transport_F",5,30,15,GRLIB_perm_log],
	["B_Truck_01_covered_F",5,30,15,GRLIB_perm_tank],
	["I_Truck_02_transport_F",5,30,15,GRLIB_perm_log],
	["I_Truck_02_covered_F",5,30,15,GRLIB_perm_tank],
	["BWA3_Eagle_Tropen",2,80,10,GRLIB_perm_inf],
	["BWA3_Eagle_FLW100_Tropen",5,100,10,GRLIB_perm_log],
	["BWA3_Dingo2_FLW100_MG3_Tropen",5,150,5,GRLIB_perm_inf],
	["BWA3_Dingo2_FLW200_M2_Tropen",5,200,5,GRLIB_perm_tank],
	["BWA3_Dingo2_FLW200_GMW_Tropen",5,250,5,GRLIB_perm_tank]
];

heavy_vehicles = [
	["BWA3_Puma_Tropen",10,600,20,GRLIB_perm_tank],
	["BWA3_Panzerhaubitze2000_Tropen",10,800,20,GRLIB_perm_max],
	["BWA3_Leopard2_Tropen",15,1000,20,GRLIB_perm_max]
];

air_vehicles = [
	["B_Heli_Light_01_F",2,30,5,GRLIB_perm_log],
	["B_Heli_Light_01_dynamicLoadout_F",2,450,5,GRLIB_perm_tank],
	["BWA3_Tiger_Gunpod_FZ",10,800,15,GRLIB_perm_air],
	["BWA3_Tiger_Gunpod_PARS",10,900,15,GRLIB_perm_max],
	["BWA3_Tiger_Gunpod_Heavy",10,1000,15,GRLIB_perm_max],
	["BWA3_Tiger_RMK_FZ",10,120,15,GRLIB_perm_air],
	["BWA3_Tiger_RMK_PARS",10,1300,15,GRLIB_perm_log],
	["BWA3_Tiger_RMK_Heavy",10,1400,15,GRLIB_perm_tank],
	["BWA3_Tiger_RMK_Universal",10,1500,15,GRLIB_perm_tank],
	["B_Plane_CAS_01_dynamicLoadout_F",20,3500,40,GRLIB_perm_max],
	["B_Plane_Fighter_01_F",20,4000,50,GRLIB_perm_max]
];

blufor_air = [
	"BWA3_Tiger_Gunpod_FZ",
	"BWA3_Tiger_Gunpod_Heavy",
	"BWA3_Tiger_RMK_FZ",
	"BWA3_Tiger_RMK_Heavy",
	"BWA3_Tiger_RMK_Universal",
	"B_Plane_CAS_01_dynamicLoadout_F",
	"B_Plane_Fighter_01_F"
];

static_vehicles = [
	["B_Static_Designator_01_F",0,5,0,GRLIB_perm_inf],
	["B_HMG_01_F",0,10,0,GRLIB_perm_log],
	["B_HMG_01_high_F",0,10,0,GRLIB_perm_tank],
	["B_GMG_01_F",0,20,0,GRLIB_perm_log],
	["B_GMG_01_high_F",0,20,0,GRLIB_perm_tank],
	["B_static_AA_F",0,50,0,GRLIB_perm_air],
	["B_static_AT_F",0,50,0,GRLIB_perm_air],
	["B_Mortar_01_F",0,500,0,GRLIB_perm_max],
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
	["CargoNet_01_box_F",0,150,0,GRLIB_perm_tank],		// empty box for transporting equipment
	["B_APC_Tracked_01_CRV_F",15,2000,50,GRLIB_perm_max]
];

//buildings_west_overide = true;
buildings_west = [
	["Land_Cargo_Tower_V1_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V1_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V1_F",0,0,0,GRLIB_perm_log],
	["BWA3_Flag_Germany",0,0,0,0]
];

blufor_squad_inf_light = [
"BWA3_TL_Tropen",
"BWA3_Rifleman_Tropen",
"BWA3_Grenadier_Tropen",
"BWA3_Medic_Tropen"

];
blufor_squad_inf = [
"BWA3_TL_Tropen",
"BWA3_Rifleman_Tropen",
"BWA3_Grenadier_Tropen",
"BWA3_Medic_Tropen",
"BWA3_RiflemanAT_CG_Tropen",
"BWA3_MachineGunner_MG4_Tropen"
];

blufor_squad_at = [
"BWA3_TL_Tropen",
"BWA3_Grenadier_G27_Tropen",
"BWA3_RiflemanAT_CG_Tropen",
"BWA3_RiflemanAT_PzF3_Tropen",
"BWA3_RiflemanAT_RGW90_Tropen",
"BWA3_Rifleman_lite_Tropen",
"BWA3_Medic_Tropen"
];

blufor_squad_aa = [
"BWA3_TL_Tropen",
"BWA3_Rifleman_Tropen",
"BWA3_Grenadier_G27_Tropen",
"BWA3_Medic_Tropen",
"BWA3_RiflemanAA_Fliegerfaust_Tropen",
"BWA3_RiflemanAA_Fliegerfaust_Tropen"
];

blufor_squad_mix = [
"BWA3_TL_Tropen",
"BWA3_Rifleman_Tropen",
"BWA3_RiflemanAA_Fliegerfaust_Tropen",
"BWA3_RiflemanAT_PzF3_Tropen",
"BWA3_MachineGunner_MG5_Tropen",
"BWA3_Medic_Tropen"
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
