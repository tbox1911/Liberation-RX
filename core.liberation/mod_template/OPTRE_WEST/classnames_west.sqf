// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

huron_typename = "OPTRE_Pelican_unarmed";
FOB_typename = "Land_ArmoryA_Green";
//FOB_box_typename = "B_Slingload_01_Cargo_F";
FOB_truck_typename = "OPTRE_m1087_stallion_device_unsc";
FOB_outpost = "Land_OPTRE_mod_building_green";
//FOB_box_outpost = "Land_Cargo10_grey_F"
Arsenal_typename = "OPTRE_Ammo_Rack_Weapons";
Respawn_truck_typename = "OPTRE_M313_UNSC";
pilot_classname = "OPTRE_UNSC_Army_Soldier_Crewman_OLI";
crewman_classname = "OPTRE_UNSC_Airforce_Soldier_Airman";
PAR_Medikit = "OPTRE_MedKit";
PAR_AidKit = "OPTRE_Biofoam";
A3W_BoxWps = "OPTRE_Ammo_Rack_Ammo";
Respawn_truck_typename = "OPTRE_m1087_stallion_unsc_medical";
ammo_truck_typename = "OPTRE_m1087_stallion_unsc_resupply";
fuel_truck_typename = "OPTRE_m1087_stallion_unsc_refuel";
repair_truck_typename = "OPTRE_m1087_stallion_unsc_repair";
GRLIB_sar_wreck = "OPTRE_Objects_Wreck_Pelican";
//repair_offroad = "OPTRE_forklift";
//Radio_tower = "Land_Razor_Tower";

chimera_vehicle_overide = [
  ["B_Heli_Light_01_F",  "OPTRE_UNSC_hornet"],
  ["B_Heli_Transport_01_F", "OPTRE_UNSC_falcon_unarmed"]
];

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["OPTRE_UNSC_Army_Soldier_Engineer_OLI",1,0,0,0],
	["OPTRE_UNSC_Army_Soldier_Medic_OLI",1,0,0,0],
	["OPTRE_UNSC_ODST_Soldier_Rifleman_BR",1,0,0,GRLIB_perm_inf],
	["OPTRE_UNSC_ODST_Soldier_Rifleman_AR",1,0,0,0],
	["OPTRE_UNSC_ODST_Soldier_Rifleman_AT",1,0,0,0],
	["OPTRE_UNSC_ODST_Soldier_DemolitionsExpert",1,0,0,GRLIB_perm_inf],
	["OPTRE_UNSC_ODST_Soldier_Scout",1,0,0,GRLIB_perm_inf],
	["OPTRE_UNSC_ODST_Soldier_Automatic_Rifleman",1,0,0,GRLIB_perm_inf],
	["OPTRE_UNSC_ODST_Soldier_Scout_AT",1,0,0,GRLIB_perm_log],
	["OPTRE_UNSC_ODST_Soldier_Bullfrog",1,0,0,GRLIB_perm_log],
	["OPTRE_UNSC_ODST_Soldier_Scout_Sniper",1,0,0,GRLIB_perm_log],
	["OPTRE_UNSC_Army_Soldier_AA_Specialist_OLI",1,0,0,GRLIB_perm_inf],
	["OPTRE_UNSC_Army_Soldier_AT_Specialist_OLI",1,0,0,GRLIB_perm_inf],
	["OPTRE_Spartan2_Soldier_Rifleman_BR",2,0,0,GRLIB_perm_tank],
	["OPTRE_Spartan2_Soldier_Engineer",2,0,0,GRLIB_perm_tank],
	["OPTRE_Spartan2_Soldier_Automatic_Rifleman",2,0,0,GRLIB_perm_tank],
	["OPTRE_Spartan2_Soldier_Rifleman_AT",2,0,0,GRLIB_perm_tank],
	["OPTRE_Spartan2_Soldier_Scout_Sniper",2,0,0,GRLIB_perm_tank],
	["OPTRE_Spartan2_Soldier_Marksman",2,0,0,GRLIB_perm_tank]	
];

units_loadout_overide = [];

light_vehicles = [
	["OPTRE_M274_ATV",1,5,1,0],
	["B_Boat_Transport_01_F",1,25,1,GRLIB_perm_inf],
	["C_Boat_Transport_02_F",2,25,2,GRLIB_perm_log],
	["optre_catfish_mg_f",5,130,5,GRLIB_perm_log],
	["OPTRE_M12_FAV",2,25,2,0],
	["OPTRE_M813_TT",1,30,1,0],
	["OPTRE_M914_RV",5,100,2,GRLIB_perm_inf],
	["OPTRE_M12_LRV",5,100,2,GRLIB_perm_inf],
	["OPTRE_M12G1_LRV",5,125,2,GRLIB_perm_log],
	["OPTRE_M12R_AA",5,125,2,GRLIB_perm_log],
	["OPTRE_m1087_stallion_unsc",5,30,5,GRLIB_perm_log],
	["OPTRE_m1087_stallion_cover_unsc",5,30,5,GRLIB_perm_log],
	["I_LT_01_cannon_F",2,200,2,GRLIB_perm_log],
	["B_LSV_01_unarmed_F",2,25,2,GRLIB_perm_inf],
	["B_LSV_01_armed_F",5,100,2,GRLIB_perm_log],
	["B_UGV_01_F",5,10,5,GRLIB_perm_inf],
	["B_UGV_01_rcws_F",5,250,5,GRLIB_perm_log]
];

heavy_vehicles = [
	["OPTRE_M412_IFV_UNSC",10,500,10,GRLIB_perm_log],
	["OPTRE_M413_MGS_UNSC",10,500,10,GRLIB_perm_log],
	["OPTRE_M808B_UNSC",10,1500,10,GRLIB_perm_tank],
	["OPTRE_M850_UNSC",10,1500,10,GRLIB_perm_tank],
	["OPTRE_M313_UNSC",10,3000,10,GRLIB_perm_max]
];

air_vehicles = [
	["B_UAV_01_F",1,10,5,GRLIB_perm_log],
	["OPTRE_Wombat_S",5,1500,10,GRLIB_perm_max],
	["OPTRE_UNSC_hornet",1,150,5,GRLIB_perm_tank],
	["OPTRE_UNSC_hornet_CAP",1,500,5,GRLIB_perm_air],
	["OPTRE_UNSC_hornet_CAS",1,500,5,GRLIB_perm_air],
	["OPTRE_UNSC_falcon_unarmed",10,1200,15,GRLIB_perm_air],
	["OPTRE_UNSC_falcon",10,2500,15,GRLIB_perm_air],
	["OPTRE_AV22_Sparrowhawk",10,1000,15,GRLIB_perm_air],
	["OPTRE_AV22A_Sparrowhawk",10,1500,15,GRLIB_perm_air],
	["OPTRE_AV22B_Sparrowhawk",10,1500,15,GRLIB_perm_air],
	["OPTRE_AV22C_Sparrowhawk",10,1500,20,GRLIB_perm_air],
	["OPTRE_Pelican_armed",10,2000,20,GRLIB_perm_max]
];

blufor_air = [
	"OPTRE_UNSC_hornet_CAP",
	"OPTRE_UNSC_hornet_CAS",
	"OPTRE_UNSC_falcon",
	"OPTRE_AV22_Sparrowhawk",
	"OPTRE_AV22A_Sparrowhawk",
	"OPTRE_AV22B_Sparrowhawk",
	"OPTRE_AV22C_Sparrowhawk"
];

static_vehicles = [
	["OPTRE_Static_M41",0,10,0,GRLIB_perm_log],
	["OPTRE_Static_AA",0,50,0,GRLIB_perm_air],
	["OPTRE_Static_ATGM",0,50,0,GRLIB_perm_air],
	["OPTRE_Static_Gauss",0,500,0,GRLIB_perm_max],
	["OPTRE_Scythe",10,500,0,GRLIB_perm_max],
	["OPTRE_Lance",10,1500,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
	"OPTRE_Lance",
	"OPTRE_Scythe"
];

support_vehicles_west = [
	["OPTRE_cart",5,15,5,GRLIB_perm_inf],
	["OPTRE_forklift",5,15,5,GRLIB_perm_inf]
];

buildings_west = [
	["Land_Cargo_Tower_V1_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V1_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V1_F",0,0,0,GRLIB_perm_log],
	["OPTRE_CTF_Flag_UNSCBlue",0,0,0,0]
];

blufor_squad_inf_light = [
	"OPTRE_UNSC_Marine_Soldier_SquadLead",
	"OPTRE_UNSC_Marine_Soldier_Breacher",
	"OPTRE_UNSC_Marine_Soldier_Grenadier",
	"OPTRE_UNSC_Marine_Soldier_Autorifleman",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_BR",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_AR"
];
blufor_squad_inf = [
	"OPTRE_UNSC_Marine_Soldier_SquadLead",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_BR",
	"OPTRE_UNSC_Marine_Soldier_Autorifleman",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_AR",
	"OPTRE_UNSC_Marine_Soldier_Grenadier",
	"OPTRE_UNSC_Marine_Soldier_Breacher",
	"OPTRE_UNSC_Marine_Soldier_Sniper"
];
blufor_squad_at = [
	"OPTRE_UNSC_Marine_Soldier_SquadLead",
	"OPTRE_UNSC_Marine_Soldier_AT_Specialist",
	"OPTRE_UNSC_Marine_Soldier_AT_Specialist",
	"OPTRE_UNSC_Marine_Soldier_AT_Specialist",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_BR",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_AR"
];
blufor_squad_aa = [
	"OPTRE_UNSC_Marine_Soldier_SquadLead",
	"OPTRE_UNSC_Marine_Soldier_AA_Specialist",
	"OPTRE_UNSC_Marine_Soldier_AA_Specialist",
	"OPTRE_UNSC_Marine_Soldier_AA_Specialist",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_BR",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_AR"
];
blufor_squad_mix = [
	"OPTRE_UNSC_Marine_Soldier_SquadLead",
	"OPTRE_UNSC_Marine_Soldier_TeamLead",
	"OPTRE_UNSC_Marine_Soldier_AA_Specialist",
	"OPTRE_UNSC_Marine_Soldier_AT_Specialist",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_BR",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_AR"
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
  "OPTRE_M313_UNSC"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"OPTRE_M313_UNSC"
];

vehicle_rearm_sources_west = [
	"OPTRE_M313_UNSC"
];

vehicle_big_units_west = [

];

GRLIB_vehicle_whitelist_west = [

];

GRLIB_vehicle_blacklist_west = [

];
