// *** FRIENDLIES ***
// Project OPFOR Ukrainian Armed Forces

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

huron_typename = "LOP_UKR_Mi8MT_Cargo";
FOB_typename = "Land_Cargo_HQ_V1_F";
Respawn_truck_typename = "LOP_UKR_KAMAZ_Medical";  //"rhsusf_m113_usarmy_medical"
//FOB_box_typename = "B_Slingload_01_Cargo_F";
//FOB_truck_typename = "B_Truck_01_box_F";
pilot_classname = "LOP_UKR_Infantry_crew";
crewman_classname = "LOP_UKR_Infantry_crew";
A3W_BoxWps = "rhsgref_weapons_crate";  	 //"rhs_weapon_crate";
chimera_vehicle_overide = [
  ["B_Heli_Light_01_F", "RHS_MELB_MH6M"],
  ["B_Heli_Transport_01_F", "RHS_UH60M_d"]
];


// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units_west = [
	["Alsatian_Random_F",0,0,0,GRLIB_perm_max],
	["Fin_random_F",0,0,0,0],
	["LOP_UKR_Infantry_Rifleman",1,0,0,0],
	["LOP_UKR_Infantry_medic",1,0,0,0],
	["LOP_UKR_Infantry_engineer",1,0,0,0],
	["LOP_UKR_Infantry_Grenadier",1,0,0,GRLIB_perm_inf],
	["LOP_UKR_Infantry_Marksman",1,0,0,GRLIB_perm_inf],
	["LOP_UKR_Infantry_LAT",1,0,0,0],
	["LOP_UKR_Infantry_AR",1,0,0,GRLIB_perm_inf],
	["LOP_UKR_Infantry_AA",1,0,0,GRLIB_perm_log],
	[crewman_classname,1,0,0,GRLIB_perm_inf],
	[pilot_classname,1,0,0,GRLIB_perm_log]
];

units_loadout_overide = [];

// *** RESISTANCE - Private Military Company ***
resistance_squad = [
"LOP_PMC_Infantry_AA",
"LOP_PMC_Infantry_AT_Asst",
"LOP_PMC_Infantry_AT",
"LOP_PMC_Infantry_EOD",
"LOP_PMC_Infantry_Marksman",
"LOP_PMC_Infantry_Rifleman_2",
"LOP_PMC_Infantry_GL",
"LOP_PMC_Infantry_MG_Asst",
"LOP_PMC_Infantry_MG",
"LOP_PMC_Infantry_Rifleman_3",
"LOP_PMC_Infantry_Rifleman",
"LOP_PMC_Infantry_Corpsman",
"LOP_PMC_Infantry_Marksman_2",
"LOP_PMC_Infantry_Rifleman_4",
"LOP_PMC_Infantry_Engineer",
"LOP_PMC_Infantry_Cam",
"LOP_PMC_Infantry_Crewman",
"LOP_PMC_Infantry_SL",
"LOP_PMC_Infantry_TL"
];

light_vehicles = [
	["B_Boat_Transport_01_F",1,25,1,GRLIB_perm_inf],
	["B_Boat_Armed_01_minigun_F",5,30,5,GRLIB_perm_log],
	["LOP_UKR_UAZ",1,0,5,0],
	["LOP_UKR_UAZ_DshKM",1,30,5,GRLIB_perm_inf],
	["LOP_UKR_UAZ_AGS",1,40,5,GRLIB_perm_log],
	["LOP_UKR_UAZ_SPG",1,50,5,GRLIB_perm_log]
];

heavy_vehicles = [
	["LOP_UKR_BTR60",10,100,20,GRLIB_perm_log],
	["LOP_UKR_BTR70",10,125,20,GRLIB_perm_log],
	["LOP_UKR_BTR80",10,150,20,GRLIB_perm_log],
	["LOP_UKR_BMD1",15,200,20,GRLIB_perm_tank],
	["LOP_UKR_BMD2",15,200,20,GRLIB_perm_tank],
	["LOP_UKR_BMP1",15,250,20,GRLIB_perm_tank],
	["LOP_UKR_BMP2",15,250,20,GRLIB_perm_tank],
	["LOP_UKR_ZSU234",20,300,20,GRLIB_perm_tank],
	["LOP_UKR_BM21",20,400,20,GRLIB_perm_air],
	["LOP_UKR_2S1",20,400,20,GRLIB_perm_max],
	["LOP_UKR_T72BB",30,1000,30,GRLIB_perm_max]
];

air_vehicles = [
	["RHS_MELB_MH6M",10,20,15,GRLIB_perm_tank],
	["RHS_MELB_AH6M",10,50,15,GRLIB_perm_air],
	["RHS_UH60M",10,80,20,GRLIB_perm_air],
	["LOP_UKR_Mi24V_FAB",10,500,20,GRLIB_perm_air],
	["LOP_UKR_Mi24V_AT",10,500,20,GRLIB_perm_max],
	["LOP_UKR_Mi24V_UPK23",10,500,20,GRLIB_perm_max],
	["LOP_UKR_Mi8MTV3_FAB",15,600,20,GRLIB_perm_max],
	["LOP_UKR_Mi8MTV3_UPK23",15,600,20,GRLIB_perm_max]
];

blufor_air = [
	"LOP_UKR_Mi24V_AT",
	"LOP_UKR_Mi24V_FAB",
	"LOP_UKR_Mi24V_UPK23",
	"LOP_UKR_Mi8MTV3_FAB",
	"LOP_UKR_Mi8MTV3_UPK23"
];

boats_west = [
  	"B_Boat_Transport_01_F",
	"B_Boat_Armed_01_minigun_F",
	"B_T_Boat_Armed_01_minigun_F"
];

static_vehicles = [
	["LOP_UKR_AGS30_TriPod",0,50,0,GRLIB_perm_log],
	["LOP_UKR_Static_DSHKM",0,50,0,GRLIB_perm_log],
	["LOP_UKR_Kord_High",0,50,0,GRLIB_perm_log],
	["LOP_UKR_Static_AT4",0,100,0,GRLIB_perm_tank],
	["LOP_UKR_Igla_AA_pod",0,150,0,GRLIB_perm_tank],
	["LOP_UKR_Static_SPG9",0,150,0,GRLIB_perm_max],
	["LOP_UKR_ZU23",0,300,0,GRLIB_perm_max],
	["LOP_UKR_Static_D30",0,400,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
];

support_vehicles_west = [
	["LOP_UKR_KAMAZ_Repair",5,15,10,GRLIB_perm_inf],
	["LOP_UKR_KAMAZ_Fuel",5,15,10,GRLIB_perm_inf],
	["LOP_UKR_KAMAZ_Ammo",5,15,10,GRLIB_perm_tank],
	["rhs_launcher_crate",0,150,0,GRLIB_perm_tank]    //  rhsusf_launcher_crate
];

buildings_west = [
	["Land_Cargo_Tower_V1_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V1_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V1_F",0,0,0,GRLIB_perm_log],
	["Land_LampStreet_small_F",0,0,0,0],
	["lop_Flag_ukr_F",0,0,0,0]
];

blufor_squad_inf_light = [
"LOP_UKR_Infantry_sergeant",
"LOP_UKR_Infantry_medic",
"LOP_UKR_Infantry_Marksman",
"LOP_UKR_Infantry_Rifleman",
"LOP_UKR_Infantry_Light",
"LOP_UKR_Infantry_LAT",
"LOP_UKR_Infantry_AR"
];
blufor_squad_inf = [
"LOP_UKR_Infantry_officer",
"LOP_UKR_Infantry_Marksman",
"LOP_UKR_Infantry_Rifleman",
"LOP_UKR_Infantry_LAT",
"LOP_UKR_Infantry_RShG2",
"LOP_UKR_Infantry_AR",
"LOP_UKR_Infantry_AR_Asst",
"LOP_UKR_Infantry_engineer",
"LOP_UKR_Infantry_AR"
];
blufor_squad_at = [
"LOP_UKR_Infantry_sergeant",
"LOP_UKR_Infantry_RPG",
"LOP_UKR_Infantry_LAT",
"LOP_UKR_Infantry_RShG2",
"LOP_UKR_Infantry_RPG",
"LOP_UKR_Infantry_AR",
"LOP_UKR_Infantry_Grenadier",
"LOP_UKR_Infantry_engineer",
"LOP_UKR_Infantry_medic",
"LOP_UKR_Infantry_Rifleman",
"LOP_UKR_Infantry_Light"
];
blufor_squad_aa = [
"LOP_UKR_Infantry_sergeant",
"LOP_UKR_Infantry_AR",
"LOP_UKR_Infantry_AR",
"LOP_UKR_Infantry_RPG",
"LOP_UKR_Infantry_AA",
"LOP_UKR_Infantry_AA",
"LOP_UKR_Infantry_AR"
];

blufor_squad_mix = [
"LOP_UKR_Infantry_sergeant",
"LOP_UKR_Infantry_Marksman",
"LOP_UKR_Infantry_medic",
"LOP_UKR_Infantry_RPG",
"LOP_UKR_Infantry_AA",
"LOP_UKR_Infantry_engineer",
"LOP_UKR_Infantry_AR"
];

squads = [
	[blufor_squad_inf_light,10,300,0,GRLIB_perm_max],
	[blufor_squad_inf,20,400,0,GRLIB_perm_max],
	[blufor_squad_at,25,600,0,GRLIB_perm_max],
	[blufor_squad_aa,25,700,0,GRLIB_perm_max],
	[blufor_squad_mix,25,800,0,GRLIB_perm_max]
];

// All the UAVs must be declared here
uavs = [
];

// Everything the AI troups should be able to resupply from
ai_resupply_sources_west = [
  "LOP_UKR_KAMAZ_Ammo","LOP_UKR_KAMAZ_Fuel"
];

// Everything the AI troups should be able to healing from
ai_healing_sources_west = [
	"LOP_UKR_KAMAZ_Medical","LOP_UKR_Ural","LOP_UKR_Ural_open"
];

vehicle_rearm_sources_west = [
	"LOP_UKR_KAMAZ_Ammo","LOP_UKR_KAMAZ_Fuel"
];

vehicle_big_units_west = [

];

GRLIB_vehicle_whitelist_west = [

];

GRLIB_vehicle_blacklist_west = [

];

GRLIB_AirDrop_1 = [		// cost = 50 Unarmed Offroad
	"LOP_UKR_UAZ"
];

GRLIB_AirDrop_2 = [		// cost 100 Armed Offroader
	"LOP_UKR_UAZ_DshKM"
];

GRLIB_AirDrop_3 = [		// cost 200 MRAPs (Mine Resistant Ambush Protected Vehicle)
	"LOP_UKR_BTR60"
];

GRLIB_AirDrop_4 = [		// cost 300 Large Truck
	"LOP_UKR_Ural"
];

GRLIB_AirDrop_5 = [		// cost 750 APC (Armoured personnel carrier)
	"LOP_UKR_BMD2"
];


GRLIB_AirDrop_6 = [		// cost 250 Boat
	"B_Boat_Transport_01_F"
];

// GRLIB_AirDrop_7 = [];		// cost 2000 Air Superiority
