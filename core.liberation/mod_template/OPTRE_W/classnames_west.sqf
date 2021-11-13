// *** FRIENDLIES ***
GRLIB_side_friendly = WEST;
GRLIB_color_friendly = "ColorBLUFOR";

// Default classname: scripts\shared\default_classnames.sqf
// Advanced definition: scripts\shared\classnames.sqf

FOB_typename = "Land_ArmoryA_Green";
Arsenal_typename = "OPTRE_Ammo_Rack_Weapons";
Respawn_truck_typename = "OPTRE_M313_UNSC";
commander_classname = "OPTRE_UNSC_ODST_Soldier_TeamLeader";
pilot_classname = "OPTRE_UNSC_Army_Soldier_Crewman_OLI";
crewman_classname = "OPTRE_UNSC_Airforce_Soldier_Airman";
huron_typename = "OPTRE_Pelican_unarmed";
PAR_Medikit = "OPTRE_MedKit";
PAR_AidKit = "OPTRE_Biofoam";
A3W_BoxWps = "OPTRE_Ammo_Rack_Ammo";

// [CLASSNAME, MANPOWER, AMMO, FUEL, RANK]
infantry_units = [
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
	["OPTRE_UNSC_ODST_Soldier_Marksman",1,0,0,GRLIB_perm_log],
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
	["B_Boat_Armed_01_minigun_F",5,30,5,GRLIB_perm_log],
	["OPTRE_M12_FAV",2,25,2,0],
	["OPTRE_M813_TT",1,10,1,0],
	["OPTRE_M914_RV",5,100,2,GRLIB_perm_inf],
	["OPTRE_M12_LRV",5,100,2,GRLIB_perm_inf],
	["OPTRE_M12G1_LRV",5,125,2,GRLIB_perm_log],
	["OPTRE_M12R_AA",5,125,2,GRLIB_perm_log],
	["B_Truck_01_transport_F",5,30,5,GRLIB_perm_log],
	["B_Truck_01_covered_F",5,30,5,GRLIB_perm_log],
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
	["B_UAV_06_F",1,30,5,GRLIB_perm_tank],
	["B_UAV_02_F",5,1000,5,GRLIB_perm_air],
	["B_T_UAV_03_F",5,1500,10,GRLIB_perm_max],
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
	["B_UGV_02_Demining_F",0,5,0,GRLIB_perm_inf],
	["B_Static_Designator_01_F",0,5,0,GRLIB_perm_inf],
	["B_HMG_01_F",0,10,0,GRLIB_perm_log],
	["B_HMG_01_high_F",0,10,0,GRLIB_perm_tank],
	["B_GMG_01_F",0,20,0,GRLIB_perm_log],
	["B_GMG_01_high_F",0,20,0,GRLIB_perm_tank],
	["B_static_AA_F",0,50,0,GRLIB_perm_air],
	["B_static_AT_F",0,50,0,GRLIB_perm_air],
	["B_Mortar_01_F",0,500,0,GRLIB_perm_max],
	["B_AAA_System_01_F",10,500,0,GRLIB_perm_max],
	["B_Ship_Gun_01_F",10,1500,0,GRLIB_perm_max]
];

// *** Static Weapon with AI ***
static_vehicles_AI = [
	"B_SAM_System_01_F",
	"B_SAM_System_02_F",
	"B_AAA_System_01_F"
];

support_vehicles_west = [
	["OPTRE_cart",5,15,5,GRLIB_perm_inf],
	["OPTRE_forklift",5,15,5,GRLIB_perm_inf]
];

buildings_west = [
	["Land_Cargo_Tower_V1_F",0,0,0,GRLIB_perm_tank],
	["Land_Cargo_House_V1_F",0,0,0,GRLIB_perm_inf],
	["Land_Cargo_Patrol_V1_F",0,0,0,GRLIB_perm_log],
	["Flag_NATO_F",0,0,0,0]
];

if ( isNil "blufor_squad_inf_light" ) then { blufor_squad_inf_light = [] };
if ( count blufor_squad_inf_light == 0 ) then { blufor_squad_inf_light = [
	"OPTRE_UNSC_Marine_Soldier_SquadLead",
	"OPTRE_UNSC_Marine_Soldier_Breacher",
	"OPTRE_UNSC_Marine_Soldier_Grenadier",
	"OPTRE_UNSC_Marine_Soldier_Autorifleman",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_BR",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_AR"
	];
};
if ( isNil "blufor_squad_inf" ) then { blufor_squad_inf = [] };
if ( count blufor_squad_inf == 0 ) then { blufor_squad_inf = [
	"OPTRE_UNSC_Marine_Soldier_SquadLead",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_BR",
	"OPTRE_UNSC_Marine_Soldier_Autorifleman",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_AR",
	"OPTRE_UNSC_Marine_Soldier_Grenadier",
	"OPTRE_UNSC_Marine_Soldier_Breacher",
	"OPTRE_UNSC_Marine_Soldier_Sniper"
	];
};
if ( isNil "blufor_squad_at" ) then { blufor_squad_at = [] };
if ( count blufor_squad_at == 0 ) then { blufor_squad_at = [
	"OPTRE_UNSC_Marine_Soldier_SquadLead",
	"OPTRE_UNSC_Marine_Soldier_AT_Specialist",
	"OPTRE_UNSC_Marine_Soldier_AT_Specialist",
	"OPTRE_UNSC_Marine_Soldier_AT_Specialist",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_BR",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_AR"
	];
};
if ( isNil "blufor_squad_aa" ) then { blufor_squad_aa = [] };
if ( count blufor_squad_aa == 0 ) then { blufor_squad_aa = [
	"OPTRE_UNSC_Marine_Soldier_SquadLead",
	"OPTRE_UNSC_Marine_Soldier_AA_Specialist",
	"OPTRE_UNSC_Marine_Soldier_AA_Specialist",
	"OPTRE_UNSC_Marine_Soldier_AA_Specialist",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_BR",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_AR"
	];
};
if ( isNil "blufor_squad_mix" ) then { blufor_squad_mix = [] };
if ( count blufor_squad_mix == 0 ) then { blufor_squad_mix = [
	"OPTRE_UNSC_Marine_Soldier_SquadLead",
	"OPTRE_UNSC_Marine_Soldier_TeamLead",
	"OPTRE_UNSC_Marine_Soldier_AA_Specialist",
	"OPTRE_UNSC_Marine_Soldier_AT_Specialist",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_BR",
	"OPTRE_UNSC_Marine_Soldier_Rifleman_AR"
	];
};
if ( isNil "blufor_squad_recon" ) then { blufor_squad_recon = [] };
if ( count blufor_squad_recon == 0 ) then { blufor_squad_recon = [
	"OPTRE_UNSC_Marine_Soldier_SquadLead",
	"OPTRE_UNSC_Marine_Soldier_ForwardObserver",
	"OPTRE_UNSC_Marine_Soldier_Autorifleman",
	"OPTRE_UNSC_Marine_Soldier_Sniper",
	"OPTRE_UNSC_Marine_Soldier_Marksman",
	"OPTRE_UNSC_Marine_Soldier_Marksman",
	"OPTRE_UNSC_Marine_Soldier_Marksman"
	];
};

squads = [
	[blufor_squad_inf_light,10,300,0,GRLIB_perm_max],
	[blufor_squad_inf,20,400,0,GRLIB_perm_max],
	[blufor_squad_recon,25,500,0,GRLIB_perm_max],
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

box_transport_config_west = [

];
